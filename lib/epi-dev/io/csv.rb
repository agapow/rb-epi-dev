#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Consistent handling of CSV files.
#
# The standard CSV module is a bit of a mess (e.g. blocking use of "new", but
# providing "create" instead.) This cleans up the interface into something more
# rational.
#
# @example
#   # simple data reading, path is opened and closed
#   rdr = Reader('file/path', {:mode=>'rb'})
#   data = rdr.read()
#   rdr.finish()
#
#   # pass open IO object instead
#   hndl = File.open('file/path', {:mode=>'rb'})
#   rdr = Reader(hndl)
#
#   # simpler
#   rdr = Reader('file/path')
#   ...
#
#   # even simpler
#   Reader::use_with('file/path') { |rdr|
#      # do something with data ...
#   }
#
#   # simplest
#   data = quick_read('file/path')


### IMPORTS

require 'relais-dev/io/base'


### IMPLEMENTATION

module Epi
	module Dev
		module I0
		
			class CsvWriter < RecordWriter
		
				def initialise(opts={})
					@options = default_options(
						:header => false,
						:mode => 'rb'
					).update(opts)
					@header_len = @options.header ? @options.header.length: nil
					# TODO: cal to super
				end
		
				def prepare()
					@csv_writer = CSV::Writer.create(@hndl)
				end
		
				def finish()
					@csv_writer.close()
				end
		
				def write_record(row)
					@csv_writer << row
				end
		
				def <<(row)
					write_record(row)
				end
		
			end
		
		
			class CsvReader < RecordReader
		
				def prepare()
					@csv_writer = CSV::Writer.create(@hndl)
				end
		
				def finish()
					@csv_writer.close()
				end
		
				def read_record(row)
					@csv_writer << row
				end
		
			end

		end
	end
end

