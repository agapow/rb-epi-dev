#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

# Source file for {Epi::Dev::Root::Ohash}.

### IMPORTS

### IMPLEMENTATION

module Epi
	module Dev
		module Root
		
			if RUBY_VERSION >= '1.9'
				OHash = ::Hash
			else
			
				# A hash with consistent ordering of keys.
				#
				# It's often useful to provide an order to the hash keys, or at
				# least be able to iterate over them in a consistent order. There's
				# many implementations, but this is borrowed from Rails, with the
				# possibility of using the core Ruby hash if it provides ordering
				# (version 1.9 and later).
				#
				class OHash < Hash
					
					
					# C'tor, duplicating the standard Hash.
					#
					def initialize(*args, &block)
						@keys = []
						super
					end
		
					def self.[](*args)
						# The rails implementation doesn't have this function, which
						# is necessary to create an ohash inline. Mind, this whole
						# method interface in Ruby is a big WTF.
						# TODO: The parsing of args is a bit ad hoc
						## Main:
						new_ohash = Ohash.new()
						# process args
						arg_cnt = args.length
						curr_posn = 0
						while (curr_posn < arg_cnt)
							curr_arg = args[curr_posn]
							if (curr_arg.is_a?(Hash))
								# process keyword args
								curr_arg.each_pair { |k, v|
									new_ohash[k] = v
								}
								curr_posn += 1
							else
								# process pairs of positional args
								new_ohash[curr_arg] = args[curr_posn+1]
								curr_posn += 2
							end
						end
						## Return:
						return new_ohash
					end
		
					def initialize_copy(other)
						super
						# make a deep copy of keys
						@keys = other.keys
					end
		
					def []=(key, value)
						@keys << key if !has_key?(key)
						super
					end
		
					def delete(key)
						if has_key?(key)
							index = @keys.index(key)
							@keys.delete_at(index)
						end
						super
					end
					
					def delete_if
						super
						sync_keys!
						self
					end
		
					def reject!
						super
						sync_keys!
						self
					end
		
					def reject(&block)
						dup.reject!(&block)
					end
		
					def keys
						return @keys.dup
					end
		
					def values
						return @keys.collect { |key| self[key] }
					end
		
					def to_hash
						self
					end
		
					def each_key
						@keys.each { |key| yield key }
					end
		
					def each_value
						@keys.each { |key| yield self[key]}
					end
		
					def each
						@keys.each {|key| yield [key, self[key]]}
					end
		
					alias_method :each_pair, :each
		
					def clear
						super
						@keys.clear
						self
					end
		
					def shift
						k = @keys.first
						v = delete(k)
						[k, v]
					end
		
					def merge!(other_hash)
						other_hash.each {|k,v| self[k] = v }
						self
					end
		
					def merge(other_hash)
						dup.merge!(other_hash)
					end
		
					def inspect
						# the rails original has a weird recursive bug here
						"#<OHash #{super.inspect}>"
					end
		
				private
		
					def sync_keys!
						@keys.delete_if {|k| !has_key?(k)}
					end
					
				end
			
			end
			
		end
	end
end

### END
