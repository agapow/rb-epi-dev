# so here's the idea for the io idiom:
# * every io object was a class method "use_with" that passes itself to the
# block
# * every reader has a iterator method that passes records one-by-one to the
# block
# * every writer was a iterator method that accepts results from block (how do
# we loop appropriate time?
#
# So:
#    MyReader.use_with('file/path', 'rb') { |rdr|
#      rdr.each_record { |rec|
#         ...
#      }
#    } 


require 'pathname'

module Relais
	module Dev
		module IO

	class BaseIO
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
		# This simply ensures that any open file is closed.
		#
		def finalize()
			if @file_open
				@hndl.close()
			end	
		end

		# Do any necessary setup to commence IO.
		#
		# Currently all this does is close any file handle that is opened by the
		# IO object.
		#
		def prepare()
			@hndl.close()
			@file_open = false
		end
		
		# Do any necessary teardown to finish IO.
		#
		# Currently all this does is close any file handle that is opened by the
		# IO object.
		#
		def finish()
			@hndl.close()
			@file_open = false
		end

		# Create an IO object, pass it for use and then finish it off.
		#
		# This allows easy use of an IO object within a block.
		#
		def self.use_with(io_or_path, mode, &block)
			io = BaseIO.new(io_or_path, mode)
			# TODO: pass io to block
			io.finish
		end
	end

	class BaseWriter < BaseIO
		# ???: what sort fo write interface do we need

		def initialize(io_or_path, mode='w')
			super.initialize(io_or_path, mode)
		end
	end

	class BaseReader < BaseIO
		# TODO: add enumerable interface
		# TODO: use each and enumerable for reading

		def initialize(io_or_path, mode='r')
			super.initialize(io_or_path, mode)
		end
	end

	# Read the contents of the passed object, opening and closing if required.
	#
	# @param [#read, String] io_or_path  A readable object or a filepath
	#    (String).
   # @param [String] mode  The reading mode, by default 'r'.
	#
	# @returns The data in the file. 
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
		rdr = BaseReader.new(io_or_path, mode)
		data = rdr.hndl.read()
		rdr.close()
		return data
	end

	# Write data to the passed object, opening and closing if required.
	#
	# @param [#read, String] io_or_path  A writable object or a filepath
	#    (String).
   # @param [String] mode  The writing mode, by default 'w'.
	#
	# @returns The data in the file. 
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
	def quick_write (data, io_or_path, mode='w')
		wrtr = BaseWriter.new(io_or_path, mode)
		wrtr.hndl.write(data)
		wrtr.close()
		return nil
	end
	
	class CsvWriter
	end

	class CsvReader
	end

		end
	end
end

