-- an entity is a thing with a box, movement and a sprite
import Test from require "components"
import Thing from require "thing"

class Entity extends Thing
	new: (@x, @y, ...) =>
		super ...
		self\addChild(Test!)
		print(self\getChildren("Test")[1].__class.__name)



{:Entity}