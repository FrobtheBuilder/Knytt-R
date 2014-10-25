local LeafThing
do
  local _obj_0 = require("thing")
  LeafThing = _obj_0.LeafThing
end
local sign, fixed_time_step
do
  local _obj_0 = require("misc")
  sign, fixed_time_step = _obj_0.sign, _obj_0.fixed_time_step
end
local Component
do
  local _base_0 = {
    update = function(self, dt) end,
    destroy = function(self)
      self = nil
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, parent)
      self.parent = parent
    end,
    __base = _base_0,
    __name = "Component"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Component = _class_0
end
local Physics
do
  local _parent_0 = Component
  local _base_0 = {
    update = function(self, dt)
      self.p.box:set_pos(self.p.x, self.p.y)
      self.p.v.x = self.p.v.x / (1 + (self.data.friction * dt))
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, data, ...)
      self.data = data
      _parent_0.__init(self, ...)
      self.p = self.parent
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
  Physics = Physics
}
