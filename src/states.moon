-- Basically, all states have a collection of Things which know how to draw! themselves
class State
	new: =>
		@children = {}
		@camera = Camera!

	addChild: (child, enabled=true, visible=true) =>
		child.enabled, child.visible = enabled, visible

		-- decorate child with some new convenience functions
		with child
			.enable = => @enabled = true
			.disable = => @enabled = false
			.show = => @visible = true
			.hide = => @visible = false

		table.insert @children child
		if child.added
			child\added self
		child.parent = self
		return child

	init: =>

	enter: (previous, ...) =>

	leave: =>

	update: (dt) =>
		for child in *@children
			if child.update and child.enabled
				child\update dt

	draw: =>
		@camera\attach!
		for child in *@children
			child\draw!
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
		
	cdraw: =>
		love.graphics.print("hello", 300, 300)

	update: (dt) =>
		super!
		@camera\move(1, dt)

{:State, :worldState}