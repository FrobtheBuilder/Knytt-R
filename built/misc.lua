local LeafThing
do
  local _obj_0 = require("thing")
  LeafThing = _obj_0.LeafThing
end
local EventEmitter
do
  local _obj_0 = require("event")
  EventEmitter = _obj_0.EventEmitter
end
local rectangle, line
do
  local _obj_0 = love.graphics
  rectangle, line = _obj_0.rectangle, _obj_0.line
end
local atan2, cos, sin, random, abs
do
  local _obj_0 = math
  atan2, cos, sin, random, abs = _obj_0.atan2, _obj_0.cos, _obj_0.sin, _obj_0.random, _obj_0.abs
end
local type, pairs, ipairs
do
  local _obj_0 = _G
  type, pairs, ipairs = _obj_0.type, _obj_0.pairs, _obj_0.ipairs
end
local Box
do
  local _base_0 = {
    unpack = function(self)
      return self.x, self.y, self.w, self.h
    end,
    unpack2 = function(self)
      return self.x, self.y, self.x + self.w, self.y + self.h
    end,
    dup = function(self)
      return Box(self:unpack())
    end,
    pad = function(self, amount)
      local amount2 = amount * 2
      return Box(self.x + amount, self.y + amount, self.w - amount2, self.h - amount2)
    end,
    pos = function(self)
      return self.x, self.y
    end,
    set_pos = function(self, x, y)
      self.x, self.y = x, y
    end,
    move = function(self, x, y)
      self.x = self.x + x
      self.y = self.y + y
      return self
    end,
    move_center = function(self, x, y)
      self.x = x - self.w / 2
      self.y = y - self.h / 2
      return self
    end,
    center = function(self)
      return self.x + self.w / 2, self.y + self.h / 2
    end,
    touches_pt = function(self, x, y)
      local x1, y1, x2, y2 = self:unpack2()
      return x > x1 and x < x2 and y > y1 and y < y2
    end,
    touches_box = function(self, o)
      local x1, y1, x2, y2 = self:unpack2()
      local ox1, oy1, ox2, oy2 = o:unpack2()
      if x2 <= ox1 then
        return false
      end
      if x1 >= ox2 then
        return false
      end
      if y2 <= oy1 then
        return false
      end
      if y1 >= oy2 then
        return false
      end
      return true
    end,
    contains_box = function(self, o)
      local x1, y1, x2, y2 = self:unpack2()
      local ox1, oy1, ox2, oy2 = o:unpack2()
      if ox1 <= x1 then
        return false
      end
      if ox2 >= x2 then
        return false
      end
      if oy1 <= y1 then
        return false
      end
      if oy2 >= y2 then
        return false
      end
      return true
    end,
    left_of = function(self, box)
      return self.x < box.x
    end,
    above_of = function(self, box)
      return self.y <= box.y + box.h
    end,
    draw = function(self)
      return rectangle("fill", self:unpack())
    end,
    outline = function(self)
      return rectangle("line", self:unpack())
    end,
    random_point = function(self)
      return self.x + random() * self.w, self.y + random() * self.h
    end,
    fix = function(self)
      local x, y, w, h = self:unpack()
      if w < 0 then
        x = x + w
        w = -w
      end
      if h < 0 then
        y = y + h
        h = -h
      end
      return Box(x, y, w, h)
    end,
    scale = function(self, sx, sy, center)
      if sx == nil then
        sx = 1
      end
      if sy == nil then
        sy = sx
      end
      if center == nil then
        center = false
      end
      local scaled = Box(self.x, self.y, self.w * sx, self.h * sy)
      if center then
        scaled:move_center(self:center())
      end
      return scaled
    end,
    shrink = function(self, dx, dy)
      if dx == nil then
        dx = 1
      end
      if dy == nil then
        dy = dx
      end
      local hx = dx / 2
      local hy = dy / 2
      local w = self.w - dx
      local h = self.h - dy
      if w < 0 or h < 0 then
        error("box too small")
      end
      return Box(self.x + hx, self.y + hy, w, h)
    end,
    add_box = function(self, other)
      if self.w == 0 or self.h == 0 then
        self.x, self.y, self.w, self.h = other:unpack()
      else
        local x1, y1, x2, y2 = self:unpack2()
        local ox1, oy1, ox2, oy2 = other:unpack2()
        x1 = math.min(x1, ox1)
        y1 = math.min(y1, oy1)
        x2 = math.max(x2, ox2)
        y2 = math.max(x2, oy2)
        self.x = x1
        self.y = y1
        self.w = x2 - x1
        self.h = y2 - y1
      end
      return nil
    end,
    __tostring = function(self)
      return ("box<(%d, %d), (%d, %d)>"):format(self:unpack())
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, x, y, w, h)
      self.x, self.y, self.w, self.h = x, y, w, h
    end,
    __base = _base_0,
    __name = "Box"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.from_pt = function(x1, y1, x2, y2)
    return Box(x1, y1, x2 - x1, y2 - y1)
  end
  Box = _class_0
end
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
            self.evt:fire("toll", {
              at = oldHand
            })
            self:reset()
          end
          return self.evt:fire("tick", {
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
      self.evt = EventEmitter()
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
local sign
sign = function(num)
  if num < 0 then
    return -1
  else
    return 1
  end
end
local fixed_time_step
fixed_time_step = function(rate, fn)
  local target_dt = 1 / rate
  local accum = 0
  return function(self, real_dt)
    accum = accum + real_dt
    while accum > target_dt do
      fn(self, target_dt)
      accum = accum - target_dt
    end
  end
end
return {
  Clock = Clock,
  Box = Box,
  dimConvert = dimConvert,
  sign = sign,
  fixed_time_step = fixed_time_step
}
