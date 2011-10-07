#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Root}.

### IMPORTS

### IMPLEMENTATION

# local code
module Epi
	module Dev
		
		# Assorted data structures.
		#
		# Even in a scripting langauge you sometimes need more than a hash and a
		# list. Here we collect some useful variant data structures. Although some
		# of these are available elsewhere (e.g. in Rails) but rather than require
		# a whole external framework for small bits of functionality, we implement
		# them here.
		#
		module Root
		end
		
	end
end


# submodules that we provide
Dir['relais-dev/root/*.rb'].sort.each { |lib| require lib }


### END
