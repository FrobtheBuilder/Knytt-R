import Component from require "components"

-- dependencies:
-- parent must have x and y available as a location to draw the sprite

class Sprite extends Component
	new: (...) =>
		super ...
		@raw = RawSprite! --yeah, Sprite is really just a decorator for RawSprite
		@offset = {x: 0, y: 0}


	added: (to) =>
		super to

	update: (dt) =>
		@raw\update!

	offset: (x, y) =>
		@offset.y, @offset.y = x, y

	draw: =>
		if @parent and @parent.x and @parent.y
			@raw\draw(@parent.x + @offset.x, @parent.y + @offset.y)


class RawSprite

	new: (filepath) =>
		@image = love.graphics.newImage filepath

	update: =>

	draw: (x, y) =>
		love.graphics.draw(@image, x, y)


