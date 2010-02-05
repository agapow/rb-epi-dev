#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for Relais::Dev::Base::FixedStruct

### IMPORTS

require 'ostruct'


### IMPLEMENTATION

module Relais
	module Dev
		module Base

			# An OpenStruct with instance attributes fixed at creation.
			#
			# When using OpenStructs, errors can silently occur from mispellings:
			#
			#   mydata = OpenStruct({:received => true})
			#   ...
			#   mydata.recieved = false
			#   
			# A FixedStruct prevents this by only allowing instance variables to
			# be added at object creation. Its main purpose is as a base for
			# {Relais::Dev::Common::Options}.
			# 
			# FixedStructs can be created with the same syntax as OpenStructs:
			#
			#   # pass keyword arguments
			#   my_opt = Options.new(:overwrite_data => true, :message => "foo")
			#   # or a hash if you prefer
			#   my_opt = Options.new({:overwrite_data => true, :message => "foo"})
			#
			class FixedStruct < OpenStruct
				# TODO: replace talk of "attribute/field" with "instance variable"
			
				def method_missing(mid, *args) # :nodoc:
					# TODO: should call Object.method_missing, bypassing OpenStruct?
					raise(TypeError, "can't add to #{self.class} once created",
						caller(1))
				end
			
				# Remove the named attribute from the object.
				#
				def delete_field(name)
					raise(TypeError, "can't delete from #{self.class} once created",
						caller(1))
				end
			
				# Compare this object and +other+ for equality.
				#
				def ==(other)
					# TODO: change to do class comparison and make clearer 
					return false unless(other.kind_of?(OpenStruct))
					return @table == other.table
				end
			
				# Update the fields with the passed values.
				#
				# @param [Hash, #each_pair] hsh  A hash of instance variable / value
				#   pairs.
				#
				# Normally this would be used to merge passed option values with a
				# default set. It differs from the Hash method by raising an error
				# if the update refers to an attribute that doesn't exist.
				#
				def update(hsh)
					hsh.each_pair { |k,v|
						# ???: not sure if this is the right Ruby idiom
						instance_variable_set("@"+k.to_s, v)	
					}
					return self
				end
			
			end
			
		end
	end
end


### END
