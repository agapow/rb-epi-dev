#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Debug}

### IMPORTS

### IMPLEMENTATION

# local code
module Epi
	module Dev
		
		# Assertions and design-by-contract idioms for the development cycle.
		#
		# This module provides all the functionality of {Epi::Dev::Contract}
		# - assertions and other runtime sanity checks - but with a twist.
		# Depending on the setting of a module variable, these assertions may
		# not actually be run. This allows assertions to be switched on during
		# the development cycle, switched off for production or toggled by a
		# runtime switch.
		#
		# The controlling variable is {Dev.apply_checks}. If set to +true+ (the
		# default), all runtime checks are carried out and behave as normal.
		# Otherwise, runtime checks are skipped. In addition, if the module
		# variable {.announce_checks} is set to +true+ (the default is +false+),
		# when a check is called a message is printed to the console, whether or
		# not the check is run.
		#
		# @example
		#   RDD = Epi::Dev::Debug
		#   RDD.assert(false) # throw assertion, no message
		#   RDD.announce_checks = true
		#   RDD.assert(false) # throw assertion, print message
		#   RDD.apply_checks = false
		#   RDD.assert(false) # don't check, but print message
		#   RDD.announce_checks = false
		#   RDD.assert(false) # don't check, don't print message
		# 
		module Debug
			
			require 'epi-dev/contract'

			apply_checks = true
			announce_checks = false
			
			def self.method_missing(mthd, *args)
				if announce_checks
					if apply_checks
						print "runtime check Epi::Dev::#{mthd} ...\n"
					else
						print "suppressed check Epi::Dev::#{mthd} ...\n"
					end
				end
				if apply_checks
					Epi::Dev::Contract.send(*args)
				end
				
				return nil
			end

		end
		
	end
end

### END
