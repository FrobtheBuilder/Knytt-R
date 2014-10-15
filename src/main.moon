--require "lovekit.all" --something tells me that I won't be using this much due to UTTER LACK OF DOCUMENTATION FUCK
import State, worldState from require "states"

export GAMESTATE = require "lib.hump.gamestate"
export TIMER = require "lib.hump.timer"
export Camera = require "lib.hump.camera"


love.load = ->
	GAMESTATE.switch(worldState!)

love.update = (dt) ->
	GAMESTATE.update dt
	TIMER.update dt

love.draw = ->
	GAMESTATE.draw!

love.keypressed = (key, code) ->
	GAMESTATE.keypressed(key, code)

love.mousepressed = (x, y, button) ->
	GAMESTATE.mousepressed(x, y, button)