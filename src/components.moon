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
		@accumx = 0
		@accumy = 0

	setVelocity: (dx, dy) =>
		@dx = dx
		@dy = dy

		@accumx = 0
		@accumy = 0

	update: (dt) =>
		if @parent

			@accumx += @dx*dt
			@accumy += @dy*dt

			if @accumx >= 1
				@parent.x += 1
				@accumx -= 1

			if @accumx <= -1
				@parent.x -= 1
				@accumx += 1

			if @accumy >= 1
				@parent.y += 1 
				@accumy -= 1

			if @accumy <= -1
				@parent.y -= 1 
				@accumy += 1


{:Component, :Movement}