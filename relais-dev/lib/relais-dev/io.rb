
module IO

	def quick_read (io_or_path, mode='r')
		rdr = BaseReader.new(io_or_path, mode)
		data = rdr.hndl.read()
		rdr.close()
		return data
	end

	def quick_write (data, io_or_path, mode='w')
		wrtr = BaseWriter.new(io_or_path, mode)
		wrtr.hndl.write(data)
		wrtr.close()
		return nil
	end

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

		# Do any necessary teardown to finish IO
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

	# Read and return the passed object, opening and lcosing if necessary.
	#
	# @param [#read, String] a readable object or a filepath (String)
   # @param [String] the reading mode, by default 'r'
	#
	# This is a convenience function for a one-liner that sucks the contents
	# from a file or similar object.
	#
	def quick_read (io_or_path, mode='r')
		rdr = BaseReader.new(io_or_path, mode)
		data = rdr.hndl.read()
		rdr.close()
		return data
	end

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

