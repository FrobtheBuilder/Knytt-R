local Test, Movement
do
  local _obj_0 = require("components")
  Test, Movement = _obj_0.Test, _obj_0.Movement
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
local Entity
do
  local _parent_0 = Thing
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, x, y, ...)
      self.x, self.y = x, y
      return _parent_0.__init(self, ...)
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
local Juni
do
  local _parent_0 = Entity
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      _parent_0.__init(self, ...)
      self.sprite = self:addChild(Sprite("assets/img/sprites/juni.png", {
        rows = 10,
        cols = 10
      }))
      self.move = self:addChild(Movement())
      self.move:setVelocity(60, 60)
      self.sprite:addSet({
        name = "walk",
        rate = 15,
        frames = {
          {
            1,
            1
          },
          {
            2,
            1
          },
          {
            3,
            1
          },
          {
            4,
            1
          },
          {
            5,
            1
          },
          {
            6,
            1
          },
          {
            7,
            1
          },
          {
            8,
            1
          },
          {
            9,
            1
          },
          {
            10,
            1
          }
        }
      })
      return self.sprite:setSet("walk")
    end,
    __base = _base_0,
    __name = "Juni",
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
  Juni = _class_0
end
return {
  Entity = Entity,
  Juni = Juni
}
