class EventEmitter
	new: =>
		@events = {}

	on: (event, fn) =>
		if not @events[event]
			@events[event] = {}
			@events[event].once = {}
		table.insert @events[event], fn

	fire: (event, ...) =>
		if @events[event]
			for fn in *@events[event]
				fn(...)
				for oncefn in *@events[event].once
					if oncefn == fn
						@remove event, fn

	remove: (event, func) =>
		if @events[event]
			if func
				for i, fn in ipairs @events[event]
					if fn == func
						@events[event][i] = nil
			else
				@events[event] = nil

	once: (event, fn) =>
		@on event, fn
		table.insert @events[event].once, fn

{:EventEmitter}