import LeafThing from require "thing"

class Component extends LeafThing
	new: (@allowMultiple=false, ...) =>
		super ...

	added: (to) =>
		if to.getChild
			return nil, "Cannot have more than one" unless @allowMultiple
		super to


class Test extends Component
	new: (...) =>


{:Component, :Test}