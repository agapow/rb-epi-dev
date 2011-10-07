#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Tests for Epi::Dev::Common

# Description/list of tests to be done.

### IMPORTS

require "local project code"


### TESTCASES

class TestRaiseUnless < Test::Unit::TestCase

	def setup
	 # Nothing really
	end
 
	def teardown
		# Nothing really
	end
 
	def test_simple
		
		assert_equal(4, @num.add(2) )
	end
 
	def test_simple2
		assert_equal(4, @num.multiply(2) )
	end

end


### END

