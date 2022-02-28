local SpriteObj = require('spriteObj')

local Cat = {
  type = 'cat'
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

return Cat
 