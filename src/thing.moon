-- basically a general purpose node that can be extended for 
--gamestates, entities, components you name it
-- knows how to update/draw/etc self. 
-- Can contain other things that also know how to do this (or even not).
-- Don't forget to super! or *Children! if you want to use this functionality.

import EventEmitter from require "event"
class Thing 

	new: (@enabled=true, @visible=true) =>
		@children = {}
		@isThing = true --always be able to tell if Thing is in the family tree
		@evt = EventEmitter! -- all things are capable of events
		@signals = @evt

	setParent: (to) =>
		@parent = to

	added: (to) =>
		@setParent to

	remove: =>
		if @parent
			@setParent nil
			@parent\removeChild self
			@removed!

	removed: =>
		
	draw: =>
		if @children then @drawChildren!
		
	drawChildren: =>
		for child in *@children
			if child.draw and (child.visible or type child.visible == "nil")
				child\draw!


	update: (dt) =>
		if @children then @updateChildren dt

	updateChildren: (dt) =>
		for child in *@children
			if child.update and (child.enabled or type child.enabled == "nil")
				child\update dt

	destroy: =>
		@remove!
		@destroyed!
		self = nil --dead.

	destroyed: =>

	enable: => @enabled = true
	disable: => @enabled = false
	show: => @visible = true
	hide: => @visible = false

	addChild: (child) =>
		table.insert @children, child
		if child.added
			child\added self
			@signals\fire "added-child", child
		return child --for fast instantiation

	removeChild: (child) =>
		for i, c in ipairs @children
			if c == child
				table.remove @children, i
				if c.parent --determine if called from c.remove
					c\setParent nil
					c\removed! --if not, do its job for it

	getChildren: (classs) =>
		return [child for child in *@children when child.__class.__name == classs]

	getChild: (classs) => --for components where there is only one
			for child in *@children
				if child.__class.__name == classs
					return child

class LeafThing extends Thing
	new: (...) =>
		super ...
		@children = nil
		@getChildren = nil
		@addChild = nil
		@getChild = nil
		@removeChild = nil -- leaves don't have children.


{:Thing, :LeafThing}