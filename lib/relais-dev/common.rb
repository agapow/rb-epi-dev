#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Relais::Dev::Common}.

### IMPORTS

require 'relais-dev/contract'
require 'relais-dev/typecheck'
require 'relais-dev/debug'
require 'relais-dev/root/options'
require 'relais-dev/root/enum'


### IMPLEMENTATION

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

			# note we don't include Debug, because that must be in own namespace
			include Relais::Dev::Contract
			include Relais::Dev::Root
			include Relais::Dev::Typecheck

		end

	end
end


### END
