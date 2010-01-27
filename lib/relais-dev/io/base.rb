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

module Relais
	module Dev
		module IO
		
			class BaseIO
		
				attr_accessor(:hndl, :file_open)
		
				def initialize(io_or_path, mode)
					# TODO: what if it's a Pathname?
		
					# if passed a filepath, open it
					is_path = (io_or_path.class == String)
					if is_path
						@hndl = File.open(io_or_path, mode)
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
					@hndl.close()
					@file_open = false
				end
		
				# Create an IO object, pass it for use and then finish it off.
				#
				# This allows easy use of an IO object within a block.
				#
				def self.use_with(io_or_path, opts={}, &block)
					io = BaseIO.new(io_or_path, opts)
					result = block.call(io)
					io.finish()
					return result
				end
			end

		
			class BaseWriter < BaseIO
				# ???: what sort fo write interface do we need
		
				def initialize(io_or_path, opts={})
					options = defaults(
						:mode => 'rb'
					).merge(opts)
					super(io_or_path, mode)
				end

			end
	
	
			class BaseReader < BaseIO
				# TODO: add enumerable interface
				# TODO: use each and enumerable for reading
		
				def initialize(io_or_path, opts={})
					options = defaults(
						:mode => 'wb'
					).merge(opts)
					super(io_or_path, opts)
				end
		
				# Return entire contents of IO object.
				#
				def read(&block)
					
				end
		
			end

		
			class RecordReader < BaseReader
				# ???: should 'read' alias to 'read_all' or vice versa
				
				def read_record(row)
					# TODO: throw unimplemented 	
				end
		
				def >>(row)
					read_record(row)
				end
		
				# Read every record and pass it to the block
				def read_each(&block)
		
				end
		
				# Return an array of every record
				def read_all()
					return [].collect
		
				end
		
				def read()
					return read_all
				end
		
			end
		
			class RecordWriter < BaseWriter
				
			end

			
			class LineReader < RecordReader

				def read_record()

				end

				alias read_line read_record

			end


			class LineWriter < RecordWriter

				def write_record()

				end

				alias write_line write_record

			end
				

		end
	end
end


### END
