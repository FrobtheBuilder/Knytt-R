local EventEmitter
do
  local _base_0 = {
    on = function(self, event, fn)
      if not self.events[event] then
        self.events[event] = { }
        self.events[event].once = { }
      end
      return table.insert(self.events[event], fn)
    end,
    fire = function(self, event, ...)
      if self.events[event] then
        local _list_0 = self.events[event]
        for _index_0 = 1, #_list_0 do
          local fn = _list_0[_index_0]
          fn(...)
          local _list_1 = self.events[event].once
          for _index_1 = 1, #_list_1 do
            local oncefn = _list_1[_index_1]
            if oncefn == fn then
              self:remove(event, fn)
            end
          end
        end
      end
    end,
    remove = function(self, event, func)
      if self.events[event] then
        if func then
          for i, fn in ipairs(self.events[event]) do
            if fn == func then
              self.events[event][i] = nil
            end
          end
        else
          self.events[event] = nil
        end
      end
    end,
    once = function(self, event, fn)
      self:on(event, fn)
      return table.insert(self.events[event].once, fn)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self)
      self.events = { }
    end,
    __base = _base_0,
    __name = "EventEmitter"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  EventEmitter = _class_0
end
return {
  EventEmitter = EventEmitter
}
