-- Basically, all states are things, 
-- so they have a collection of Things 
-- which know how to update! and draw! themselves

import Thing from require "thing"
import Juni from require "juni"
import Tilemap, Tileset from require "tilemap"
import Physics from require "components"
import sign, fixed_time_step from require "misc"


class State extends Thing
	new: =>
		super!
		@camera = Camera!

	init: =>

	enter: (previous, ...) =>

	leave: =>
	
	draw: => --totally override this one to support the camera
		@camera\attach!
		super\draw!
		@cdraw!
		@camera\detach!
		@sdraw!

	cdraw: =>

	sdraw: =>

	focus: =>

	keypressed: (key, isrepeat) =>

	keyreleased: (key) =>

	mousepressed: (x, y, button) =>

	mousereleased: (x, y, button) =>

	quit: =>

class worldState extends State

	new: =>
		super!
		@dt = 0
		@juni = @addChild(Juni 10, 500)
		@map = Tilemap {Tileset "assets/img/tilesets/Tileset1.png", 16, 8, 24}
		@map\load type: "empty", data: {c: 10, r: 10, l: 1, set: 1}
		
	sdraw: =>
		love.graphics.print(1/@dt)

	cdraw: =>
		@map\draw!
		
	update: fixed_time_step 60, (dt) =>
		@dt = dt
		super dt
		@camera\lookAt @juni.x, @juni.y-150

	keypressed: (key, isrepeat) =>
		@juni\keypressed key, isrepeat

	keyreleased: (key) =>
		@juni\keyreleased key

{:State, :worldState}