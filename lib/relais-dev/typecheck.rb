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
			# +each+ method. A more strigent test would be to use {#is_array_like}.
			#
			# @example
			#   >> is_enumerable(["foo"])
			#   => true
			#   => is_enumerable("foo")
			#   => true
			#   => is_enumerable(1)
			#   => false
			#
			def is_enumerable(obj)
				return obj.responds('each')
			end

			# If this object is not enumerable, make it so.
			#
			# See {#is_enumerable}. This would most commonly be used to convert
			# arguments to a canonical form. If an object needs to be made
			# enumerable, we just wrap it in a list.
			#
			# @example
			#   >> make_enumerable(["foo"])
			#   => ["foo"]
			#   => make_enumerable("foo")
			#   => "foo"
			#   => make_enumerable(1)
			#   => [1]
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
			# See {#is_enumerable}. This is a more strigent test for iterability due
			# to String's odd iteration behaviour (i.e. it has +each+ and +length+
			# but yields the entire string). The test is simply checking for the
			# +at+ method.
			#
			# @example
			#   >> is_array_like(["foo"])
			#   => true
			#   => is_array_like("foo")
			#   => false
			#
			def is_array_like(obj)
				return obj.responds('at') && (not obj.is_a?(String))
			end

			# If this object is not like an array, make it so.
			#
			# See {#is_array_like} and {#make_enumerable}. If an object needs
			# to be made like an array, we just wrap it in a list.
			#
			# @example
			#   >> make_array_like(["foo"])
			#   => ["foo"]
			#   => make_array_like("foo")
			#   => ["foo"]
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
			# This checks whether an object can be coerced into a string, via
			# +to_s+. This includes almost all Ruby objects, although conversion
			# may be poor. See {#is_string_like} for a stricter test.
			#
			# @example
			#   >> is_string_able("foo")
			#   => true
			#   => is_string_able(Pathname.new("foo"))
			#   => true
			#   >> is_string_able(123)
			#   => false
			#
			def is_string_able(obj)
				# TODO: method necessary?
				return obj.responds('to_s')
			end

			# Does the passed object act like a string?
			#
			# This checks whether an object can be converted into a string, via 
			# +to_str+. Few core Ruby objects pass this test. See {#is_string_able}
			# for a more liberal test.
			# 
			# @example
			#   >> is_string_like("foo")
			#   => true
			#   => is_string_like(Pathname.new("foo"))
			#   => true
			#   >> is_string_like(123)
			#   => false
			#
			def is_string_like(obj)
				return obj.responds('to_str')
			end

			# If this object is not like a string, make it so.
			#
			# String-like objects (including +String+) are simply returned, while
			# other objects are converted (via +to_s+). Thus we move from the best
			# (most faithful) conversion, down to the most hacky.
			#
			# @example
			#   >> make_string("foo")
			#   => "foo"
			#   >> make_string(Pathname.new("foo"))
			#   => #<Pathname:foo>
			#   >> make_string(123)
			#   => "123"
			#
			def make_string_like(obj)
				if (is_string_like(obj))
					return obj
				else
					return obj.to_s()
				end
			end

		end

	end
end

### END
