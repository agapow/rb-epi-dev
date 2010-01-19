# Useful sequence analysis functions, especially for SNPs
#
# For simplicity, we assume lowest commn denominator here in terms of data
# structures, rather than obliging the use of particular classes.

# TODO: file this in 'moremath'?


# Cluster the passed objects by similarity.
# 
# @param [Enumerable, #each] objs A sequence of objects to be grouped
# @param [Hash] options A hash of optional parameters 
# @option options [Proc] val_proc A optional parameter to generate the value
#   (term that is stored) for every object. If not given, we use simple
#   equality (i.e. the object itself)
# @yield [o] A block to generate the key (grouping term) for each object. If
#   not given, we use simple equality (i.e. the item itself)
#
# @returns [Hash] a hash of the key generated from each item and an array of the
#   corrsponding items 
#
# There is actually a function in Rails for this, but 1. Rails is not always
# available and 2. I like the way I did it better. Note that the order of
# returned items is not set nor guaranteed to be consistent.
#
# @example
#   #divide a range into even and odd numbers
#   >> partition((1..6)) { |x| x % 2 }
#   => {0=>[2, 4, 6], 1=>[1, 3, 5]}
#   # change the values stored to a string representation
#   >> partition((1..6), {:value_proc=>lambda {|f| f.to_s}}) { |x| x % 2 }
#   => {0=>["2", "4", "6"], 1=>["1", "3", "5"]}
# 
def partition (objs, options={}, &block)
	## Preconditions & preparation:
	defaults = {
		:value_proc => lambda { |o| o },
	}.merge(options)
	# to save repeated hash lookups
	value_proc = defaults[:value_proc]
	# using 'or' gives odd results here
	key_proc = block || lambda { |x| x }
	## Main:
	# basically we generate a key for each item and use it to fill the hash
	grouped_items = {}	
	objs.each { |o|
		key = key_proc.call(o)
		val = value_proc.call(o)
		if grouped_items.has_key?(key)
			grouped_items[key] << val
		else
			grouped_items[key] = [val]
		end
	}
	## Postconditions & return:
	return grouped_items
end
	

# Calculate the frequncy of objects in a sequence.
#
# @param [Enumerable, #each] objs A sequence of objects to be counted
# @yield [o] A block to generate the key (grouping term) for each object. If
#   not given, we use simple equality (i.e. the item itself)
#
# @returns [Hash] a hash of the key generated from each item and an array of the
#   corrsponding items 
#
# This works in an analogous way to the partition function, except the hash it
# returns has the frequency of an object as values. Note that is you try and
# calaculate character frequency over a string, you have to first break the
# string up by character.
# 
# @example
#   #divide a range into even and odd numbers
#   >> frequency(['a', 'b', 'a', 'd'])
#   => {0=>[2, 4, 6], 1=>[1, 3, 5]}
#   >> frequency([1, 2, 3, 4, 5]) { |x| x % 2 }
#   => {0=>2, 1=>3}
#   
def frequency (objs, &block)
	## Preconditions & preparation:
	# using 'or' gives odd results here
	key_proc = block || lambda { |x| x }
	## Main:
	# basically we generate a key for each item and use it to fill the hash
	counted_items = {}	
	objs.each { |o|
		key = key_proc.call(o)
		if counted_items.has_key?(key)
			counted_items[key] += 1
		else
			counted_items[key] = 1
		end
	}
	## Postconditions & return:
	return counted_items
end
	



