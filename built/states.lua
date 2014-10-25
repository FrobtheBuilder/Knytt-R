local Thing
do
  local _obj_0 = require("thing")
  Thing = _obj_0.Thing
end
local Juni
do
  local _obj_0 = require("juni")
  Juni = _obj_0.Juni
end
local Physics
do
  local _obj_0 = require("components")
  Physics = _obj_0.Physics
end
local sign, fixed_time_step
do
  local _obj_0 = require("misc")
  sign, fixed_time_step = _obj_0.sign, _obj_0.fixed_time_step
end
local State
do
  local _parent_0 = Thing
  local _base_0 = {
    init = function(self) end,
    enter = function(self, previous, ...) end,
    leave = function(self) end,
    draw = function(self)
      self.camera:attach()
      _parent_0.draw(self)
      self:cdraw()
      self.camera:detach()
      return self:sdraw()
    end,
    cdraw = function(self) end,
    sdraw = function(self) end,
    focus = function(self) end,
    keypressed = function(self, key, isrepeat) end,
    keyreleased = function(self, key) end,
    mousepressed = function(self, x, y, button) end,
    mousereleased = function(self, x, y, button) end,
    quit = function(self) end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self)
      _parent_0.__init(self)
      self.camera = Camera()
    end,
    __base = _base_0,
    __name = "State",
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
  State = _class_0
end
local worldState
do
  local _parent_0 = State
  local _base_0 = {
    sdraw = function(self)
      return love.graphics.print(1 / self.dt)
    end,
    update = fixed_time_step(60, function(self, dt)
      self.dt = dt
      return _parent_0.update(self, dt)
    end),
    keypressed = function(self, key, isrepeat)
      return self.juni:keypressed(key, isrepeat)
    end,
    keyreleased = function(self, key)
      return self.juni:keyreleased(key)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self)
      _parent_0.__init(self)
      self.dt = 0
      self.juni = self:addChild(Juni(10, 500))
    end,
    __base = _base_0,
    __name = "worldState",
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
  worldState = _class_0
end
return {
  State = State,
  worldState = worldState
}
