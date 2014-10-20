-- an entity is a thing with a box, movement and a sprite
import Test, Movement from require "components"
import Sprite from require "sprite"
import Thing from require "thing"

class Entity extends Thing
	new: (@x, @y, ...) =>
		super ...
		

class Juni extends Entity
	new: (...) =>
		super ...
		@rate = 15
		@walkspeed = 100
		@runspeed = 6000
		@topspeed = 300
		@movingRight = false
		@movingLeft = false
		@sprite = @addChild(Sprite "assets/img/sprites/juni.png", {rows: 10, cols: 10})
		

	added: (to) =>
		super to
		@movement = @addChild(Movement gravity: 20, friction: 2000)
		@movement.vmax.x = @topspeed

		@sprite\addSets {
			{
				name: "walk",
				rate: @rate,
				frames: {
					{"all", 1}
				}
			}
			{
				name: "run"
				rate: @rate+6
				flags: {strip: true}
				frames: {11, 22}
			}
			{
				name: "climb"
				rate: @rate*2
				flags: {strip: true}
				frames: {23, 30}
			}
			{
				name: "startfall"
				rate: @rate
				flags: {strip: true}
				frames: {31, 35}
			}
			{
				name: "fall"
				rate: @rate
				flags: {strip: true}
				frames: {36, 42}
			}
			{
				name: "stand"
				rate: @rate
				frames: {
					{8, 5}
				}
			}
		}

		@sprite\setSet "startfall"
		@sprite\setFrame 3


		@sprite\play ->
			print self
			@sprite\setSet "fall"
			@sprite\stop!
			print @sprite.raw.frame == @sprite.raw.currentSet.frames[2]

	keypressed: (key, isrepeat) =>
		@movement.moving = true
		if key == "right"
			@movingRight = true
			@sprite\setSet "run"
			@sprite\setFlip "right"
			@sprite\play!

			@movement\setAcceleration @runspeed, nil

		elseif key == "left"
			@movingLeft = true
			@sprite\setSet "run"
			@sprite\setFlip "left"
			@sprite\play!
			@movement\setAcceleration -@runspeed, nil

	keyreleased: (key) =>
		if key == "right" then @movingRight = false
		if key == "left" then @movingLeft = false

		if not @movingLeft and not @movingRight
			@movement.moving = false
			@sprite\setSet "stand"

{:Entity, :Juni}