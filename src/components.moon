import LeafThing from require "thing"

class Component extends LeafThing
	new: (@allowMultiple=false, ...) =>
		super ...

	added: (to) =>
		if #(to\getChildren self.__class.__name) > 1
			return nil, "Cannot have more than one" unless @allowMultiple
		super to

class Movement extends Component
	new: (...) =>
		super ...
		@dx = 0
		@dy = 0
		@accum = {x: 0, y: 0}


	setVelocity: (dx, dy) =>
		@dx = dx
		@dy = dy

		@accum.x = 0
		@accum.y = 0

	update: (dt) =>
		if @parent

			@accum.x += @dx*dt
			@accum.y += @dy*dt

			if @accum.x >= 1
				@parent.x += 1
				@accum.x -= 1

			if @accum.x <= -1
				@parent.x -= 1
				@accum.x += 1

			if @accum.y >= 1
				@parent.y += 1 
				@accum.y -= 1

			if @accum.y <= -1
				@parent.y -= 1 
				@accum.y += 1


{:Component, :Movement}