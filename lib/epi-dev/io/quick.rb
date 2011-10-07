#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Quick-and-dirty IO.
#
# Sometimes you just want to dump data to a file or just slurp it out. These
# functions let you do that. All of the "quick" functions accept IO objects or
# filepaths (which they automatically open and close). 
#
# @example
#   data = quick_read('file/path')


### IMPORTS

require 'relais-dev/io/base'
require 'relais-dev/common'



### IMPLEMENTATION

module Epi
	module Dev
		module Io

			RBC = Epi::Dev::Common

			# Read the contents of the passed object, opening and closing if required.
			#
			# @param [#read, String] io_or_path  A readable object or a filepath
			#    (String).
			# @param [Hash] opts  A hash of optional arguments.
			#
			# @return The data in the file.
			#
			# @see Reader
			#
			# This is a convenience function, allowing simple one-liners that read
			# the contents of a file or similar object. It accepts all the
			# arguments and behaves like using a {Reader} to extract data. 
			#
			# @example
			#    data = quick_read('foo.txt')
			#
			#    hndl = File.open('bar.txt', 'rb')
			#    data = File.open(hndl)
			#    hndl.close()
			#
			def quick_read(io_or_path, opts={})
				# TODO: replace with "use_with"?
				rdr = Reader.new(io_or_path, opts)
				data = rdr.hndl.read()
				rdr.close()
				return data
			end


			# Read the contents of the passed object with the selected reader.
			#
			# @param [Reader] reader_cls  A {Reader} subclass.
			# @param [#read, String] io_or_path  A readable object or a filepath
			#    (String).
			# @param [Hash] opts  A hash of optional arguments.
			#
			# @return The data in the file.
			#
			# @see quick_read
			#
			# This is a convenience function, allowing simple one-liners that read
			# the contents of a file or similar object. It accepts all the
			# arguments and behaves like using a {Reader} to extract data. 
			#
			# @example
			#    data = quick_read('foo.txt')
			#
			#    hndl = File.open('bar.txt', 'rb')
			#    data = File.open(hndl)
			#    hndl.close()
			#
			def quick_read_using (reader_cls, io_or_path, opts)
				rdr = reader_cls.new(io_or_path, opts)
				data = rdr.hndl.read()
				rdr.close()
				return data
			end


			# @param [#read, String] io_or_path  A readable object or a filepath
			#    (String).
			# @param [Hash] opts  A hash of optional arguments.
			#
			# @return The data in the file.
			#
			# @see Reader
			#
			# This is a convenience function, allowing simple one-liners that read
			# the contents of a file or similar object. It accepts all the
			# arguments and behaves like using a {Reader} to extract data. 
			#
			# @example
			#    data = quick_read('foo.txt')
			#
			#    hndl = File.open('bar.txt', 'rb')
			#    data = File.open(hndl)
			#    hndl.close()
			#
			def quick_write (io_or_path, mode='r')
				rdr = Reader.new(io_or_path, mode)
				data = rdr.hndl.read()
				rdr.close()
				return data
			end


			# Read the contents of the passed object, opening and closing if required.
			#
			# @param [#read, String] io_or_path  A readable object or a filepath
			#    (String).
			# @param [String] mode  The reading mode, by default 'r'.
			#
			# @return The data in the file. 
			#
			# This is a convenience function, allowing simple one-liners that read the
			# contents of a file or similar object. If a string is passed, it is
			# assumed to be a filepath, which is opened, read and closed. All other 
			# objects are presumed to be "readable".
			#
			# @example
			#    data = quick_read('foo.txt')
			#
			#    hndl = File.open('bar.txt', 'rb')
			#    data = File.open(hndl)
			#    hndl.close()
			#
			def quick_read (io_or_path, mode='r')
				rdr = Reader.new(io_or_path, mode)
				data = rdr.hndl.read()
				rdr.close()
				return data
			end

		end
	end
end


### END
