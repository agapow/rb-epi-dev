#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Support for ubiquitous development tricks and idioms.
#
# Together, the Ruby standard and third-party libraries present a cacophony of 
# idioms for reading and writing data: methods that accept only IO objects or
# data strings or file paths, IO objects that automatically close or not, IO
# objects that are created explicitly or implicitly ... see the standard CSV
# module for an example of this mess. Relais::Dev::IO unifies these in a
# consistent set of idioms that should be quick to use and easy to remember. In
# summary:
#
# * IO is encapsulated in reader and writer objects. 
# * Readers and Writers are constructed with either open IO objects or
#   filepaths. Filepaths are opened and closed automatically.
# * Data is passed via "read" and "write" methods. For convenience, readers have
#   methods that accept blocks to which they can pass data.
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

### IMPORTS

require 'logger'
require 'relais-dev/errors'



### IMPLEMENTATION

# submodules that we provide

# local code
module Relais
	module Dev
		module Debug
			
			RBE = Relais::Dev::Errors
			include Test::Unit::Assertions
			LEVELS = %w(DEBUG INFO WARN ERROR FATAL ANY)
			 
			# Raise an exception unless the passed condition is met
			#
			# @param [Boolean] cond A test that evaulates to a boolean
			# @param [Hash] options An options hash
			# @option options [Exception class] error An exception class, by
			#   default AssertionError
			# @option options [String] error An error message, by default "an
			#   unknown error has occurred" 
			#
			# Assertions are provided within Ruby, but only within the testing
			# frameworks. This method plugs that gap and provides some useful extra
			# functionality, such as specifying error class and message.
			#
			# @example
			#   raise_unless (day_of_month <= 32)
			#   raise_unless (filepath.exists, {:error=>IOError})
			#   raise_unless (denominator != 0, {:msg=>"division by zero!"})
			#
			def raise_unless(cond, opts={})
				# TODO: use globals to set the default err logger and stream
				# TODO: need a better word than 'defaults'
				defaults = {
					:err_class => RBE::AssertionError,
					:msg => "an unknown error has occurred and an exception has been raised",
					:logger => nil,
					:lvl => Logger::ERROR,
					:err_stream => $stderr,
				}.merge(opts)
				unless (cond)
					if defaults[:err_stream]
						print_error(defaults[:msg], 
							{:lvl=>defaults[:lvl], :stream=>defaults[:err_stream]})
					end
					if defaults[:logger]
						log_error(defaults[:msg], defaults[:logger],
							{:lvl=>defaults[:lvl]})	
					end
					raise defaults[:err_class].new(defaults[:msg])
				end
			end
			 
			 
			# Raise an exception unless the passed condition is met
			#
			# @param [Boolean] cond A test that evaulates to a boolean
			# @param [Hash] options An options hash
			# @option options [Exception class] error An exception class, by
			#   default AssertionError
			# @option options [String] error An error message, by default "an
			#   unknown error has occurred" 
			#
			# Assertions are provided within Ruby, but only within the testing
			# frameworks. This method plugs that gap and provides some useful extra
			# functionality, such as specifying error class and message.
			#
			# @example
			#   raise_unless (day_of_month <= 32)
			#   raise_unless (filepath.exists, {:error=>IOError})
			#   raise_unless (denominator != 0, {:msg=>"division by zero!"})
			#
			def die_unless(cond, opts={})
				defaults = {
					:ret_code => -1,
					:msg => "an unknown error has occurred and the program will exit",
					:logger => nil,
					:lvl => Logger::FATAL,
					:err_stream => $stderr,
				}.merge(opts)
				unless (cond)
					if defaults[:err_stream]
						print_error(msg, {:lvl=>lvl, :stream=>stream})
					end
					if defaults[:logger]
						log_error(msg, logger, {:lvl=>lvl})	
					end
					exit(ret_code)	
				end
			end
			 
			 
			# Print an error message to a stream.
			#
			# @private
			#
			# @param [String, #to_s] msg An error message to report
			# @param [Hash] options
			# @option options [IO] stream The stream to send the message to, by
			#   default STDERR.
			# @option options [#to_s] lvl The error level, usually a logging level
			#   but possibly a descriptive string, Logger::ERROR by default.
			#
			# This is just an internal helper function, to send an message to the
			# screen in the events of errors. It is used by assertion-like
			# functions.
			#
			def print_error (msg, opts={})
				## Preconditions & preparation:
				# ???: you can use STDERR or $stderr, unsure which is best
				defaults = {
					:stream => $stderr,
					:lvl => Logger::ERROR,
				}.merge(opts)
				if defaults[:lvl].is_a?(Fixnum)
					defaults[:lvl] = LEVELS[defaults[:lvl]] || LEVELS[-1]
				end
				## Main:
				lvl_str = defaults[:lvl]
				defaults[:stream].write("#{lvl_str.empty?()? '': lvl_str + ': '}#{msg}\n")
			end
			 
			 
			# Print an error message to a logger.
			#
			# @private
			#
			# @param [String, #to_s] msg An error message to report
			# @param [Logger] logger A logger to receieve the error message
			# @param [Hash] options
			# @option options [#to_s] lvl The error level, which should be a
			#   logging level but may be a descriptive string, Logger::ERROR by
			#   default.
			#
			# This is just an internal helper function, to send an message to a
			# logger in the events of errors. It is used by assertion-like
			# functions. Better and more powerful logging functions can be found
			# elsewhere.
			#
			def log_error(msg, logger, opts={})
				## Preconditions & preparation:
				defaults = {
					:lvl => Logger::ERROR,
				}.merge(opts)
				## Main:
				logger.add(defaults[:lvl], msg)
			end

		end
	end
end

