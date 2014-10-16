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
      if to.getChild then
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
local Test
do
  local _parent_0 = Component
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...) end,
    __base = _base_0,
    __name = "Test",
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
  Test = _class_0
end
return {
  Component = Component,
  Test = Test
}
