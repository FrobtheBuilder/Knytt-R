local LeafThing
do
  local _obj_0 = require("thing")
  LeafThing = _obj_0.LeafThing
end
local Component
do
  local _parent_0 = LeafThing
  local _base_0 = {
    added = function(self, to)
      if #(to:getChildren(self.__class.__name)) > 1 then
        if not (self.allowMultiple) then
          return nil, "Cannot have more than one"
        end
      end
      return _parent_0.added(self, to)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, allowMultiple, ...)
      if allowMultiple == nil then
        allowMultiple = false
      end
      self.allowMultiple = allowMultiple
      return _parent_0.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Component",
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
  Component = _class_0
end
local Movement
do
  local _parent_0 = Component
  local _base_0 = {
    move = function(self, dx, dy)
      self.accum.x = self.accum.x + dx
      self.accum.y = self.accum.y + dy
      if self.accum.x >= 1 then
        self.parent.x = self.parent.x + 1
        self.accum.x = self.accum.x - 1
      end
      if self.accum.x <= -1 then
        self.parent.x = self.parent.x - 1
        self.accum.x = self.accum.x + 1
      end
      if self.accum.y >= 1 then
        self.parent.y = self.parent.y + 1
        self.accum.y = self.accum.y - 1
      end
      if self.accum.y <= -1 then
        self.parent.y = self.parent.y - 1
        self.accum.y = self.accum.y + 1
      end
    end,
    setVelocity = function(self, vx, vy)
      if vx then
        self.v.x = vx
      end
      if vy then
        self.v.y = vy
      end
      self.accum.x = 0
      self.accum.y = 0
    end,
    setAcceleration = function(self, ax, ay)
      if ax then
        self.a.x = ax
      end
      if ay then
        self.a.y = ay
      end
    end,
    accelerate = function(self, vx, vy)
      if vx then
        self.a.x = self.a.x + vx
      end
      if vy then
        self.a.x = self.a.x + vy
      end
    end,
    update = function(self, dt)
      if self.physics then
        if self.v.x > 0 then
          self.v.x = self.v.x - (self.physics.friction * dt)
        else
          self.v.x = self.v.x + (self.physics.friction * dt)
        end
      end
      if self.v.x < self.vmax.x and self.v.x > -self.vmax.x then
        self.v.x = self.v.x + (self.a.x * dt)
      elseif self.v.x > self.vmax.x then
        self.v.x = self.vmax.x
      else
        self.v.x = -self.vmax.x
      end
      self.v.y = self.v.y + (self.a.y * dt)
      if self.parent then
        self:move(self.v.x * dt, self.v.y * dt)
      end
      if not self.moving then
        self.a.x, self.a.y = 0, 0
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, physics, ...)
      self.physics = physics
      _parent_0.__init(self, false, ...)
      self.v = {
        x = 0,
        y = 0
      }
      self.vmax = {
        x = 0,
        y = 0
      }
      self.a = {
        x = 0,
        y = 0
      }
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
local Physics
do
  local _parent_0 = Component
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, options, ...)
      self.friction = options.friction
      self.gravity = options.gravity
      return _parent_0.__init(self, false, ...)
    end,
    __base = _base_0,
    __name = "Physics",
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
  Physics = _class_0
end
return {
  Component = Component,
  Movement = Movement,
  Physics = Physics
}
