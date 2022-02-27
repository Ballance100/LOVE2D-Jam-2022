---- shape gfx
local tau = math.pi * 2
local sin, cos = math.sin, math.cos
local floor, ceil = math.floor, math.ceil



-- clear screen with color
function clear(color)
 
 love.graphics.clear( getColor(color or 1) )
 
end



-- draw rectangle
function rectangle(x1,y1,w,h, color, drawMode)
 love.graphics.setShader()
 setIndexColor(color or 1)
 
 love.graphics.rectangle(drawMode or "fill", x1,y1,w,h)
 
end



-- draw circle made out of points
function circleOutLine(x,y,r, amount, color, sway)
 love.graphics.setShader()
 setIndexColor(color or 1)
 
 for i=1,amount or 0 do
  local ox = 0.5 + floor( r*cos(tau * (i+(sway or 0))/amount) )
  local oy = 0.5 + floor( r*sin(tau * (i+(sway or 0))/amount) )
  love.graphics.points(x + ox, y + oy )
 end
 
 
 
end



-- draw filled in circle
function circleFill(x,y,r, color)
 love.graphics.setShader()
 setIndexColor(color or 1)
 
 for i=-r,r do
  for j=-r,r do
   
   if i^2+j^2<r^2 then
    
    love.graphics.points(i+x +r,j+y +r)
    
   end
   
  end
 end
 
 
end



-- draw filled in oval
function ovalFill(x1,y1, x2,y2, color)
 love.graphics.setShader()
 setIndexColor(color or 1)
 
 x1=x1 or 0
 y1=y1 or 0
 x2=x2 or 0
 y2=y2 or 0
 
 local r1, r2 = x2-x1, y2-y1
 for i=-r1,r1 do
  for j=-r2,r2 do
   if i^2/r1^2 + j^2/r2^2 < 1 then
    love.graphics.points(x1+i+r1+.5, y1+j+r2+.5)
   end
  end
 end
 
 
end



-- draw filled in star
function starFill(x1,y1, x2,y2, color)
 love.graphics.setShader()
 setIndexColor(color or 1)
 
 x1=floor(x1) or 0
 y1=floor(y1) or 0
 x2=floor(x2) or 0
 y2=floor(y2) or 0
 
 local r1, r2 = x2-x1, y2-y1
 for i=-r1,r1 do
  for j=-r2,r2 do
   if (i^2/r1^2)^0.333333 + (j^2/r2^2)^0.333333 < 1 then
    love.graphics.points(x1+i+r1+.5, y1+j+r2+.5)
   end
  end
 end
 
 
end



-- draw line
function line(x1,y1,x2,y2, color, timer, swayX,swayY, swayXLen, swayYLen, spaceout,chunkate, cutOff)
 love.graphics.setShader()
 swayX = swayX or 0
 swayY = swayY or 0
 swayXLen = swayXLen or 1
 swayYLen = swayYLen or 1
 timer=timer or globalTimer*2
 
 
 spaceout=spaceout or 1
 chunkate=chunkate or 1
 
 local dx   = x2-x1+1
 local dy   = y2-y1
 
 local linesize = abs(dx) + abs(dy)
 
 local h = 0
 local g = 0
 
 setIndexColor(color or 1)
 
 local a=linesize/spaceout
 for i=1,a do
  
  if not cutOff or i>cutOff then
   local x=floor(x1)+floor(h)*spaceout + floor( floor( (sin( (timer + (i /swayXLen)))*swayX)/chunkate )*chunkate )
   local y=floor(y1)+floor(g)*spaceout + floor( floor( (sin( (timer + (i /swayYLen)))*swayY)/chunkate )*chunkate )
   
   --if y>=0 and x>=0 then
    love.graphics.points(x+.5,y+.5)
   --end
  end
   h = h + dx/linesize
   g = g + dy/linesize
 end
 
 
end









