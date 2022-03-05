local Cup = {
  bbox_x = 5, bbox_y = 10,
  bbox_w = 5, bbox_h = 6,
  name = "ba Cup prototype",
  img = 5,
}
Cup.__index = Cup

function Cup:new(opts)
  return setmetatable(opts, self)
end


local Bowl = {}
local Cereal = {}
local Potplant = {}
local Flowers = {}

local BreakableSprite = { }
BreakableSprite.__index = BreakableSprite

-- type can be 'cup', 'bowl', 'cereal', potplant, 'flowers'
local types = {
  ['cup'] = Cup, 
  ['bowl'] = Bowl, 
  ['cereal'] = Cereal, 
  ['potplant'] = Potplant, 
  ['flowers'] = Flowers,
}

function BreakableSprite:new(x, y, type)
  local errmsg = 
    "breakableSprite:new type arg: " .. 
     tostring(type) .. "not recognised"
  local base = types[type]
  assert(base,  errmsg)
  return base:new({x=x, y=y, type=type})
end



return BreakableSprite
