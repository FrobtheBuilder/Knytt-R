import LeafThing from require "thing"
Signals = require "lib.hump.signal"

class Clock
	new: (@rate=1, @time=1, ...) =>
		@enabled = true
		@visible = false
		@signals = Signals.new! -- for Thing compatibility

		@hand = @time
		

	update: (dt) =>
		oldHand = @hand
		@time += (dt*@rate)
		@hand = math.floor @time

		if oldHand != @hand
			@signals\emit("tick", {old: oldHand, new: @hand})

	reset: =>
		@time = 1
		@hand = 1

{:Clock}