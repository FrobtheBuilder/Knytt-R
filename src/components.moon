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

		@v = {x: 0, y: 0}
		--@vx = 0
		--@vy = 0
		@vmax = {x: 0, y: 0}

		@a = {x: 0, y: 0}
		--@ax = 0
		--@ay = 0

		@accum = {x: 0, y: 0}
		@moving = false
		


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
		if vx then @v.x = vx
		if vy then @v.y = vy

		@accum.x = 0
		@accum.y = 0

	setAcceleration: (ax, ay) =>
		if ax then @a.x = ax
		if ay then @a.y = ay

	accelerate: (vx, vy) =>
		if vx then @a.x += vx
		if vy then @a.x += vy

	update: (dt) =>

		if @physics
			if @v.x > 0 
				@v.x -= (@physics.friction*dt)
			else
				@v.x += (@physics.friction*dt)

		if @v.x < @vmax.x and @v.x > -@vmax.x
			@v.x += @a.x*dt
		elseif @v.x > @vmax.x
			@v.x = @vmax.x
		else
			@v.x = -@vmax.x
		@v.y += @a.y*dt


		if @parent
			@move @v.x*dt, @v.y*dt

		if not @moving
			@a.x, @a.y = 0, 0

class Physics extends Component
	new: (options, ...) => --{ friction: , gravity: }
		@friction = options.friction
		@gravity = options.gravity
		super false, ...



{:Component, :Movement, :Physics}