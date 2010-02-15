
require 'test/unit/testcase'
require 'test/unit' if $0 == __FILE__

module TestRelais
	module TestDev
		module TestRoot
			
			require 'relais-dev/root/ohash'
			Ohash = Relais::Dev::Root::Ohash
			
			class TestOrderedHash < Test::Unit::TestCase
				def test_clear
					oh = Ohash[:foo=>0, :bar=>1, :baz=>2]
					oh.clear()
					assert_equal(0, oh.length)
				end

				def test_delete
					oh = Ohash.new(:foo=>0, :bar=>1, :baz=>2)
					oh.delete(:bar)
					assert_equal([:foo, :baz], oh.keys)
				end

				def test_each
					oh = Ohash.new(:foo=>0, :bar=>1, :baz=>2)
					keys = []
					oh.each { |k, v|
						keys << k
					}
					assert_equal([:foo, :bar, :baz], keys)
				end

				def test_each_key
					oh = Ohash.new(:foo=>0, :bar=>1, :baz=>2)
					keys = []
					oh.each_key { |k|
						keys << k
					}
					assert_equal([:foo, :bar, :baz], keys)
				end

				def test_each_pair
					raise NotImplementedError, 'Need to write test_each_pair'
				end

				def test_each_value
					oh = Ohash.new(:foo=>0, :bar=>1, :baz=>2)
					vals = []
					oh.each_value { |k|
						vals << k
					}
					assert_equal([1, 2, 3], vals)
				end

				def test_index_equals
					raise NotImplementedError, 'Need to write test_index_equals'
				end

				def test_keys
					oh = Ohash.new(:foo=>0, :bar=>1, :baz=>2)
					keys = oh.keys()
					assert_equal([:foo, :bar, :baz], keys)
				end

				def test_merge
					raise NotImplementedError, 'Need to write test_merge'
				end

				def test_merge_bang
					raise NotImplementedError, 'Need to write test_merge_bang'
				end

				def test_reject
					raise NotImplementedError, 'Need to write test_reject'
				end

				def test_reject_bang
					raise NotImplementedError, 'Need to write test_reject_bang'
				end

				def test_shift
					raise NotImplementedError, 'Need to write test_shift'
				end

				def test_to_hash
					raise NotImplementedError, 'Need to write test_to_hash'
				end

				def test_values
					raise NotImplementedError, 'Need to write test_values'
				end
			end
		end
	end
end

# Number of errors detected: 18
