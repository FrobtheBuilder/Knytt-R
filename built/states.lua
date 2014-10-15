local State
do
  local _base_0 = {
    init = function(self) end,
    enter = function(self, previous, ...) end,
    leave = function(self) end,
    update = function(self, dt)
      local _list_0 = self.children
      for _index_0 = 1, #_list_0 do
        local child = _list_0[_index_0]
        child:update(dt)
      end
    end,
    draw = function(self)
      self.camera:attach()
      local _list_0 = self.children
      for _index_0 = 1, #_list_0 do
        local child = _list_0[_index_0]
        child:draw()
      end
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
  local _class_0 = setmetatable({
    __init = function(self)
      self.children = { }
      self.camera = Camera()
    end,
    __base = _base_0,
    __name = "State"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  State = _class_0
end
local worldState
do
  local _parent_0 = State
  local _base_0 = {
    cdraw = function(self)
      return love.graphics.print("hello", 300, 300)
    end,
    update = function(self, dt)
      _parent_0.update(self)
      return self.camera:move(1, dt)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self)
      _parent_0.__init(self)
      return self.camera:zoomTo(1)
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
