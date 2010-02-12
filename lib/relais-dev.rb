#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Relais::Dev}.

### IMPORTS

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


### IMPLEMENTATION

# local code
module Relais
	
	# Relais::Dev is a collection of assorted utility functions for development
	# and debugging. Although it has a deep purpose as a aid for the Ruby port of
	# the Relais epiinformatics suite <http://www.epicentr.org>, it should be
	# suitable for general programming making several common tasks quick and
	# consistent. 
	# 
	# By importing this file you get the entirity of Relais::Dev which contains:
	#
	# * {Relais::Dev::Common} for traditional debugging constructs like
	#   diagnostic printing and assertion.
	# * {Relais::Dev::Io} for consistent and simple IO classes.
	# * {Relais::Dev::Cli} for commandline program functions, including a more.
	#   sophisticated argument parser and common commandline flags.
	# * {Relais::Dev::Log} for enhanced and streamlined logging. 
	# * {Relais::Dev::Text} for common text manipulation utilities. 
	# * {Relais::Dev::Math} for assorted math functions. 
	#
	module Dev
		VERSION = '0.0.3'
	end
	
end

# submodules that we provide
Dir['relais-dev/*.rb'].sort.each { |lib| require lib }


### END
