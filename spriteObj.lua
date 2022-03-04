-- baseclass for game sprites
local SpriteObj = {
  x = 0, y = 0,
  w = 16, h = 16,
  vx = 0, vy = 0,
  img = 'default',
  name = 'test object',
}
SpriteObj.__index = SpriteObj

--[[
  sets and attaches all key-value pairs from the table [options]
  to the new object. options *can* be empty but should probably
  include at least img and type overrides
--]]
function SpriteObj:new(options)
  return setmetatable(options, self)
end

return SpriteObj
