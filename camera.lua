

local Camera = {
 x=0,
 width= 608,
}

function Camera:update(target)
  local windowSize = window.width*window.tileScale -- 200

  local dxr = -target.x + 132
  local dxl = -target.x + 56

  --if target.x + Camera.x < -132 then
  if Camera.x > dxr then
    Camera.x = math.max(dxr, windowSize - Camera.width)
  elseif Camera.x < dxl then
    Camera.x = math.min(0, dxl)
  end
end

return Camera
