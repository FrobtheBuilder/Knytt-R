local Component
do
  local _obj_0 = require("components")
  Component = _obj_0.Component
end
local Movement
do
  local _parent_0 = Component
  local _base_0 = {
    move = function(self, dx, dy)
      self.accum.x = self.accum.x + dx
      self.accum.y = self.accum.y + dy
      while self.accum.x >= 1 do
        self.parent.x = self.parent.x + 1
        self.accum.x = self.accum.x - 1
      end
      while self.accum.x <= -1 do
        self.parent.x = self.parent.x - 1
        self.accum.x = self.accum.x + 1
      end
      while self.accum.y >= 1 do
        self.parent.y = self.parent.y + 1
        self.accum.y = self.accum.y - 1
      end
      while self.accum.y <= -1 do
        self.parent.y = self.parent.y - 1
        self.accum.y = self.accum.y + 1
      end
    end,
    setVelocity = function(self, vx, vy)
      if vx then
        self.p.v.x = vx
      end
      if vy then
        self.p.v.y = vy
      end
      self.accum.x = 0
      self.accum.y = 0
    end,
    setAcceleration = function(self, ax, ay)
      if ax then
        self.p.a.x = ax
      end
      if ay then
        self.p.a.y = ay
      end
    end,
    accelerate = function(self, vx, vy)
      if vx then
        self.p.a.x = self.p.a.x + vx
      end
      if vy then
        self.p.a.x = self.p.a.x + vy
      end
    end,
    update = function(self, dt)
      if self.p.v.x < self.p.v.max.x and self.p.v.x > -self.p.v.max.x then
        self.p.v.x = self.p.v.x + (self.p.a.x * dt)
      elseif self.p.v.x > self.p.v.max.x then
        self.p.v.x = self.p.v.max.x
      elseif self.p.v.x < -self.p.v.max.x then
        self.p.v.x = -self.p.v.max.x
      end
      if not self.moving then
        self.p.a.x, self.p.a.y = 0, 0
      end
      self.p.v.y = self.p.v.y + (self.p.a.y * dt)
      if self.parent then
        return self:move(self.p.v.x, self.p.v.y)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      _parent_0.__init(self, ...)
      self.p = self.parent
      self.accum = {
        x = 0,
        y = 0
      }
      self.moving = false
    end,
    __base = _base_0,
    __name = "Movement",
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
  Movement = _class_0
end
return {
  Movement = Movement
}
