#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Relais::Dev::Common::Options}.

### IMPORTS

require 'relais-dev/base/fixedstruct'


### IMPLEMENTATION

# submodules that we provide

# local code
module Relais
	module Dev
		module Common

			# Options and their default values for scripts and functions.
			#
			# Options are traditionally handled within Ruby by juggling and merging
			# hashes. This works fine except for the danger of mispelling silently
			# going unnoticed:
			#
			#   options = {:overwrite_data => true}
			#   ...
			#   options[:overwrite_date] = false
			#   ... 
			#   if options[:overwrite_data]
			#   ...
			#
			# and the slightly awkward lookup required to get and set value. This
			# class solves these problems by implementing options as an OpenStruct
			# that cannot add attributes after construction. Thus options are
			# accessed as simple attributes and attempting to access a mispelt
			# options results in an error. Also, readability is helped by making
			# intent clear in the class name: 
			#
			#   options = Options.new(:overwrite_data => true, :message => "foo") 
			#   ...
			#   options.overwrite_date = false   # error!
			#   ... 
			#   if options.overwrite_data        # easier
			#   ...
			# 
			# Options can be created with the same syntax as OpenStruct:
			#
			#   # pass keyword arguments
			#   my_opt = Options.new(:overwrite_data => true, :message => "foo")
			#   # or a hash if you prefer
			#   my_opt = Options.new({:overwrite_data => true, :message => "foo"})
			#
			# @example
			#   def myfunc (arg1, arg2, opts={})
			#      options = Options.new(
			#        :overwrite_data => true,
			#        :message =>  "foo",
			#      ).update!(opts)
			#
			# Options is currently a synonym for {Relais::Dev::Base::FixedStruct}
			# although this may change at some later point.
			#
			class Options < Relais::Dev::Base::FixedStruct
			
			end
			
			
			# Create an options object with these default values.
			#
			# @see {Options}
			#
			# This is a simple bit of semantic sugar for defining the default
			# values for methods. It just creates and returns an Options object
			# with the passed values.
			#
			# @example
			#   def myfunc (arg1, arg2, opts={})
			#      options = defaults(
			#        :overwrite_data => true,
			#        :message =>  "foo",
			#      ).update!(opts)
			#
			def defaults(*args)
				return Options.new(*args)
			end

		end
	end
end

