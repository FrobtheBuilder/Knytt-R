-- Basically, all states are things, 
-- so they have a collection of Things 
-- which know how to update! and draw! themselves

import Thing from require "thing"
import Entity from require "entities"

class State extends Thing
	new: =>
		super!
		@camera = Camera!

	init: =>

	enter: (previous, ...) =>

	leave: =>

	update: (dt) =>
		super\update dt --not pointless at all I swear

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
		@camera\zoomTo 1
		self\addChild(Entity!)
		
	cdraw: =>
		

	update: (dt) =>
		super!

{:State, :worldState}