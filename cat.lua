local SpriteObj = require('spriteObj')

local Cat = {
  type = 'cat',
  w = 9, h = 15,
  vy = 0,
  canJump = false
}
Cat.__index = Cat

function Cat:new(x, y)
  local opts = {
    x = x, y = y,
  }
  local base = SpriteObj:new(opts)
  return setmetatable(base, self)
end

function Cat:moveTo(x, y, onGround)
  self.x = x
  self.y = y
  self.canJump = onGround and true or false
  self.vy = onGround and 0 or self.vy
end

function Cat:jump()
  self.vy = -4.0
  return true
end

return Cat
