import Component from require "components"
import Clock, dimConvert from require "misc"
-- dependencies:
-- parent must have x and y available as a location to draw the sprite

class RawSprite

	new: (filepath, params) =>

		@sets = {}
		@currentSet = {}

		@image = love.graphics.newImage(filepath)

		@clock = Clock!
		@frame = {}

		if (params.rows or params.cols) and (params.cols > 1 or params.rows > 1)
			@quads = @split @image, params

	update: (dt) =>
		@clock\update dt

	addSet: (params) => --{name: "", frames: { {x, y}, {x, y}, {x, y} } }
		if type(params.frames[1]) == "table" and params.frames[1][2] == "all"
			row = params.frames[1][1]
			for i=1, #@quads
				table.insert params.frames, {row, i}
			table.remove params.frames, 1

		elseif type(params.frames[1]) == "table" and params.frames[1][1] == "all"
			col = params.frames[1][2]
			for i=1, #@quads[col]
				table.insert params.frames, {i, col}
			table.remove params.frames, 1

		if params.flags and params.flags["strip"]
			cols = #@quads
			start, finish = params.frames[1], params.frames[2]
			params.frames = {}

			for i=start, finish
				table.insert params.frames, {dimConvert i, cols}

		table.insert @sets, params

	addSets: (list) =>
		for set in *list
			@addSet(set)

	setSet: (name) =>
		
		for set in *@sets
			if set.name == name
				@currentSet = set
		--@frame = @currentSet.frames[1]
		
		
		onTick = (e) ->
			@setFrame(e.new)

		@clock.signals\clear "tick"

		if #@currentSet.frames > 1
			with @clock
				.rate = @currentSet.rate
				\reset!
				\setFace #@currentSet.frames
				.signals\register "tick", onTick
						

	setFrame: (index) =>
		@frame = @currentSet.frames[index]

	play: =>
		@clock\start!

	stop: =>
		@clock\stop!

	split: (sheet, params) =>
		quads = {}
		params.w = sheet\getWidth!/params.cols unless params.w
		params.h = sheet\getHeight!/params.rows unless params.h
		w, h, rows, cols = params.w, params.h, params.rows, params.cols

		for x=1, cols
			quads[x] = {}
			for y=1, rows
				quads[x][y] = love.graphics.newQuad((x*w)-w, (y*h)-h, w, h, @image\getDimensions!)
		return quads

	draw: (x, y) => --Nonstandard signature, watch out.

		if @quads
			if @currentSet.name and @frame
				love.graphics.draw(@image, @quads[@frame[1]][@frame[2]], x, y)
		else
			love.graphics.draw(@image, x, y)


class Sprite extends Component
	new: (filepath, params, ...) => --params = {w: width, h: height, rows: rows, cols: columns}
		super ...
		@raw = RawSprite filepath, params --yeah, Sprite is really just a decorator for RawSprite
		@offset = {x: 0, y: 0}


	added: (to) =>
		super\added to

	update: (dt) =>
		@raw\update dt

	addSet: (params) =>
		@raw\addSet params

	addSets: (list) =>
		@raw\addSets list

	setSet: (name) =>
		@raw\setSet name

	setFrame: (index) =>
		@raw\setFrame index

	offset: (x, y) =>
		@offset.y, @offset.y = x, y

	draw: =>
		if @parent and @parent.x and @parent.y
			@raw\draw(@parent.x + @offset.x, @parent.y + @offset.y)

	play: (callback) =>
		@raw\play!
		if callback

			onToll = (e) ->
				callback e
				@raw.clock.signals\remove "toll", onToll
			@raw.clock.signals\register "toll", onToll


	stop: =>
		@raw\stop!


{:Sprite}