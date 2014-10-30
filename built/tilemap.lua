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
            table.insert(self.tiles[source.data.l][c], Tile(self.tilesets[source.data.set], 1, 2))
          end
        end
      end
    end,
    draw = function(self)
      self.viewport:refresh()
      local _list_0 = self.tiles
      for _index_0 = 1, #_list_0 do
        local layer = _list_0[_index_0]
        if layer[1] and layer[1][1] then
          for c = 1, #layer do
            for r = 1, #layer[c] do
              local realX, realY = self:real(c, r, layer[c][r])
              if realX > (self.viewport.x - (self.viewport.hWidth + layer[c][r].tileset.cell.width)) then
                if realX < (self.viewport.x + self.viewport.hWidth) then
                  if realY > (self.viewport.y - (self.viewport.hHeight + layer[c][r].tileset.cell.width)) then
                    if realY < (self.viewport.y + self.viewport.hHeight) then
                      layer[c][r]:draw(self:real(c, r, layer[c][r]))
                    end
                  end
                end
              end
            end
          end
        end
      end
    end,
    real = function(self, c, r, tile)
      return (c - 1) * tile.tileset.cell.width, (r - 1) * tile.tileset.cell.height
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, tilesets, x, y, viewportFunc)
      if tilesets == nil then
        tilesets = { }
      end
      self.tilesets, self.x, self.y = tilesets, x, y
      self.viewport = { }
      do
        local _with_0 = self.viewport
        _with_0.x, _with_0.y = viewportFunc()
        _with_0.width, _with_0.height = love.window.getDimensions()
        _with_0.hWidth, _with_0.hHeight = _with_0.width / 2, _with_0.height / 2
        _with_0.func = viewportFunc
        _with_0.refresh = function(self)
          self.x, self.y = self.func()
        end
      end
      self.tiles = { }
      self.bounds = Box(0, 0, 30, 30)
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
      return love.graphics.newQuad((self.col - 1) * self.cell.width, (self.row - 1) * self.cell.height, self.cell.width, self.cell.height, self.real.width, self.real.height)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, path, cols, rows, cell)
      self.cols, self.rows = cols, rows
      self.image = love.graphics.newImage(path)
      self.real = {
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
