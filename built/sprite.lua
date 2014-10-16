local Component
do
  local _obj_0 = require("components")
  Component = _obj_0.Component
end
local Clock
do
  local _obj_0 = require("misc")
  Clock = _obj_0.Clock
end
local RawSprite
do
  local _base_0 = {
    update = function(self, dt)
      return self.clock:update(dt)
    end,
    addSet = function(self, params)
      return table.insert(self.sets, params)
    end,
    setSet = function(self, name)
      local _list_0 = self.sets
      for _index_0 = 1, #_list_0 do
        local set = _list_0[_index_0]
        if set.name == name then
          self.currentSet = set
        end
      end
      self.frame = self.currentSet.frames[1]
      if #self.currentSet.frames > 1 then
        do
          local _with_0 = self.clock
          _with_0.rate = self.currentSet.rate
          _with_0.signals:clear()
          _with_0:reset()
          _with_0.signals:register("tick", function(e)
            if e.new > #self.currentSet.frames then
              self.clock:reset()
              self.frame = self.currentSet.frames[self.clock.hand]
            else
              self.frame = self.currentSet.frames[e.new]
            end
          end)
          return _with_0
        end
      end
    end,
    split = function(self, sheet, params)
      local quads = { }
      if not (params.w) then
        params.w = sheet:getWidth() / params.cols
      end
      if not (params.h) then
        params.h = sheet:getHeight() / params.rows
      end
      local w, h, rows, cols = params.w, params.h, params.rows, params.cols
      for x = 1, cols do
        quads[x] = { }
        for y = 1, rows do
          quads[x][y] = love.graphics.newQuad((x * w) - w, (y * h) - h, w, h, self.image:getDimensions())
        end
      end
      return quads
    end,
    draw = function(self, x, y)
      if self.quads then
        if self.currentSet.name then
          return love.graphics.draw(self.image, self.quads[self.frame[1]][self.frame[2]], x, y)
        end
      else
        return love.graphics.draw(self.image, x, y)
      end
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, filepath, params)
      self.sets = { }
      self.currentSet = { }
      self.image = love.graphics.newImage(filepath)
      self.clock = Clock()
      self.frame = { }
      if (params.rows or params.cols) and (params.cols > 1 or params.rows > 1) then
        self.quads = self:split(self.image, params)
      end
    end,
    __base = _base_0,
    __name = "RawSprite"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  RawSprite = _class_0
end
local Sprite
do
  local _parent_0 = Component
  local _base_0 = {
    added = function(self, to)
      return _parent_0.added(self, to)
    end,
    update = function(self, dt)
      return self.raw:update(dt)
    end,
    addSet = function(self, params)
      return self.raw:addSet(params)
    end,
    setSet = function(self, name)
      return self.raw:setSet(name)
    end,
    offset = function(self, x, y)
      self.offset.y, self.offset.y = x, y
    end,
    draw = function(self)
      if self.parent and self.parent.x and self.parent.y then
        return self.raw:draw(self.parent.x + self.offset.x, self.parent.y + self.offset.y)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, filepath, params, ...)
      _parent_0.__init(self, ...)
      self.raw = RawSprite(filepath, params)
      self.offset = {
        x = 0,
        y = 0
      }
    end,
    __base = _base_0,
    __name = "Sprite",
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
  Sprite = _class_0
end
return {
  Sprite = Sprite
}
