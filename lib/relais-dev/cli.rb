#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# Other possibilities for cli arg parsers include:
# http://totalrecall.wordpress.com/2008/09/08/ruby-command-line-parsing/
# include load config file and other objects

# Source file for {Relais::Dev::Cli}.

### IMPORTS

### IMPLEMENTATION

# submodules that we provide
require 'relais-dev/cli/clapp'

# local code
module Relais
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


### END