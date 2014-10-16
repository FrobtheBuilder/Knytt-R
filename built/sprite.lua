local Component
do
  local _obj_0 = require("components")
  Component = _obj_0.Component
end
local Sprite
do
  local _parent_0 = Component
  local _base_0 = {
    added = function(self, to)
      return _parent_0.added(self, to)
    end,
    update = function(self, dt)
      return self.raw:update()
    end,
    offset = function(self, x, y)
      self.offset.y, self.offset.y = x, y
    end,
    draw = function(self)
      if self.parent and self.parent.x and self.parent.y then
        return self.raw:draw(self.parent.x + self.offset.x, self.parent.y + self.offset.y)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      _parent_0.__init(self, ...)
      self.raw = RawSprite()
      self.offset = {
        x = 0,
        y = 0
      }
    end,
    __base = _base_0,
    __name = "Sprite",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Sprite = _class_0
end
local RawSprite
do
  local _base_0 = {
    update = function(self) end,
    draw = function(self, x, y)
      return love.graphics.draw(self.image, x, y)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, filepath)
      self.image = love.graphics.newImage(filepath)
    end,
    __base = _base_0,
    __name = "RawSprite"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  RawSprite = _class_0
  return _class_0
end
