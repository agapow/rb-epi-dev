#! /usr/bin/env ruby
# -*- coding: utf-8 -*-





# Wrap a length of text to fit within a given width
#
# @param [String] txt The text to be wraopped. 
# @param [Hash] options A hash of optional parameters
# @option options [Integer] width The wrap width, 60 by default. 
#
# @returns [Hash] a hash of the key generated from each item and an array of the
#   corrsponding items
#
# Once again, there is actually a function in Rails for this, but Rails is not always
# available and we can add to the functionality of this one.
#
# @example
#   >> partition((1..6)) { |x| x % 2 }
#   => {0=>[2, 4, 6], 1=>[1, 3, 5]}
#   # change the values stored to a string representation
#   >> partition((1..6), {:value_proc=>lambda {|f| f.to_s}}) { |x| x % 2 }
#   => {0=>["2", "4", "6"], 1=>["1", "3", "5"]}
#
def wrap_text(txt, options={})
	# TODO: needs further options including eoln type and space stripping
	defaults = {
		:width => 60,
	}.merge(options)
	# to save repeated lookup
	width = defaults[:width]
	return txt.gsub(/(.{1,#{width}})( +|$)\n?|(.{#{width}})/,
		"\\1\\3\n")
end


# Like wrap_text but returns an array of lines
def fill_text(txt, options={})
	return  wrap_text(txt, options).split("\n")
end

