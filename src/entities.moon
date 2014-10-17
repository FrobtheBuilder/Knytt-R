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
		@runspeed = 100
		@sprite = @addChild(Sprite "assets/img/sprites/juni.png", {rows: 10, cols: 10})
		

	added: (to) =>
		super to
		@movement = @addChild(Movement @parent.physics)

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
				rate: @rate
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
		if key == "right"
			@sprite\setSet "run"
			@sprite\play!

			@movement\setAcceleration @runspeed, nil

		if key == "left"
			@sprite\setSet "run"
			@sprite\play!
			@movement\setAcceleration -@runspeed, nil

	keyreleased: (key) =>
		if key == "right" or key == "left"
			@movement\setAcceleration 0, nil
			@sprite\setSet "stand"

{:Entity, :Juni}