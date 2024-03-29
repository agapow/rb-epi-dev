#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Tests for Epi::Dev::Common

# Description/list of tests to be done.

### IMPORTS

require 'test/unit' unless defined? $ZENTEST and $ZENTEST


### TESTCASES

module TestEpi
	module TestDev
		module TestRoot

			require 'relais-dev/root/fixedstruct'
			RBD = Epi::Dev::Root

			class TestFixedStruct < Test::Unit::TestCase

				def test_access
					# should create fields
					fs = RBD::FixedStruct.new(:foo => 'bar')
					assert_nothing_raised() {
						fs.foo = "baz"
					}
				end

				def test_delete_field
					# deleting a field should fail
					fs = RBD::FixedStruct.new(:foo => 'bar')
					assert_raise(TypeError) {
						fs.delete(:foo)
					}
				end

				def test_update
					# updating an existing field should pass
					fs = RBD::FixedStruct.new(:foo => 'bar')
					assert_nothing_raised() {
						fs.foo = "baz"
					}
					# updating an new field should fail
					fs = RBD::FixedStruct.new(:foo => 'bar')
					assert_raise(TypeError) {
						fs.quux = "baz"
					}
				end

			end
		end
	end
end


### END ###
