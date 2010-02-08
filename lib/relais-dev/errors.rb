#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Relais::Dev::Errors}.
#
# Import to load {Relais::Dev::Errors}.

### IMPORTS

require 'test/unit/assertionfailederror'


### IMPLEMENTATION

# submodules that we provide

# local code
module Relais
	module Dev
		
		# Common error types.
		#
		module Errors

			# For brevity
			AssertionError = Test::Unit::AssertionFailedError

		end
	end
end


### END
