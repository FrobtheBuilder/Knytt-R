import LeafThing from require "thing"

class Component extends LeafThing
	new: (@allowMultiple=false, ...) =>
		super ...

	added: (to) =>
		if #(to\getChildren self.__class.__name) > 1
			return nil, "Cannot have more than one" unless @allowMultiple
		super to

class Movement extends Component
	new: (@physics, ...) =>
		super false, ...
		@vx = 0
		@vy = 0

		@ax = 0
		@ay = 0

		@accum = {x: 0, y: 0}


	move: (dx, dy) =>
		@accum.x += dx
		@accum.y += dy

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



	setVelocity: (vx, vy) =>
		if vx then @vx = vx
		if vy then @vy = vy

		@accum.x = 0
		@accum.y = 0

	setAcceleration: (ax, ay) =>
		if ax then @ax = ax
		if ay then @ay = ay

	accelerate: (vx, vy) =>
		if vx then @ax += vx
		if vy then @ax += vy

	update: (dt) =>

		if @physics
			@vx = @vx/@physics.friction

		@vx += @ax
		@vy += @ay


		if @parent
			@move @vx*dt, @vy*dt


class Physics extends Component
	new: (options, ...) => --{ friction: , gravity: }
		@friction = options.friction
		@gravity = options.gravity
		super false, ...



{:Component, :Movement, :Physics}