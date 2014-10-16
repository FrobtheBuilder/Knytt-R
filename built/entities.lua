local Test
do
  local _obj_0 = require("components")
  Test = _obj_0.Test
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
      _parent_0.__init(self, ...)
      self:addChild(Test())
      return print(self:getChildren("Test")[1].__class.__name)
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
