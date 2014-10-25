local Entity
do
  local _obj_0 = require("entities")
  Entity = _obj_0.Entity
end
local Sprite
do
  local _obj_0 = require("sprite")
  Sprite = _obj_0.Sprite
end
local Box
do
  local _obj_0 = require("misc")
  Box = _obj_0.Box
end
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
local Juni
do
  local _parent_0 = Entity
  local _base_0 = {
    added = function(self, to)
      _parent_0.added(self, to)
      self.movement = Movement(self)
      self.physics = Physics({
        gravity = 20,
        friction = 20,
        collideWith = nil
      }, self)
      self.v.max.x = self.topspeed
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
          rate = self.rate + 6,
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
      self.movement.moving = true
      if key == "right" then
        self.sprite:setSet("run")
        self.sprite:setFlip("right")
        self.sprite:play()
        self.movement:setAcceleration(self.runspeed, nil)
        self.movingRight = true
      elseif key == "left" then
        self.sprite:setSet("run")
        self.sprite:setFlip("left")
        self.sprite:play()
        self.movement:setAcceleration(-self.runspeed, nil)
        self.movingLeft = true
      end
      if self.movingLeft and self.movingRight then
        self.movingRight = false
        self.movingLeft = false
      end
    end,
    keyreleased = function(self, key)
      if self.movingLeft and self.movingRight then
        self.movingRight = false
        self.movingLeft = false
      end
      if key == "right" then
        self.movingRight = false
      end
      if key == "left" then
        self.movingLeft = false
      end
      if not self.movingLeft and not self.movingRight then
        self.movement.moving = false
        return self.sprite:setSet("stand")
      end
    end,
    update = function(self, dt)
      self.movement:update(dt)
      self.physics:update(dt)
      return self.sprite:update(dt)
    end,
    draw = function(self)
      self.sprite:draw()
      if DEBUG then
        love.graphics.point(self.x, self.y)
        return self.box:outline()
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
      self.runspeed = 50
      self.topspeed = 50
      self.movingRight = false
      self.movingLeft = false
      self.sprite = Sprite("assets/img/sprites/juni.png", {
        rows = 10,
        cols = 10
      }, self)
      self.sprite:offSet(10, 10)
      self.box = Box(0, 0, 5, 13)
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
  Juni = Juni
}
