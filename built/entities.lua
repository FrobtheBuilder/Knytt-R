local Movement
do
  local _obj_0 = require("movement")
  Movement = _obj_0.Movement
end
local Physics
do
  local _obj_0 = require("components")
  Physics = _obj_0.Physics
end
local Sprite
do
  local _obj_0 = require("sprite")
  Sprite = _obj_0.Sprite
end
local Thing
do
  local _obj_0 = require("thing")
  Thing = _obj_0.Thing
end
local Box
do
  local _obj_0 = require("misc")
  Box = _obj_0.Box
end
local Entity
do
  local _parent_0 = Thing
  local _base_0 = {
    update = function(self, dt)
      return self.box:move(self.x, self.y)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, x, y, ...)
      self.x, self.y = x, y
      _parent_0.__init(self, ...)
      self.v = {
        x = 0,
        y = 0,
        max = {
          x = 0,
          y = 0
        }
      }
      self.a = {
        x = 0,
        y = 0
      }
      self.box = { }
    end,
    __base = _base_0,
    __name = "Entity",
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
  Entity = _class_0
end
return {
  Entity = Entity
}
