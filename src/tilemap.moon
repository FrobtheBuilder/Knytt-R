import Box from require "misc"

class Tile
	new: (@tileset, col, row) =>
		@quad = @tileset\getTileQuad col, row

	draw: (x, y) =>
		love.graphics.draw @tileset.image, @quad, x, y

class Tilemap
	new: (@tilesets={}) => -- tilesets is an array of images.
		@tiles = {}

	load: (source) => -- source = {type: ("empty"/"array"/"file"), data: {:l, :c, :r, :set}/{array}/filepath}

		if source.type == "empty"
			if not @tiles[source.data.l] 
				@tiles[source.data.l] = {}
			for c=1,source.data.c
				table.insert @tiles[source.data.l], {}
				for r=1,source.data.r
					table.insert @tiles[source.data.l][c], Tile @tilesets[source.data.set], 1, 3
	draw: =>
		if @tiles[1] and @tiles[1][1] and @tiles[1][1][1]
			-- ok lets hardcode layer 1 for now.
			for c=1, #@tiles[1]
				for r=1, #@tiles[1][c]
					@tiles[1][c][r]\draw c*24, r*24

class Tileset
	new: (path, @cols, @rows, cell) =>
		@image = love.graphics.newImage path
		@raw = {width: @image\getWidth!, height: @image\getHeight!}
		if type(cell) == "table"
			@cell = {width: cell[1], height: cell[2]}
		else
			@cell = {width: cell, height: cell}
		print @cell.width, @cell.height

	getTileQuad: (@col, @row) =>
		love.graphics.newQuad @col*@cell.width, @row*@cell.height,
										@cell.width, @cell.height,
										@raw.width, @raw.height
{:Tilemap, :Tileset}