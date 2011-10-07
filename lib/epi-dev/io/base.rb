#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Base classes for readers and writers.
#
# Sometimes you jump want to dump data to a file or just slurp it out. These
# functions let you do that. All of the "quick" functions accept IO objects or
# filepaths (which they automatically open and close). 
#
# @example
#   data = quick_read('file/path')


### IMPORTS

require 'relais-dev/common'


### IMPLEMENTATION

module Epi
	module Dev
		module Io
		
			RDC = Epi::Dev::Common
			
			DELIMITER_POSN = FixedStruct.new(
				:BEFORE => 'before',
				:AFTER => 'after',
				:BETWEEN =>  'between',
				:AROUND => 'around'
			)
			
			class BaseIo
		
				attr_accessor(:hndl, :file_open)

				def initialize(io_or_path, kwargs={})
					# TODO: what if it's a Pathname?
					# Setting mode as nil may seem peculiar, but it's only needed if
					# a path is passed in. But if a path is used, then we should not
					# guess what the the user means, so they must specify one.
					options = {
						:mode => nil,
					}.update(kwargs)
					# if passed a filepath, open it
					is_path = (io_or_path.class == String)
					if is_path
						@hndl = File.open(io_or_path, options[:mode])
						@file_open = true
					else
						@hndl = io_or_path
						@file_open = false
					end
					prepare()
				end

				# Destructor.
				# 
				# This simply ensures that any file opened by object is closed.
				#
				def finalize()
					if @file_open
						@hndl.close()
					end
				end

				# Do any necessary setup to commence IO.
				#
				# This is called from the constructor to handle anything that has to
				# be done in preparation for IO. Currently it does nothing but
				# specialised subclasses may have to override this to handle header
				# information opening tags, etc.
				#
				def prepare()
					# to be overridden in subclasses
				end

				# Do any necessary teardown to complete IO.
				#
				# Currently all this does is close any file handle that is opened by the
				# IO object. However specialised subclasses may have to override
				# this to handle footer information or terminating tags, etc.
				#
				def finish()
					if @file_open
						@hndl.close()
						@file_open = false
					end
				end

				# Create an IO object, pass it for use and then finish it off.
				#
				# This allows easy use of an IO object within a block.
				#
				def self.with(io_or_path, opts={}, &block)
					io = new(io_or_path, opts)
					result = block.call(io)
					io.finish()
					return result
				end
			end


			class Reader < BaseIo
				# TODO: add enumerable interface
				# TODO: use each and enumerable for reading
			
				def initialize(io_or_path, opts={})
					options = {
						:mode => 'wb'
					}.update(opts)
					super(io_or_path, opts)
				end
		
				# Return entire contents of IO object.
				#
				def read(opts={})
					options = {
						:length => nil   # nil means read all
					}.update(opts)
					return @hndl.read(options[:length])
				end
			
			end


			class Writer < BaseIo
				# ???: what sort of write interface do we need

				def initialize(io_or_path, opts={})
					options = {
						:mode => 'wb'
					}.update(opts)
					super(io_or_path, options)
				end

				# Return entire contents of IO object.
				#
				def write(data)
					return @hndl.write(data)
				end
				
			end


			class RecordReader < Reader
				
				attr_accessor(:delimiter)
				
				def initialize(io_or_path, delimiter, opts={})
					@delimiter = delimiter
					super(io_or_path, opts)
				end
				
				def record_number
					return hndl.lineno
				end
				
				# Read the next record from the source.
				#
				# @return the next record or nil if at the end of the source
				#
				def read_record()
					# gets can handle a lot of different splits, but more complicated
					# cases will have to by overriding this
					if (rec = hndl.gets(@delimiter))
						rec = decode_record(rec)
					end
					return rec
				end
				
				# Converts records from their storage format to thie code format.
				#
				# To be overridden in subclasses.
				#
				def decode_record(rec)
					return rec.chomp(@delimiter)
				end
				
				def read_all_records()
					all_recs = []
					read_records_using { |rec| all_recs << rec }
					return all_recs
				end
				
				def read_records_using(&block)
					# NOTE: there is the temptation to write 'with_read_each_using'
					# and related methods but they can be constructed by nesting
					# a "using" inside a "with"
					while (rec = read_record())
						block.call(rec)
					end
				end
			
				alias read_each read_records_using
				alias read read_all_records
		
			end
		
			# The interface for record writers is much thinner than that for
			# record readers, because in functional style the looping the writer is
			# a client ("for each of these, write a record") while the reader
			# controls the loop ("for each record read, do this").
			#
			class RecordWriter < Writer
				# TODO: delimiter?
				
				attr_accessor(:delimiter, :delimiter_posn)
				
				def initialize(io_or_path, delimiter, opts={})
					@delimiter_posn = opts.delete(:delimiter_posn) or DELIMITER_POSN.BETWEEN
					super(io_or_path, opts)
				end
				
				# Write a record to the source.
				#
				def write_record(rec)
					# gets can handle a lot of different splits, but more complicated
					# cases will have to by overriding this
					return hndl.write(encode_record(rec))
				end
				
				# Produces a representation of the record suitable for writing.
				def encode_record(rec)
					return rec
				end
				
				def write_records(en)
					en.each {
						write_record(rec)
					}
				end
			
				alias write write_records
				
			end


			class LineReader < RecordReader

				def initialize(io_or_path, opts={})
					super(io_or_path, $/, opts)
				end
				
				# Converts records from their storage format to thie code format.
				#
				# To be overridden in subclasses.
				#
				def decode_record(rec)
					return rec.chomp!()
				end
			
				alias read_line read_record
				alias read_each_line read_each
				alias read_lines_using read_records_using
				alias read_all_lines read_all_records

			end


			class LineWriter < RecordWriter

				def encode_record(rec)
					return rec + $/
				end

				alias write_line write_record
				alias write_lines write_records

			end

			class ParagraphReader < RecordReader

				def initialize(io_or_path, opts={})
					super(io_or_path, '', opts)
				end
			
				alias read_each_paragraph read_each
				alias read_paragraphs_using read_records_using
				alias read_all_paragraphs read_all_records

			end


			class ParagraphWriter < RecordWriter

				def encode_record(rec)
					return rec + $/ + $/
				end

				alias write_paragraph write_record

			end
		end
	end
end


### END
