local floor, ceil = math.floor, math.ceil
-- canvas used to send to paintshader
paletteCanvas = love.graphics.newCanvas(8,1)

-- sprite drawing function
function sprite(sprite, x, y, fx, fy, palette )
 local ox,oy = 0,0
 
 -- flips
 if fx and fx <= -1 then fx, ox = -1, sprite.width*16 end
 if fy and fy <= -1 then fy, oy = -1, sprite.height*16 end
 
 -- optional palette swap here.
 if palette then
  
  -- !!! be mindful if your using them to disable and reenable them here !!!
  --local sx,sy,sw,sh = love.graphics.getScissor()
  --love.graphics.setScissor()
  
   love.graphics.setShader()
   paletteCanvas:renderTo(function()
    love.graphics.clear()
    love.graphics.push()
    love.graphics.setColor(1,1,1,1)
    love.graphics.origin()
    love.graphics.draw(paletteSheet,palette)
    love.graphics.pop()
  end)
  --love.graphics.setScissor(sx,sy,sw,sh)
  paintShader:send("palette",paletteCanvas)
  
  -- draw with palette
  love.graphics.setShader(paintShader)
  love.graphics.draw(spriteMappings, sprite.quad, floor(x + ox), floor(y + oy), 0, fx, fy)
  
 else
  
  -- draw
  love.graphics.setShader(transparentShader)
  love.graphics.draw(spriteSheet, sprite.quad, floor(x + ox), floor(y + oy), 0, fx, fy)
  
 end
 
end



-- maskSprites (using a sprite's mapping to set mask)
function maskSprite(sprite, value, paletteMask, x, y, fx, fy )
 local ox, oy = 0, 0
 -- flips
 if fx and fx <= -1 then fx, ox = -1, sprite.width*16-1 end
 if fy and fy <= -1 then fy, oy = -1, sprite.height*16-1 end
 
 paletteMask = paletteMask or mainScreen.paletteMask
 
 for i=0,sprite.width*16-1 do
  for j=0,sprite.height*16-1 do
   
   local r = sprite.mapping:getPixel(i,j)
   if r*255~=4 then
    paletteMask:add(x + i/fx + ox, y + j/fy + oy, value or 1)
   end
   
  end
 end
 
 
 
end






