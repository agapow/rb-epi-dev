

require 'logger'


# A hash for containing option defaults
#
class OptHash < Hash
	# TODO: add a merge_opts arg that can only overwrite existing keys

	# Currently, this does nothing. However in the future it will do some
	# argument checking to guard against mispelt keys. Perhaps a single class
	# or a method that accepts a series of hashs (from config files etc.) and
	# overwrites all preceding  
end


# Print the passed objects, and complete with a linebreak.
#
# @param [] args ant objects that can be printed 
#
# This is a simple convenience function, prompted by the irritation of having to
# add '\n' after every "diagnostic printf" .
#
# @example
#   >>> printn('foo')
#   'foo'
#
def printn(*args)
	print(*args)
	print "\n"
end


# Raise an exception unless the passed condition is met
#
# @param [Boolean] cond A test that evaulates to a boolean
# @param [Hash] options An options hash
# @option options [Exception class] error An exception class, by default
#   AssertionError
# @option options [String] error An error message, by default "an unknown error
#   has occurred" 
#
# Assertions are provided within Ruby, but only within the testing frameworks.
# This method plugs that gap and provides some useful extra functionality, such
# as specifying error class and message.
#
# @example
#   raise_unless (day_of_month <= 32)
#   raise_unless (filepath.exists, {:error=>IOError})
#   raise_unless (denominator != 0, {:msg=>"division by zero!"})
#
def raise_unless(cond, options)
	# TODO: use globals to set the default err logger and stream
	# TODO: need a better word than 'defaults'
	defaults = {
		err_class=AssertionError,
		msg="an unknown error has occurred and an exception has been raised",
		logger=nil,
		lvl=Logger:ERROR,
		err_stream=$stderr,
	}.merge(options)
	unless (cond)
		if defaults[:err_stream]
			print_error(msg, logger, {:lvl=>lvl, :stream=>stream})
		end
		if defaults[:logger]
			log_error(msg,{:lvl=>lvl})	
		end
		raise err_class.new(msg)
	end
end


# Raise an exception unless the passed condition is met
#
# @param [Boolean] cond A test that evaulates to a boolean
# @param [Hash] options An options hash
# @option options [Exception class] error An exception class, by default
#   AssertionError
# @option options [String] error An error message, by default "an unknown error
#   has occurred" 
#
# Assertions are provided within Ruby, but only within the testing frameworks.
# This method plugs that gap and provides some useful extra functionality, such
# as specifying error class and message.
#
# @example
#   raise_unless (day_of_month <= 32)
#   raise_unless (filepath.exists, {:error=>IOError})
#   raise_unless (denominator != 0, {:msg=>"division by zero!"})
#
def die_unless(cond, options)
	defaults = {
		ret_code=AssertionError,
		msg="an unknown error has occurred and the program will exit",
		logger=nil,
		lvl=Logger:FATAL,
		err_stream=$stderr,
	}.merge(options)
   unless (cond)
		if defaults[:err_stream]
			print_error(msg, logger, {:lvl=>lvl, :stream=>stream})
		end
		if defaults[:logger]
			log_error(msg,{:lvl=>lvl})	
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
# @option options [IO] stream The stream to send the message to, by default
#   STDERR
# @option options [#to_s] lvl The error level, usually a logging level but
#   possibly a descriptive string, Logger::ERROR by default
#
# This is just an internal helper function, to send an message to the screen in
# the events of errors. It is used by assertion-like functions.
# 
def print_error (msg, options)
	## Preconditions & preparation:
	# ???: you can use STDERR or $stderr, unsure which is best
	defaults = {
		stream=$stderr,
		lvl=Logger:ERROR,
	}.merge (options)
	## Main:
	lvl_str = lvl.to_s()
	stream.write("#{lvl_str.empty?()? '': lvl_str + ': '}#{msg}")
end


# Print an error message to a logger.
#
# @private
#
# @param [String, #to_s] msg An error message to report
# @param [Logger] logger A logger to receieve the error message
# @param [Hash] options
# @option options [#to_s] lvl The error level, which should be a logging level but
#   may be a descriptive string, Logger::ERROR by default
#
# This is just an internal helper function, to send an message to a logger in
# the events of errors. It is used by assertion-like functions. Better and more
# powerful logging functions can be found elsewhere.
# 
def log_error(msg, logger, options)
	## Preconditions & preparation:
	defaults = {
		lvl=Logger:ERROR,
	}.merge (options)
	## Main:
	logger.add(defaults[:lvl], msg)
end



