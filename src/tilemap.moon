import Box from require "misc"

class Tile --wow why is this class even
	new: (@tileset, col, row) =>
		@quad = @tileset\getTileQuad col, row

	draw: (x, y) =>
		love.graphics.draw @tileset.image, @quad, x, y

class Tilemap
	new: (@tilesets={}, @x, @y, viewportFunc) =>
		@viewport = {}
		with @viewport
			.x, .y = viewportFunc!
			.width, .height = love.window.getDimensions!
			.hWidth, .hHeight = .width/2, .height/2
			.func = viewportFunc
			.refresh = =>
				@x, @y = @.func!

		@vp = @viewport -- it's shorter

		@tiles = {}
		@bounds = Box 0, 0, 30, 30

	load: (source) => 
	-- source = {type: ("empty"/"array"/"file"), 
	-- 				data: {:l, :c, :r, :set}/{array}/filepath}
		if source.type == "empty"
			if not @tiles[source.data.l] 
				@tiles[source.data.l] = {}
			for c=1,source.data.c
				table.insert @tiles[source.data.l], {}
				for r=1,source.data.r
					table.insert @tiles[source.data.l][c], Tile @tilesets[source.data.set], 1, 2
	draw: =>
		@viewport\refresh!

		for layer in *@tiles
			if layer[1] and layer[1][1]
				for c=1, #layer
					for r=1, #layer[c]

						realX, realY = @real c, r, layer[c][r]
						if realX > (@vp.x - (@vp.hWidth + layer[c][r].tileset.cell.width))
							if realX < (@vp.x + @vp.hWidth)
								if realY > (@vp.y - (@vp.hHeight + layer[c][r].tileset.cell.width))
									if realY < (@vp.y + @vp.hHeight)
										layer[c][r]\draw @real c, r, layer[c][r]

	real: (c, r, tile) =>
		return (c-1)*tile.tileset.cell.width, (r-1)*tile.tileset.cell.height

class Tileset
	new: (path, @cols, @rows, cell) =>
		@image = love.graphics.newImage path

		@real = 
			width: @image\getWidth! 
			height: @image\getHeight!

		@cell = if type(cell) == "table"
			width: cell[1], height: cell[2]
		else
			width: cell, height: cell

	getTileQuad: (@col, @row) =>
		love.graphics.newQuad (@col-1)*@cell.width, (@row-1)*@cell.height,
										@cell.width, @cell.height,
										@real.width, @real.height
{:Tilemap, :Tileset}