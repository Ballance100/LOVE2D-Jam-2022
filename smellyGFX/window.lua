-- resizing window gfx
local floor, ceil = math.floor, math.ceil



--[[ check to see which scale to use?
function love.resize( w, h )
 local _,_, flags = love.window.getMode()
 
 local a=2
 local b,c=true,true
 for i=1,12*a do
  i=i/a-1
  local x=ceil(window.width*window.tileScale/i)
  local y=ceil(window.height*scaleSize*window.tileScale/i)
  for j=1,8 do
   if b and w>x-j and w<x+j then w=x love.window.setMode(w,h,flags) b=false end
   if c and h>y-j and h<y+j then h=y love.window.setMode(w,h,flags) c=false end
   if not b and not c then break end
  end
  if not b and not c then break end
 end
 
 local r=max(7-getResizeFactor(),1)
 drawCanvas = newScreen(r)
end
--]]

-- get the scale factor
function getResizeFactor()

 local wx, wy = love.graphics.getDimensions() 
 local dx, dy = love.window.getDesktopDimensions(1)
 
 local x, y = window.width*window.tileScale*scaleSize, window.height*window.tileScale*scaleSize
 
 local r=1
 local a=2
 for i=1,12*a do
  i=12-i/a+1
  if y/i<=wy and x/i<=wx then
   r=i
  end
 end
 
 return r

end


-- get pillow/letter boxing and scale size
function setWindowScale()
 
 -- get scaling factor
 local wx,wy=love.graphics.getDimensions() 
 local dx,dy=love.window.getDesktopDimensions(1)
 
 local r = getResizeFactor()
 
 local x=wx-(scaleSize*1/r)*200
 local y=wy-(scaleSize*1/r)*104
 
 x=x/(scaleSize*1/r)/2
 y=y/(scaleSize*1/r)/2
 
 return r,floor(x+0.5),floor(y+0.5)
end


