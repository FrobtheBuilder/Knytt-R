local LeafThing
do
  local _obj_0 = require("thing")
  LeafThing = _obj_0.LeafThing
end
local Signals = require("lib.hump.signal")
local Clock
do
  local _base_0 = {
    update = function(self, dt)
      local oldHand = self.hand
      self.time = self.time + (dt * self.rate)
      self.hand = math.floor(self.time)
      if oldHand ~= self.hand then
        return self.signals:emit("tick", {
          old = oldHand,
          new = self.hand
        })
      end
    end,
    reset = function(self)
      self.time = 1
      self.hand = 1
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, rate, time, ...)
      if rate == nil then
        rate = 1
      end
      if time == nil then
        time = 1
      end
      self.rate, self.time = rate, time
      self.enabled = true
      self.visible = false
      self.signals = Signals.new()
      self.hand = self.time
    end,
    __base = _base_0,
    __name = "Clock"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Clock = _class_0
end
return {
  Clock = Clock
}
