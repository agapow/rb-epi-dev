#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev}.

### IMPORTS

CURR_DIR = File.dirname(__FILE__)

$:.unshift(CURR_DIR) unless
  $:.include?(CURR_DIR) || $:.include?(File.expand_path(CURR_DIR))


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
module Epi
  module Dev
	
		VERSION = '0.1.0'
	
  end
end

# submodules that we provide
Dir[CURR_DIR + '/epi-dev/*.rb'].sort.each { |lib| print lib; require lib }


### END
