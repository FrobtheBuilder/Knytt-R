import LeafThing from require "thing"
Signals = require "lib.hump.signal"

class Clock --yes it's like an actual clock
	new: (@face = 12, @rate=1, @time=1, ...) =>
		@enabled = false --start out stopped
		@visible = false
		@signals = Signals.new! -- for Thing compatibility

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
					@signals\emit("toll", {at: oldHand})
					@reset!
				@signals\emit("tick", {old: oldHand, new: @hand})


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



{:Clock, :dimConvert}