#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Contract}

### IMPORTS

### IMPLEMENTATION

# submodules that we provide

# local code
module Epi
	module Dev
		
		# Assertions and other design-by-contract idioms.
		#
		# Assertions are hidden away in the unit testing module of the Ruby
		# standard library, which may be one reason they're so infrequently used.
		# For convenience, they are gathered here along with a few allied
		# functions.
		#
		module Contract
			require 'test/unit/assertions'
			include Test::Unit::Assertions
			
			def assert_path_exists(fpath)
				assert_block("file path '#{fpath} does not exist") {
					File.exists?(fpath)
				}
			end

			def assert_path_is_file(fpath)
				assert_block("file path '#{fpath} is not a file") {
					File.file?(fpath)
				}
			end

			def assert_path_is_dir(fpath)
				assert_block("file path '#{fpath} is not a directory") {
					File.directory?(fpath)
				}
			end

			def assert_path_is_readable(fpath)
				assert_block("file path '#{fpath} is not a directory") {
					File.readable?(fpath)
				}
			end

			def assert_path_is_writable(fpath)
				assert_block("file path '#{fpath} is not a directory") {
					File.writable?(fpath)
				}
			end
		
		end
		
	end
end

### END
