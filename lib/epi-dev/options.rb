#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Root::Options}.

### IMPORTS

require 'relais-dev/root/fixedstruct'


### IMPLEMENTATION

# submodules that we provide

# local code
module Epi
	module Dev
		module Root

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
			# Options is currently a synonym for {Epi::Dev::Root::FixedStruct}
			# although this may change at some later point.
			#
			class Options < Epi::Dev::Root::FixedStruct
			  
        # This handles naming collisions with Sinatra/Vlad/Capistrano. Since these use a set()
        # helper that defines methods in Object, ANY method_missing ANYWHERE picks up the Vlad/Sinatra
        # settings!  So settings.deploy_to title actually calls Object.deploy_to (from set :deploy_to, "host"),
        # rather than the app_yml['deploy_to'] hash.  Jeezus.
        def create_accessors!
          self.each do |key,val|
            create_accessor_for(key)
          end
        end
      
        # Use instance_eval/class_eval because they're actually more efficient than define_method{}
        # http://stackoverflow.com/questions/185947/ruby-definemethod-vs-def
        # http://bmorearty.wordpress.com/2009/01/09/fun-with-rubys-instance_eval-and-class_eval/
        def create_accessor_for(key, val=nil)
          return unless key.to_s =~ /^\w+$/  # could have "some-setting:" which blows up eval
          instance_variable_set("@#{key}", val) if val
          self.class.class_eval <<-EndEval
            def #{key}
              return @#{key} if @#{key}
              raise MissingSetting, "Missing setting '#{key}' in #{@section}" unless has_key? '#{key}'
              value = fetch('#{key}')
              @#{key} = value.is_a?(Hash) ? self.class.new(value, "'#{key}' section in #{@section}") : value
            end
          EndEval
        end
        
        
			
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

