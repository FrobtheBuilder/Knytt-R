local insert, remove
do
  local _obj_0 = table
  insert, remove = _obj_0.insert, _obj_0.remove
end
local get_local
do
  local _obj_0 = require("lovekit.support")
  get_local = _obj_0.get_local
end
local DrawList
do
  local _obj_0 = require("lovekit.lists")
  DrawList = _obj_0.DrawList
end
local Sequence
do
  local _obj_0 = require("lovekit.sequence")
  Sequence = _obj_0.Sequence
end
local mixin
do
  local empty_func = string.dump(function() end)
  mixin = function(mix)
    local cls = get_local("self", 2)
    local base = cls.__base
    for member_name, member_val in pairs(mix.__base) do
      local _continue_0 = false
      repeat
        if member_name:match("^__") then
          _continue_0 = true
          break
        end
        do
          local existing = base[member_name]
          if existing then
            if type(existing) == "function" and type(member_val) == "function" then
              base[member_name] = function(...)
                member_val(...)
                return existing(...)
              end
            else
              base[member_name] = member_val
            end
          else
            base[member_name] = member_val
          end
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    if mix.__init and string.dump(mix.__init) ~= empty_func then
      local old_ctor = cls.__init
      cls.__init = function(...)
        old_ctor(...)
        return mix.__init(...)
      end
    end
  end
end
local Sequenced
do
  local _base_0 = {
    add_seq = function(self, seq)
      if type(seq) == "function" then
        seq = Sequence(seq)
      end
      self.sequence_queue = self.sequence_queue or { }
      return insert(self.sequence_queue, seq)
    end,
    update = function(self, dt)
      local queue = self.sequence_queue
      if not (queue) then
        return 
      end
      if not self.current_seq and next(queue) then
        self.current_seq = remove(queue, 1)
      end
      if self.current_seq then
        if not (self.current_seq:update(dt)) then
          self.current_seq = nil
        end
      end
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "Sequenced"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Sequenced = _class_0
end
local HasParticles
do
  local _base_0 = {
    draw_inner = function(self)
      return self.particles:draw_sorted()
    end,
    update = function(self, dt)
      return self.particles:update(dt)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self)
      self.particles = DrawList()
    end,
    __base = _base_0,
    __name = "HasParticles"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  HasParticles = _class_0
end
local KeyRepeat
do
  local _base_0 = {
    push_key_repeat = function(self, ...)
      self._key_repeat = love.keyboard.hasKeyRepeat()
      return love.keyboard.setKeyRepeat(...)
    end,
    pop_key_repeat = function(self)
      love.keyboard.setKeyRepeat(self._key_repeat)
      self._key_repeat = nil
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "KeyRepeat"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  KeyRepeat = _class_0
end
return {
  mixin = mixin,
  Sequenced = Sequenced,
  HasParticles = HasParticles,
  KeyRepeat = KeyRepeat
}
