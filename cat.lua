local SpriteObj = require('spriteObj')

local Cat = {
  type = 'cat',
  vy = 0,
  canJump = false
}
Cat.__index = Cat

function Cat:new(x, y)
  print("X: ", x, "Y: ", y)
  local opts = {
    x = x, y = y,
    img = 'cat',
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
  self.vy = -4.5
  return true
end

return Cat
