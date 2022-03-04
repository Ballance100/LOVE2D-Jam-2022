

local Camera = {
 x=0,
 width= 608,
}


function Camera:update(target)
  
  local windowSize = window.width*window.tileScale
  Camera.x = math.min( math.max( -target.x+windowSize/2, -(Camera.width-windowSize) ), 0)
  
end

return Camera