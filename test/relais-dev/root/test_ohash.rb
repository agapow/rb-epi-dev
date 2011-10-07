
require 'test/unit/testcase'
require 'test/unit' if $0 == __FILE__

module TestRelais
	module TestDev
		module TestRoot
			
			require 'relais-dev/root/ohash'
			Ohash = Epi::Dev::Root::Ohash
			
			class TestOrderedHash < Test::Unit::TestCase
				
				# the inline creation of ohashs doesn't preserve order, because it
				# is converted to a hash before reading. Hence this function for
				# generating ohashes to test. 
				def generate_ohash
					oh = Ohash.new()
					oh[:foo] = 0
					oh[:bar] = 1
					oh[:baz] = 2
					return oh
				end
				
				def test_clear
					oh = generate_ohash()
					oh.clear()
					assert_equal(0, oh.length)
				end

				def test_delete
					oh = generate_ohash()
					oh.delete(:bar)
					assert_equal([:foo, :baz], oh.keys)
				end

				def test_each
					oh = generate_ohash()
					keys = []
					oh.each { |k, v|
						keys << k
					}
					assert_equal([:foo, :bar, :baz], keys)
				end

				def test_each_key
					oh = generate_ohash()
					keys = []
					oh.each_key { |k|
						keys << k
					}
					assert_equal([:foo, :bar, :baz], keys)
				end

				def test_each_pair
					oh = generate_ohash()
					keys = []
					oh.each_pair { |k, v|
						keys << k
					}
					assert_equal([:foo, :bar, :baz], keys)
				end

				def test_each_value
					oh = generate_ohash()
					vals = []
					oh.each_value { |k|
						vals << k
					}
					assert_equal([0, 1, 2], vals)
				end

				def test_keys
					oh = generate_ohash()
					keys = oh.keys()
					assert_equal([:foo, :bar, :baz], keys)
				end

				def test_shift
					oh = generate_ohash()
					k, v = oh.shift()
					assert_equal(:foo, k)
					assert_equal(0, v)
				end

				def test_to_hash
					oh = generate_ohash()
					h = oh.to_hash
					assert_equal(["bar", "baz", "foo"], h.keys.map { |k|
						k.to_s()
						}.sort()
					)
					assert_equal([0, 1, 2].sort(), h.values.sort())
				end

				def test_values
					oh = generate_ohash()
					values = oh.values()
					assert_equal([0, 1, 2], values)
				end
			end
		end
	end
end

# Number of errors detected: 18
