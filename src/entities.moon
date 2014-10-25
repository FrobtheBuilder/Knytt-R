-- an entity is a thing with a box, movement and a sprite
import Movement from require "movement"
import Physics from require "components"
import Sprite from require "sprite"
import Thing from require "thing"
import Box from require "misc"


-- an Entity has position, velocity, acceleration and a hitbox. 
-- You don't have to use all those but at least set them.
class Entity extends Thing
	new: (@x, @y, ...) =>
		super ...
		@v = {x: 0, y: 0, max: {x: 0, y: 0}}
		@a = {x: 0, y: 0}
		@box = {}--make it yerself

	update: (dt) =>
		@box\move @x, @y
		
{:Entity}