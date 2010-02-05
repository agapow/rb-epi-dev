#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Relais::Dev::Contract}

### IMPORTS

### IMPLEMENTATION

# submodules that we provide

# local code
module Relais
	module Dev
		
		# Assertions and other design-by-contract idioms.
		#
		# Assertions are hidden away in the unit testing module of the Ruby
		# standard library, which may be one reason they're so infrequently used.
		# For convenience, we gather them all here, along with a few allied
		# functions.
		#
		module Contract
			
			require 'test/unit/assertions'
			include Test::Unit::Assertions
			
		end
	end
end

### END
