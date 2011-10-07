#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Errors}.
#
# Import to load {Epi::Dev::Errors}.

### IMPORTS

require 'test/unit/assertionfailederror'


### IMPLEMENTATION

# submodules that we provide

# local code
module Epi::Dev
	
	# Common error types.

	# For brevity
	AssertionError = Test::Unit::AssertionFailedError

end


### END #######################################################################
