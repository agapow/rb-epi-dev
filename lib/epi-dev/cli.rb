#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Cli}.

# Other possibilities for cli arg parsers include:
# http://totalrecall.wordpress.com/2008/09/08/ruby-command-line-parsing/
# include load config file and other objects

### IMPORTS

### IMPLEMENTATION

# local code
module Epi
	module Dev
		
		# Utility functions and common objects for commandline programs.
		#
		# To ease development and make for more consistency, a number
		# of common options and structures are provided for building commandline
		# applications. These include:
		#
		# * Simple handling of user options, including preset common options.
		# * Consistent user interaction
		# * A simple application object.
		#
		module Cli
		end
		
	end
end


# submodules that we provide
Dir['relais-dev/cli/*.rb'].sort.each { |lib| require lib }


### END