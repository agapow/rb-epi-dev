#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Common error types.

### IMPORTS

### IMPLEMENTATION

# submodules that we provide

# local code
module Relais
	module Dev
		module Errors

			AssertionError = AssertionFailedError
			UnimplementedError = NotImplementedError

		end
	end
end


### END
