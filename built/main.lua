require("lovekit.all")
local image
do
  local _obj_0 = lovekit.image
  image = _obj_0.image
end
love.load = function() end
love.update = function(dt) end
love.draw = function()
  return love.graphics.print("hello", 100, 100)
end
