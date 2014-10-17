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
  local _base_0 = {
    added = function(self, to)
      _parent_0.added(self, to)
      self.movement = self:addChild(Movement(self.parent.physics))
      self.sprite:addSets({
        {
          name = "walk",
          rate = self.rate,
          frames = {
            {
              "all",
              1
            }
          }
        },
        {
          name = "run",
          rate = self.rate,
          flags = {
            strip = true
          },
          frames = {
            11,
            22
          }
        },
        {
          name = "climb",
          rate = self.rate * 2,
          flags = {
            strip = true
          },
          frames = {
            23,
            30
          }
        },
        {
          name = "startfall",
          rate = self.rate,
          flags = {
            strip = true
          },
          frames = {
            31,
            35
          }
        },
        {
          name = "fall",
          rate = self.rate,
          flags = {
            strip = true
          },
          frames = {
            36,
            42
          }
        },
        {
          name = "stand",
          rate = self.rate,
          frames = {
            {
              8,
              5
            }
          }
        }
      })
      self.sprite:setSet("startfall")
      self.sprite:setFrame(3)
      return self.sprite:play(function()
        print(self)
        self.sprite:setSet("fall")
        self.sprite:stop()
        return print(self.sprite.raw.frame == self.sprite.raw.currentSet.frames[2])
      end)
    end,
    keypressed = function(self, key, isrepeat)
      if key == "right" then
        self.sprite:setSet("run")
        self.sprite:play()
        self.movement:setAcceleration(self.runspeed, nil)
      end
      if key == "left" then
        self.sprite:setSet("run")
        self.sprite:play()
        return self.movement:setAcceleration(-self.runspeed, nil)
      end
    end,
    keyreleased = function(self, key)
      if key == "right" or key == "left" then
        self.movement:setAcceleration(0, nil)
        return self.sprite:setSet("stand")
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      _parent_0.__init(self, ...)
      self.rate = 15
      self.walkspeed = 100
      self.runspeed = 100
      self.sprite = self:addChild(Sprite("assets/img/sprites/juni.png", {
        rows = 10,
        cols = 10
      }))
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
