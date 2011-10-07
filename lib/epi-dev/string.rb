#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Text} .
#
# Import this file to load {Epi::Dev::Text}.

### IMPORTS

require 'epi-dev/options'

ED = Epi::Dev


### IMPLEMENTATION

# submodules that we provide


module Epi
	module Dev
		
		class String
		
			# Iterate over every match in a string, passing it to a block.
			#
			# In one of those strange gaps that exists in Ruby, while there are
			# several ways to loop over substrings matched by a pattern, no
			# facility exists for iterating over the *matches*, for example to
			# get the offset of each matching substring. This method rectifies
			# that.
			#
			def each_match (re, &block)
				scan(re) {
					block.call($~)
				}
			end
		
		end
		
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
				options = ED::defaults(
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
