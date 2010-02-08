#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Relais::Dev::Text} .
#
# Import this file to load {Relais::Dev::Text}.

### IMPORTS

require 'relais-dev/common'

RBC = Relais::Dev::Common


### IMPLEMENTATION

# submodules that we provide


module Relais
	module Dev
		
		# Assorted text manipulation functions.
		#
		module Text
			
			# TODO: a textwrapper class like in Python?

			# Wrap a length of text to fit within a given width
			#
			# @param [String] txt The text to be wrapped. 
			# @param [Hash] opts A hash of optional parameters.
			# @option opts [Integer] width The wrap width, 60 by default. 
			#
			# @return [Hash] A hash of the key generated from each item and an
			#   array of the corresponding items.
			#
			# Once again, there is actually a function in Rails for this, but Rails
			# is not always available and we can add to the functionality of this
			# one. The wrap function in this module are named after the Python
			# equivalents.
			#
			# @example
			#   >> fill('foo')
			#   foo
			#   >> fill('foo'*10, {:width=>10})
			#   foofoofoof\noofoofoofo\nofoofoofoo
			#
			def fill(txt, opts={})
				# TODO: needs further options including eoln type and space stripping
				options = RBC::defaults(
					:width => 60,
					:collapse_space => false
				).merge(opts)
				# to save repeated lookup
				return txt.gsub(/(.{1,#{options.width}})( +|$)\n?|(.{#{options.width}})/,
					"\\1\\3\n")
			end
			
			# Wrap a length of text to fit within a given width.
			#
			# @see fill
			# @return [Array] An array of Strings.
			#
			# This works like {Text#fill} but instead of a String with inserted
			# newlines, it returns an array of lines. 
			#
			# @example
			#   >> wrap('foo')
			#   [foo]
			#   >> fill('foo'*10, {:width=>10})
			#   [foofoofoof,oofoofoofo,ofoofoofoo]
			#
			def wrap(txt, options={})
				return  wrap_text(txt, options).split("\n")
			end

		end
	end
end


### END
