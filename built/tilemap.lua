local Box
do
  local _obj_0 = require("misc")
  Box = _obj_0.Box
end
local Tile
do
  local _base_0 = {
    draw = function(self, x, y)
      return love.graphics.draw(self.tileset.image, self.quad, x, y)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, tileset, col, row)
      self.tileset = tileset
      self.quad = self.tileset:getTileQuad(col, row)
    end,
    __base = _base_0,
    __name = "Tile"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Tile = _class_0
end
local Tilemap
do
  local _base_0 = {
    load = function(self, source)
      if source.type == "empty" then
        if not self.tiles[source.data.l] then
          self.tiles[source.data.l] = { }
        end
        for c = 1, source.data.c do
          table.insert(self.tiles[source.data.l], { })
          for r = 1, source.data.r do
            table.insert(self.tiles[source.data.l][c], Tile(self.tilesets[source.data.set], 1, 3))
          end
        end
      end
    end,
    draw = function(self)
      if self.tiles[1] and self.tiles[1][1] and self.tiles[1][1][1] then
        for c = 1, #self.tiles[1] do
          for r = 1, #self.tiles[1][c] do
            self.tiles[1][c][r]:draw(c * 24, r * 24)
          end
        end
      end
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, tilesets)
      if tilesets == nil then
        tilesets = { }
      end
      self.tilesets = tilesets
      self.tiles = { }
    end,
    __base = _base_0,
    __name = "Tilemap"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Tilemap = _class_0
end
local Tileset
do
  local _base_0 = {
    getTileQuad = function(self, col, row)
      self.col, self.row = col, row
      return love.graphics.newQuad(self.col * self.cell.width, self.row * self.cell.height, self.cell.width, self.cell.height, self.raw.width, self.raw.height)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, path, cols, rows, cell)
      self.cols, self.rows = cols, rows
      self.image = love.graphics.newImage(path)
      self.raw = {
        width = self.image:getWidth(),
        height = self.image:getHeight()
      }
      if type(cell) == "table" then
        self.cell = {
          width = cell[1],
          height = cell[2]
        }
      else
        self.cell = {
          width = cell,
          height = cell
        }
      end
      return print(self.cell.width, self.cell.height)
    end,
    __base = _base_0,
    __name = "Tileset"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Tileset = _class_0
end
return {
  Tilemap = Tilemap,
  Tileset = Tileset
}
