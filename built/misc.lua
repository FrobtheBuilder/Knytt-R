local LeafThing
do
  local _obj_0 = require("thing")
  LeafThing = _obj_0.LeafThing
end
local Signals = require("lib.hump.signal")
local Clock
do
  local _base_0 = {
    start = function(self)
      self.enabled = true
    end,
    stop = function(self)
      self.enabled = false
    end,
    setFace = function(self, num)
      self.face = num
    end,
    update = function(self, dt)
      if self.enabled then
        local oldHand = self.hand
        self.time = self.time + (dt * self.rate)
        self.hand = math.floor(self.time)
        if oldHand ~= self.hand then
          if self.hand > self.face then
            self.signals:emit("toll", {
              at = oldHand
            })
            self:reset()
          end
          return self.signals:emit("tick", {
            old = oldHand,
            new = self.hand
          })
        end
      end
    end,
    reset = function(self)
      self.time = 1
      self.hand = 1
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, face, rate, time, ...)
      if face == nil then
        face = 12
      end
      if rate == nil then
        rate = 1
      end
      if time == nil then
        time = 1
      end
      self.face, self.rate, self.time = face, rate, time
      self.enabled = false
      self.visible = false
      self.signals = Signals.new()
      self.hand = self.time
      self.face = 12
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
local lMod
lMod = function(x, b)
  local times = math.floor(x / b)
  return x - (b * (times - 1) + (b - 1))
end
local dimConvert
dimConvert = function(num, width)
  local x = 0
  local y = 1
  for i = 1, num do
    x = x + 1
    if x > width then
      x = 1
      y = y + 1
    end
  end
  return x, y
end
return {
  Clock = Clock,
  dimConvert = dimConvert
}
