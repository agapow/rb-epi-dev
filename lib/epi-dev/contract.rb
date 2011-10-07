#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Contract}

### IMPORTS

### IMPLEMENTATION

# submodules that we provide

# local code
module Epi
	module Dev
		
		# Assertions and other design-by-contract idioms.
		#
		# Assertions are hidden away in the unit testing module of the Ruby
		# standard library, which may be one reason they're so infrequently used.
		# For convenience, they are gathered here along with a few allied
		# functions.
		#
		module Contract
			
			require 'logger'
			require 'relais-dev/errors'
			require 'test/unit/assertions'
			include Test::Unit::Assertions

			RBE = Epi::Dev::Errors
			LEVELS = %w(DEBUG INFO WARN ERROR FATAL ANY)

			def assert_path_exists(fpath)
				assert_block("file path '#{fpath} does not exist") {
					File.exists?(fpath)
				}
			end

			def assert_path_is_file(fpath)
				assert_block("file path '#{fpath} is not a file") {
					File.file?(fpath)
				}
			end

			def assert_path_is_dir(fpath)
				assert_block("file path '#{fpath} is not a directory") {
					File.directory?(fpath)
				}
			end

			def assert_path_is_readable(fpath)
				assert_block("file path '#{fpath} is not a directory") {
					File.readable?(fpath)
				}
			end

			def assert_path_is_writable(fpath)
				assert_block("file path '#{fpath} is not a directory") {
					File.writable?(fpath)
				}
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

### END
