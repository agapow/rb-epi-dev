#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Tests for Epi::Dev::Common

# Description/list of tests to be done.

### IMPORTS

require "relais-dev/common"
include Epi::Dev::Common
require "relais-dev/errors"
RBE = Epi::Dev::Errors


### TESTCASES

class TestPrintError < Test::Unit::TestCase
	# print_error (msg, opts={:stream=>$stderr, :lvl=>Logger::ERROR})
	# TODO: haven't tested logger

	def setup
		# nothing
	end

	def teardown
		# nothing
	end

	def test_simple
		# catch a simple message
		out, err = capture_output {
			print_error("foo")
		}
		assert_equal(err, "ERROR: foo\n")
	end

	def test_with_level_string
		# catch a simple message, with a named level
		out, err = capture_output {
			print_error("foo", {:lvl=>'TEST'})
		}
		assert_equal("TEST: foo\n", err)
	end

	def test_level_constant
		# catch a simple message, with a level enum from logging
		out, err = capture_output {
			print_error("foo", {:lvl=>Logger::FATAL})
		}
		assert_equal("FATAL: foo\n", err)
	end

end


class TestRaiseUnless < Test::Unit::TestCase
	# raise_unless(cond, opts={:err_class => RBE::AssertionError,
	#	:msg => "an unknown error has occurred and an exception has been raised",
	#	:logger => nil, :lvl => Logger::ERROR, :err_stream => $stderr}

	# TODO: test options, writing to logger and stream

	def setup
		# nothing
	end

	def teardown
		# nothing
	end

	def test_simplefail
		assert_raise(RBE::AssertionError) {
			out, err = capture_output {
				raise_unless(false)
			}
		}
	end

	def test_simplepass
		assert_nothing_raised(RBE::AssertionError) {
			out, err = capture_output {
				raise_unless(true)
			}
		}
	end

	def test_messages
		begin
			out, err = capture_output {
				raise_unless(false, {:msg=>'foo'})
			}
		rescue StandardError => err
			assert_equal(err.message, "foo")
		end
	end

	def test_error_class
		assert_raise(RuntimeError) {
			out, err = capture_output {
				raise_unless(false, {:err_class=>RuntimeError})
			}
		}
	end

end


### END