local Signals = require("lib.hump.signal")
local Thing
do
  local _base_0 = {
    added = function(self, to)
      return self:setParent(to)
    end,
    setParent = function(self, to)
      self.parent = to
    end,
    remove = function(self)
      if self.parent then
        self:setParent(nil)
        self.parent:removeChild(self)
        return self:removed()
      end
    end,
    removed = function(self) end,
    draw = function(self)
      return self:drawChildren()
    end,
    drawChildren = function(self)
      local _list_0 = self.children
      for _index_0 = 1, #_list_0 do
        local child = _list_0[_index_0]
        if child.draw and child.visible then
          child:draw()
        end
      end
    end,
    update = function(self, dt)
      return self:updateChildren(dt)
    end,
    updateChildren = function(self, dt)
      local _list_0 = self.children
      for _index_0 = 1, #_list_0 do
        local child = _list_0[_index_0]
        if child.update and child.enabled then
          child:update(dt)
        end
      end
    end,
    destroy = function(self)
      self:remove()
      self:destroyed()
      self = nil
    end,
    destroyed = function(self) end,
    enable = function(self)
      self.enabled = true
    end,
    disable = function(self)
      self.enabled = false
    end,
    show = function(self)
      self.visible = true
    end,
    hide = function(self)
      self.visible = false
    end,
    addChild = function(self, child)
      table.insert(self.children, child)
      if child.added then
        child:added(self)
      end
      return child
    end,
    removeChild = function(self, child)
      for i, c in ipairs(self.children) do
        if c == child then
          table.remove(self.children, i)
          if c.parent then
            c:setParent(nil)
            c:removed()
          end
        end
      end
    end,
    getChildren = function(self, classs)
      local _accum_0 = { }
      local _len_0 = 1
      local _list_0 = self.children
      for _index_0 = 1, #_list_0 do
        local child = _list_0[_index_0]
        if child.__class.__name == classs then
          _accum_0[_len_0] = child
          _len_0 = _len_0 + 1
        end
      end
      return _accum_0
    end,
    getChild = function(self, classs)
      local _list_0 = self.children
      for _index_0 = 1, #_list_0 do
        local child = _list_0[_index_0]
        if child.__class.__name == classs then
          return child
        end
      end
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, enabled, visible)
      if enabled == nil then
        enabled = true
      end
      if visible == nil then
        visible = true
      end
      self.enabled, self.visible = enabled, visible
      self.children = { }
      self.parent = nil
      self.signals = Signals.new()
    end,
    __base = _base_0,
    __name = "Thing"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Thing = _class_0
end
local LeafThing
do
  local _parent_0 = Thing
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      _parent_0.__init(self, ...)
      self.children = nil
      self.getChildren = nil
      self.addChild = nil
      self.getChild = nil
      self.removeChild = nil
    end,
    __base = _base_0,
    __name = "LeafThing",
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
  LeafThing = _class_0
end
return {
  Thing = Thing,
  LeafThing = LeafThing
}
