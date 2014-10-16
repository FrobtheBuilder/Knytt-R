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
		@sprite = @addChild(Sprite "assets/img/sprites/juni.png", {rows: 10, cols: 10})
		@move = @addChild(Movement!)
		@move\setVelocity(60, 60)

		@sprite\addSet {
			name: "walk",
			rate: 15,
			frames: {
				{1, 1},
				{2, 1},
				{3, 1},
				{4, 1},
				{5, 1},
				{6, 1},
				{7, 1},
				{8, 1},
				{9, 1},
				{10, 1},
			}
		}
		@sprite\setSet("walk")


{:Entity, :Juni}