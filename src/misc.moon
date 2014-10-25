import LeafThing from require "thing"
import EventEmitter from require "event"

import rectangle, line from love.graphics
import atan2, cos, sin, random, abs from math
import type, pairs, ipairs from _G

-- shamelessly stolen from lovekit.
class Box
	self.from_pt = (x1, y1, x2, y2) ->
		Box x1, y1, x2 - x1, y2 - y1

	new: (@x, @y, @w, @h) =>

	unpack: => @x, @y, @w, @h
	unpack2: => @x, @y, @x + @w, @y + @h

	dup: => Box @unpack!

	pad: (amount) =>
		amount2 = amount * 2
		Box @x + amount, @y + amount, @w - amount2, @h - amount2

	pos: => @x, @y
	set_pos: (@x, @y) =>

	move: (x, y) =>
		@x += x
		@y += y
		@

	move_center: (x,y) =>
		@x = x - @w / 2
		@y = y - @h / 2
		@

	center: =>
		@x + @w / 2, @y + @h / 2

	touches_pt: (x, y) =>
		x1, y1, x2, y2 = @unpack2!
		x > x1 and x < x2 and y > y1 and y < y2

	touches_box: (o) =>
		x1, y1, x2, y2 = @unpack2!
		ox1, oy1, ox2, oy2 = o\unpack2!

		return false if x2 <= ox1
		return false if x1 >= ox2
		return false if y2 <= oy1
		return false if y1 >= oy2
		true

	contains_box: (o) =>
		x1, y1, x2, y2 = @unpack2!
		ox1, oy1, ox2, oy2 = o\unpack2!

		return false if ox1 <= x1
		return false if ox2 >= x2

		return false if oy1 <= y1
		return false if oy2 >= y2

		true

	-- is self left of box
	left_of: (box) =>
		self.x < box.x

	above_of: (box) =>
		self.y <= box.y + box.h

	draw: =>
		rectangle "fill", @unpack!

	outline: =>
		rectangle "line", @unpack!

	random_point: =>
		@x + random! * @w, @y + random! * @h

	-- make sure width and height aren't negative
	fix: =>
		x,y,w,h = @unpack!

		if w < 0
			x += w
			w = -w

		if h < 0
			y += h
			h = -h

		Box x,y,w,h

	scale: (sx=1, sy=sx, center=false) =>
		scaled = Box @x, @y, @w * sx, @h * sy
		scaled\move_center @center! if center
		scaled

	-- change size of w and h, preserving center
	shrink: (dx=1, dy=dx) =>
		hx = dx / 2
		hy = dy / 2

		w = @w - dx
		h = @h - dy

		error "box too small" if w < 0 or h < 0
		Box @x + hx, @y + hy, w, h

	-- make this box bigger such that the box now will contain both boxes
	add_box: (other) =>
		if @w == 0 or @h == 0
			@x,@y,@w,@h = other\unpack!
		else
			x1,y1,x2,y2 = @unpack2!
			ox1, oy1, ox2, oy2 = other\unpack2!
			x1 = math.min x1, ox1
			y1 = math.min y1, oy1
			x2 = math.max x2, ox2
			y2 = math.max x2, oy2

			@x = x1
			@y = y1
			@w = x2 - x1
			@h = y2 - y1
		nil

	__tostring: =>
		("box<(%d, %d), (%d, %d)>")\format @unpack!


class Clock --yes it's like an actual clock
	new: (@face = 12, @rate=1, @time=1, ...) =>
		@enabled = false --start out stopped
		@visible = false
		@evt = EventEmitter!

		@hand = @time
		@face = 12
		
	start: =>
		@enabled = true

	stop: =>
		@enabled = false

	setFace: (num) =>
		@face = num

	update: (dt) =>
		if @enabled
			oldHand = @hand
			@time += (dt*@rate)
			@hand = math.floor @time

			if oldHand != @hand
				if @hand > @face
					@evt\fire("toll", {at: oldHand})
					@reset!
				@evt\fire("tick", {old: oldHand, new: @hand})


	reset: =>
		@time = 1
		@hand = 1

lMod = (x, b) ->
	times = math.floor x/b
	return x-(b*(times-1)+(b-1))

dimConvert = (num, width) ->
	x = 0
	y = 1
	for i=1, num
		x += 1
		if x > width
			x = 1
			y += 1
	return x, y

sign = (num) ->
	if num < 0
		return -1
	else
		return 1

fixed_time_step = (rate, fn) ->
	target_dt = 1 / rate
	accum = 0
	(real_dt) =>
		accum += real_dt
		while accum > target_dt
			fn @, target_dt
			accum -= target_dt

{:Clock, :Box,:dimConvert, :sign, :fixed_time_step}