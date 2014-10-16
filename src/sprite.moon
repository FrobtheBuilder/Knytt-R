import Component from require "components"
import Clock from require "misc"
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
		table.insert @sets, params

	setSet: (name) =>
		
		for set in *@sets
			if set.name == name
				@currentSet = set
		@frame = @currentSet.frames[1]

		if #@currentSet.frames > 1
			with @clock
				.rate = @currentSet.rate
				.signals\clear!
				\reset!
				.signals\register "tick", (e) ->
					if e.new > #@currentSet.frames
						@clock\reset!
						@frame = @currentSet.frames[@clock.hand]
					else
						@frame = @currentSet.frames[e.new]

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
			if @currentSet.name
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

	setSet: (name) =>
		@raw\setSet name

	offset: (x, y) =>
		@offset.y, @offset.y = x, y

	draw: =>
		if @parent and @parent.x and @parent.y
			@raw\draw(@parent.x + @offset.x, @parent.y + @offset.y)


{:Sprite}