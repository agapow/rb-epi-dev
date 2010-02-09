#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Relais::Dev::Typecheck}.

### IMPORTS

### IMPLEMENTATION

# local code
module Relais
	module Dev
		
		# Runtime double-checking duck-typing.
		#
		# Often a method can accept different types of objects, all of which are
		# valid, as long as the type is divined correctly. Developers may also
		# like to typecheck as part of the contract / preconditions of a method.
		# To this end, this module provides a set of methods to check for various
		# types, or duck-types.
		#
		# @example
		#   # an artificial example that changes passed arguments to strings
		#   def convert_to_string(infiles)
		#      if (is_array(infiles))
		#         return infiles.collect { |e| e.to_s() }
		#      else
		#         return infiles.to_s
		#
		#   # accept and check anything that could be a pathname
		#   def open_file(fpath)
		#      return File.open(make_string(fpath))
		#
		module Typecheck

			# Is the passed object an enumerable?
			#
			# This would most commonly be used where a method can work on a single
			# object or a series of objects. The test is simply checking for the
			# +each+ method. A more strigent test would be to use {is_array_like}
			#
			def is_enumerable(obj)
				return obj.responds('each')
			end

			# If this object is not enumerable, make it so.
			#
			# See {is_enumerable}. This would most commonly be used to convert
			# arguments to a canonical form. If an object needs to be made
			# enumerable, we just wrap it in a list.
			#
			def make_enumerable(obj)
				if (is_enumerable(obj))
					return obj
				else
					return [obj]
				end
			end

			# Is the passed object like an array?
			#
			# See {is_enumerable}. This is a more strigent test for iterability due
			# to String's odd iteration behaviour (i.e. it has +each+ and +length+
			# but yields the entire string). The test is simply checking for the
			# +at+ method.
			#
			def is_array_like(obj)
				return obj.responds('at')
			end

			# If this object is not like an array, make it so.
			#
			# See {is_array_like} and {make_enumerable}. If an object needs
			# to be made like an array, we just wrap it in a list.
			#
			def make_array_like(obj)
				if (is_array_like(obj))
					return obj
				else
					return [obj]
				end
			end

			# Can the passed object be converted into a string?
			#
			def is_stringable(obj)
				return obj.responds('at')
			end

			# If this object is not like a string, make it so.
			#
			def make_array_like(obj)
				if (is_array_like(obj))
					return obj
				else
					return [obj]
				end
			end

		end
	end
end

