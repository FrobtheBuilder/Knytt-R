import LeafThing from require "thing"
import sign, fixed_time_step from require "misc"

class Component
	new: (@parent) =>

	update: (dt) =>
		
	destroy: =>
		self = nil

class Physics extends Component
	new: (@data, ...) => --@data = {gravity: number, hitbox: box, collideWith: table of boxes}
		super ...
		@p = @parent

	update: (dt) =>
		@p.box\set_pos @p.x, @p.y
		@p.v.x /= (1 + (@data.friction*dt))

		
{:Component, :Physics}