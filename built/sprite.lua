local Component
do
  local _obj_0 = require("components")
  Component = _obj_0.Component
end
local Clock, dimConvert
do
  local _obj_0 = require("misc")
  Clock, dimConvert = _obj_0.Clock, _obj_0.dimConvert
end
local RawSprite
do
  local _base_0 = {
    update = function(self, dt)
      return self.clock:update(dt)
    end,
    addSet = function(self, params)
      if type(params.frames[1]) == "table" and params.frames[1][2] == "all" then
        local row = params.frames[1][1]
        for i = 1, #self.quads do
          table.insert(params.frames, {
            row,
            i
          })
        end
        table.remove(params.frames, 1)
      elseif type(params.frames[1]) == "table" and params.frames[1][1] == "all" then
        local col = params.frames[1][2]
        for i = 1, #self.quads[col] do
          table.insert(params.frames, {
            i,
            col
          })
        end
        table.remove(params.frames, 1)
      end
      if not params.flags then
        params.flags = { }
      end
      if params.flags["strip"] then
        local cols = #self.quads
        local start, finish = unpack(params.frames)
        params.frames = { }
        for i = start, finish do
          table.insert(params.frames, {
            dimConvert(i, cols)
          })
        end
      end
      return table.insert(self.sets, params)
    end,
    addSets = function(self, list)
      for _index_0 = 1, #list do
        local set = list[_index_0]
        self:addSet(set)
      end
    end,
    setFlip = function(self, direction)
      if type(direction) == "boolean" then
        if self.currentSet then
          self.currentSet.flags.flipped = direction
        end
      else
        self.currentSet.flags.flipped = (direction == "left")
      end
    end,
    setSet = function(self, name)
      local _list_0 = self.sets
      for _index_0 = 1, #_list_0 do
        local set = _list_0[_index_0]
        if set.name == name then
          self.currentSet = set
        end
      end
      self.clock.evt:remove("tick")
      if #self.currentSet.frames > 1 then
        do
          local _with_0 = self.clock
          _with_0.rate = self.currentSet.rate
          _with_0:reset()
          _with_0:setFace(#self.currentSet.frames)
          _with_0.evt:on("tick", function(e)
            return self:setFrame(e.new)
          end)
          return _with_0
        end
      else
        return self:setFrame(1)
      end
    end,
    setFrame = function(self, index)
      self.frame = self.currentSet.frames[index]
    end,
    play = function(self)
      return self.clock:start()
    end,
    stop = function(self)
      return self.clock:stop()
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
      return quads, w, h
    end,
    draw = function(self, x, y)
      if self.quads then
        if self.currentSet.name and self.frame then
          if not self.currentSet.flags.flipped then
            return love.graphics.draw(self.image, self.quads[self.frame[1]][self.frame[2]], x, y)
          else
            return love.graphics.draw(self.image, self.quads[self.frame[1]][self.frame[2]], x, y, 0, -1, 1, self.cellWidth, 0)
          end
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
        self.quads, self.cellWidth, self.cellHeight = self:split(self.image, params)
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
    addSets = function(self, list)
      return self.raw:addSets(list)
    end,
    setSet = function(self, name)
      self.raw:setSet(name)
      return self.raw:setFlip(self.facing)
    end,
    setFrame = function(self, index)
      return self.raw:setFrame(index)
    end,
    setFlip = function(self, direction)
      self.facing = direction
      return self.raw:setFlip(direction)
    end,
    offSet = function(self, x, y)
      self.offset.x, self.offset.y = x, y
    end,
    draw = function(self)
      if self.parent and self.parent.x and self.parent.y then
        return self.raw:draw(self.parent.x - self.offset.x, self.parent.y - self.offset.y)
      end
    end,
    play = function(self, callback)
      self.raw:play()
      if callback then
        return self.raw.clock.evt:once("toll", function(e)
          return callback(e)
        end)
      end
    end,
    stop = function(self)
      return self.raw:stop()
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
      self.facing = "right"
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
