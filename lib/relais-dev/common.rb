#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Relais::Dev::Common}.

### IMPORTS

require 'relais-dev/contract'
require 'relais-dev/base/options'
require 'relais-dev/typecheck'


### IMPLEMENTATION

# submodules that we provide

# local code
module Relais
	module Dev
		
		# Support for ubiquitous development tricks and idioms.
		#
		# For developer convenience, this module imports a set of the most
		# commonly used modules, making them available under a single namespace.
		# These include:
		#
		# * assertions (as borrowed from Test::Unit)
		# * options and defaults
		# * typechecks
		# 
		module Common

			include Relais::Dev::Contract
			include Relais::Dev::Base
			include Relais::Dev::Typecheck

		end
	end
end

