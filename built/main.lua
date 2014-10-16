local State, worldState
do
  local _obj_0 = require("states")
  State, worldState = _obj_0.State, _obj_0.worldState
end
GAMESTATE = require("lib.hump.gamestate")
TIMER = require("lib.hump.timer")
Camera = require("lib.hump.camera")
love.load = function()
  love.graphics.setBackgroundColor(0, 0, 255)
  return GAMESTATE.switch(worldState())
end
love.update = function(dt)
  GAMESTATE.update(dt)
  return TIMER.update(dt)
end
love.draw = function()
  return GAMESTATE.draw()
end
love.keypressed = function(key, code)
  return GAMESTATE.keypressed(key, code)
end
love.mousepressed = function(x, y, button)
  return GAMESTATE.mousepressed(x, y, button)
end
