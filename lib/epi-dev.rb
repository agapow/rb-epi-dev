#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev}.

### IMPORTS

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


### IMPLEMENTATION

# Epi::Dev is a collection of assorted utility functions for development
# and debugging. Although it has a deep purpose as a aid for the Ruby port of
# the Relais epiinformatics suite <http://www.epicentr.org>, it should be
# suitable for general programming making several common tasks quick and
# consistent. 
# 
# By importing this file you get the entirity of Epi::Dev which contains:
#
# * {Epi::Dev::Common} for traditional debugging constructs like
#   diagnostic printing and assertion.
# * {Epi::Dev::Io} for consistent and simple IO classes.
# * {Epi::Dev::Cli} for commandline program functions, including a more.
#   sophisticated argument parser and common commandline flags.
# * {Epi::Dev::Log} for enhanced and streamlined logging. 
# * {Epi::Dev::Text} for common text manipulation utilities. 
# * {Epi::Dev::Math} for assorted math functions. 
#
module Epi::Dev
	
		VERSION = '0.1.0'
	
end

# submodules that we provide
Dir['epi-dev/*.rb'].sort.each { |lib| require lib }


### END
