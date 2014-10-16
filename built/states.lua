local Thing
do
  local _obj_0 = require("thing")
  Thing = _obj_0.Thing
end
local Entity
do
  local _obj_0 = require("entities")
  Entity = _obj_0.Entity
end
local State
do
  local _parent_0 = Thing
  local _base_0 = {
    init = function(self) end,
    enter = function(self, previous, ...) end,
    leave = function(self) end,
    update = function(self, dt)
      return _parent_0.update(self, dt)
    end,
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
    keypressed = function(self, key, code) end,
    keyreleased = function(self, key, code) end,
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
    cdraw = function(self) end,
    update = function(self, dt)
      return _parent_0.update(self)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self)
      _parent_0.__init(self)
      self.camera:zoomTo(1)
      return self:addChild(Entity())
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
