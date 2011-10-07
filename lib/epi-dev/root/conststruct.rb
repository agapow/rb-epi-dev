

# A closed struct with added feature of instance variable being unmodifiable.
#
# 
class ConstStruct < ClosedStruct

	private
		def new_ostruct_member(name)
			name = name.to_sym
			unless self.respond_to?(name)
				meta = class << self; self; end
				meta.send(:define_method, name) { @table[name] }
			end
		end

end