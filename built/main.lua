local State, worldState
do
  local _obj_0 = require("states")
  State, worldState = _obj_0.State, _obj_0.worldState
end
local EventEmitter
do
  local _obj_0 = require("event")
  EventEmitter = _obj_0.EventEmitter
end
GAMESTATE = require("lib.hump.gamestate")
TIMER = require("lib.hump.timer")
Camera = require("lib.hump.camera")
DEBUG = true
love.load = function()
  love.graphics.setBackgroundColor(0, 0, 255)
  return GAMESTATE.switch(worldState())
end
love.update = function(dt)
  GAMESTATE.update(dt)
  return TIMER.update(dt)
end
love.draw = function()
  love.graphics.print(love.timer.getFPS())
  love.graphics.print(love.timer.getAverageDelta(), 0, 30)
  return GAMESTATE.draw()
end
love.keypressed = function(key, code)
  return GAMESTATE.keypressed(key, code)
end
love.keyreleased = function(key)
  return GAMESTATE.keyreleased(key)
end
love.mousepressed = function(x, y, button)
  return GAMESTATE.mousepressed(x, y, button)
end
