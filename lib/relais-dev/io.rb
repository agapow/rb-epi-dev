#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Home for {Relais::Dev:Io} module.
#
# Import this file to load {Relais::Dev:Io}.

### IMPORTS

### IMPLEMENTATION

module Relais
	module Dev
		
		# Simplified and consistent input and output.
		#
		# Together, the Ruby standard and third-party libraries present a cacophony of 
		# idioms for reading and writing data: methods that accept only IO objects or 
		# data strings or file paths, IO objects that automatically close or not, IO objects 
		# that are created explicitly or implicitly ... see the standard CSV module for 
		# an example of this mess. Relais::Dev::IO unifies these in a consistent set 
		# of idioms that should be quick to use and easy to remember. In summary:
		#
		# * IO is encapsulated in reader and writer objects. 
		# * Readers and Writers are constructed with either open IO objects or
		#   filepaths. Filepaths are opened and closed automatically.
		# * Data is passed via "read" and "write" methods. For convenience, readers
		#   have methods that accept blocks to which they can pass data.
		# * IO is explicitly concluded with a `finish` method.
		# * For convenience, readers and writers have a `use_with` class method that
		#   creates the reading/writing object, passes it to a block for the user to
		#   capture/pass the data and closes it up afterwards, effectively wrapping the
		#   lifecycle.
		# * For similar convenience, "quick" methods are provided which wrap the
		#   reader/writer lifecycle, capturing/passing the data in one pass.
		# * Reasonable default arguments are provided that be suitable for most cases
		#   and so not need to be explicitly specified.
		# * Developer should subclass the bases provided to save work and to provide a
		#   consistent interface.
		#
		# @example
		#   # simple data reading, path is opened and closed
		#   rdr = BaseReader('file/path', {:mode=>'rb'})
		#   data = rdr.read()
		#   rdr.finish()
		#
		#   # pass open IO object instead
		#   hndl = File.open('file/path', {:mode=>'rb'})
		#   rdr = BaseReader(hndl)
		#
		#   # simpler
		#   rdr = BaseReader('file/path')
		#   ...
		#
		#   # even simpler
		#   BaseReader::use_with('file/path') { |rdr|
		#      # do something with data ...
		#   }
		#
		#   # simplest
		#   data = quick_read('file/path')
		#
		#   # equivalent write calls
		#   wrtr = BaseWriter('file/path', {:mode=>'wb'})
		#   wrtr.write(data)
		#   wrtr.finish()
		#
		#   # or ...
		#   quick_write('file/path', data)
		#
		module Io
		end
	end
end


# submodules that we provide
Dir['relais-dev/io/*.rb'].sort.each { |lib| require lib }


### END

