
# Create and return a new class with the given name.
#
def make_class(superkls, name)
	# TODO: but what namespace is it created in?
	kls = Class.new(superkls)
	Object.const_set (name, kls)
	return kls
end
