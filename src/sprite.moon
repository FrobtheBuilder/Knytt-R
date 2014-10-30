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
			@quads, @cellWidth, @cellHeight = @split @image, params

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

		if not params.flags then params.flags = {}

		if params.flags["strip"]
			cols = #@quads
			start, finish = unpack params.frames
			params.frames = {}

			for i=start, finish
				table.insert params.frames, {dimConvert i, cols}

		table.insert @sets, params

	addSets: (list) =>
		for set in *list
			@addSet(set)

	setFlip: (direction) =>
		if type(direction) == "boolean"
			if @currentSet then @currentSet.flags.flipped = direction
		else
			@currentSet.flags.flipped = (direction == "left")

	setSet: (name) =>
		for set in *@sets
			if set.name == name
				@currentSet = set
				
		@clock.evt\remove "tick"

		if #@currentSet.frames > 1
			with @clock
				.rate = @currentSet.rate
				\reset!
				\setFace #@currentSet.frames
				.evt\on "tick", (e) ->
					@setFrame(e.new)
		else
			@setFrame(1)
						

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
		return quads, w, h

	draw: (x, y) =>

		if @quads
			if @currentSet.name and @frame
				if not @currentSet.flags.flipped
					love.graphics.draw @image, @quads[@frame[1]][@frame[2]], x, y
				else
					love.graphics.draw @image, @quads[@frame[1]][@frame[2]], x, y, 0, -1, 1, @cellWidth, 0
		else
			love.graphics.draw(@image, x, y)


class Sprite extends Component
	new: (filepath, params, ...) => --params = {w: width, h: height, rows: rows, cols: columns}
		super ...
		@raw = RawSprite filepath, params --yeah, Sprite is really just a decorator for RawSprite
		@offset = {x: 0, y: 0}
		@facing = "right"

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
		@raw\setFlip @facing

	setFrame: (index) =>
		@raw\setFrame index

	setFlip: (direction) =>
		@facing = direction
		@raw\setFlip direction

	offSet: (x, y) =>
		@offset.x, @offset.y = x, y

	draw: =>
		if @parent and @parent.x and @parent.y
			@raw\draw(@parent.x - @offset.x, @parent.y - @offset.y)

	play: (callback) =>
		@raw\play!
		if callback
			@raw.clock.evt\once "toll", (e) ->
				callback e

	stop: =>
		@raw\stop!


{:Sprite}