#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Root::Enum}.

### IMPORTS

### IMPLEMENTATION

# submodules that we provide

# local code
module Epi
	module Dev

			# Support for enumerated types and constants.
			#
			# Enumerated types - your classic C-style +enum+ as opposed to Ruby's
			# Enumerables - have a number of uses:
			# * as semantics, grouping a set of constants and signalling that a
			#   choice must be made amongst them (e.g. Color::Red, Color:Blue)
			# * type-safety, ensuring a possible value is one of a set of choices
			#   (e.g. assert border_side.is_a?(Direction)) and is immutable
			# * ordering, being able to rank and compare values (e.g. Alert::Info
			#   < Alert::Critical)
			#
			
			
			module Enum
				# Ordering in enum members is a tough nut to crack. As named
				# arguments must come after un-named arguments, it proves to be
				# impossible to mix specified and unspecified members:
				#
				#   enum ColorEnum {red, blue=3, green} Color   # c-style
				#   Color = make_enum {:red, :blue => 3, :green}   # ruby, nope
				#
				# Most possible solutions lead to awkward syntax and are complicated
				# by hashes being unordered before Ruby 1.9. The solution settled
				# upon is this:
				#
				# * Enums can be created from unspecified (positional) arguments
				#
				# Using +method_missing+ opens up the problems of mispelling but
				# the risks are minimal. A new enum will only be created if 
			
				def method_missing(mid, *args) # :nodoc:
					new_enum(mid, *args)
				end
				
				def new_enum(enum_name, *args)
					# create enum value class
					val_kls_name = enum_name + "Value"
					val_kls = Class.new(BaseEnumValue)
					Object.const_set(val_kls_name, val_kls)
					# create enum object to hold values
					cont = EnumContainer.new()
					cont.value_class = val_kls
					# create the enum values
					enum_vals = {}
					next_val = -1
					args.each { |e|
						if e.instance_of?(Hash)
							e.each_pair { |k, v|
								enum_vals[k] = v
								if v.instance_of?(Fixnum)
									next_val = v + 1
								end
							}
						elsif e.instance_of?(Array)
							k, v = e[0], e[1]
							enum_vals[k] = v
							if v.instance_of?(Fixnum)
								# TODO: check it hasn't alreday been used
								next_val = v + 1
							end
						else
							enum_vals[e] = next_val
							next_val += 1
						end
					}
					# insert into Enum
				end

			end

			# A group of enumerated values.
			# 
			class EnumContainer
				attr_accessor(:value_class)
				
			end

			# An enumerated value
			class BaseEnumValue
				attr_accessor(:value)
				
				def initialize(value)
				end
			end

	end
end

