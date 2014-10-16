-- Basically, all states are things, 
-- so they have a collection of Things 
-- which know how to update! and draw! themselves

import Thing from require "thing"
import Juni from require "entities"

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

	keypressed: (key, code) =>

	keyreleased: (key, code) =>

	mousepressed: (x, y, button) =>

	mousereleased: (x, y, button) =>

	quit: =>

class worldState extends State

	new: =>
		super!
		@dt = 0
		@addChild(Juni 10, 10)
		
	sdraw: =>
		love.graphics.print(1/@dt)
		

	update: (dt) =>
		@dt = dt
		super dt

{:State, :worldState}