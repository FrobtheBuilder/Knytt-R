import Component from require "components"

class Movement extends Component
	new: (...) =>
		super ...
		@p = @parent

		@accum = {x: 0, y: 0}
		@moving = false
		

	move: (dx, dy) =>
		@accum.x += dx
		@accum.y += dy


		while @accum.x >= 1
			@parent.x += 1
			@accum.x -= 1

		while @accum.x <= -1
			@parent.x -= 1
			@accum.x += 1

		while @accum.y >= 1
			@parent.y += 1 
			@accum.y -= 1

		while @accum.y <= -1
			@parent.y -= 1 
			@accum.y += 1

	setVelocity: (vx, vy) =>
		if vx then @p.v.x = vx
		if vy then @p.v.y = vy

		@accum.x = 0
		@accum.y = 0

	setAcceleration: (ax, ay) =>
		if ax then @p.a.x = ax
		if ay then @p.a.y = ay

	accelerate: (vx, vy) =>
		if vx then @p.a.x += vx
		if vy then @p.a.x += vy

	update: (dt) =>

		if @p.v.x < @p.v.max.x and @p.v.x > -@p.v.max.x
			@p.v.x += @p.a.x*dt
		elseif @p.v.x > @p.v.max.x
			@p.v.x = @p.v.max.x
		elseif @p.v.x < -@p.v.max.x
			@p.v.x = -@p.v.max.x

		if not @moving
			@p.a.x, @p.a.y = 0, 0
			
		@p.v.y += @p.a.y*dt

		if @parent
			@move @p.v.x, @p.v.y

{:Movement}