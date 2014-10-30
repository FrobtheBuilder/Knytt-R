import Entity from require "entities"
import Sprite from require "sprite"
import Box from require "misc"
import Movement from require "movement"
import Physics from require "components"

class Juni extends Entity
	new: (...) =>
		super ...
		@rate = 15
		@walkspeed = 100
		@runspeed = 50
		@topspeed = 50
		@movingRight = false
		@movingLeft = false
		@sprite = Sprite "assets/img/sprites/juni.png", {rows: 10, cols: 10}, self
		@sprite\offSet 10, 10
		@box = Box 0,0,5,13
		

	added: (to) =>
		super to
		@movement = Movement self
		@physics = Physics gravity: 20, friction: 20, collideWith: nil, self
		@v.max.x = @topspeed

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
			@sprite\setSet "fall"
			@sprite\stop!

	keypressed: (key, isrepeat) =>
		@movement.moving = true
		if key == "right"
			
			@sprite\setSet "run"
			@sprite\setFlip "right"
			@sprite\play!
			@movement\setAcceleration @runspeed, nil
			@movingRight = true

		elseif key == "left"
			@sprite\setSet "run"
			@sprite\setFlip "left"
			@sprite\play!
			@movement\setAcceleration -@runspeed, nil
			@movingLeft = true

		if @movingLeft and @movingRight
			@movingRight = false
			@movingLeft = false

	keyreleased: (key) =>

		if @movingLeft and @movingRight
			@movingRight = false
			@movingLeft = false

		if key == "right" then @movingRight = false
		if key == "left" then @movingLeft = false


		if not @movingLeft and not @movingRight
			@movement.moving = false
			@sprite\setSet "stand"


	update: (dt) =>
		@movement\update dt
		@physics\update dt
		@sprite\update dt

	draw: =>
		@sprite\draw!
		if BOXES
			love.graphics.point(@x, @y) --show the origin
			@box\outline!

{:Juni}