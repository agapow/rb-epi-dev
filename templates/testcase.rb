#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Tests for FIXME NAME OF OBJECTS

# Description/list of tests to be done.

### IMPORTS

require "local project code"

require "MY::PROJECT"
MYPROJ = MY::PROJECT


### TESTCASES

class TestSimpleNumber < Test::Unit::TestCase
 
  def setup
    @num = SimpleNumber.new(2)
  end
 
  def teardown
    ## Nothing really
  end
 
  def test_simple
    assert_equal(4, @num.add(2) )
  end
 
  def test_simple2
    assert_equal(4, @num.multiply(2) )
  end
 
end


### END

