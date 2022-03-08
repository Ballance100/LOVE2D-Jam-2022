-- have your tables with the sprites and palettes here.



-- make new sprites
function newSprite(x,y, w,h)
 spriteCount=spriteCount+1
 
 w=w or 1
 h=h or 1
 
 local t={
  quad = "?",
  mapping = love.image.newImageData(w*16, h*16),
  width = w,
  height = h
 }
 
 x=x*16 y=y*16
 assert( x + w*16 <= spriteSheet:getWidth() and y + h*16 <= spriteSheet:getHeight(),"out of bounds sprite! ( x = "..x + (w*16)..", y=".. y + (h*16)..")" )
 
 
 -- capture quad
 t.quad = love.graphics.newQuad(x, y, w*16, h*16, spriteSheet:getDimensions() )
 
 
 
 
 -- capture mapping
 local refrence, readMemory = spriteSheetIndexed, {0}
 for j=1,h*16 do
  for i=1,w*16 do
   local v, f, d = math.floor( refrence:getPixel( x + i - 1, y + j - 1 )*64 + .5 ), true, #readMemory+1
   
   for k=1,#readMemory do
    if v==readMemory[k] then
     f=false d=k
    end
   end
   
   --assert(d<9,"Sprite has too many colors! The palette mapping for sprite #"..spriteCount.." was over the max 8!\n(At: x="..x..", y="..y..")")
   
   if f then readMemory[#readMemory+1] = v end
   mappingImageData:setPixel( x + i-1, y + j-1, d/64,0,0,1)
   
  end
 end
 
 
 -- keep the mapping in the sprite
 t.mapping:paste(mappingImageData, 0, 0, x, y, w*16, h*16 )
 
 
 
 return t
end



-- new palette
function newPalette(x,y)
 return love.graphics.newQuad(x*8,y,8,1,paletteSheet:getDimensions() )
end






function newActorSpriteTable(x,y)
 local t={}
 
 for j=1,4 do
  t[j] = {}
  for i=1,12 do
   t[j][i] = newSprite(x+i-1,y+j-1, 1, 1)
  end
 end
 
 return t
end







-- load in sprites and palettes
spriteCount=0
function createSprites()
 mappingImageData = love.image.newImageData( spriteSheet:getDimensions() )
 
 
 
 
 
 local sixteenth = 1 / 16
 sp={
  test={
    -- background
   newSprite(0,0,38,6.5),
   -- player
   newSprite(0, 9, 1, 1),
   newSprite(1, 9, 1, 1),
   newSprite(2, 9, 1, 1),
   -- breakable objects
   newSprite(10, 9, 1, 1),
   newSprite(11, 9, 1, 1),
   newSprite(12, 9, 1, 1),
   newSprite(13, 9, 1, 1),
   newSprite(13, 8, 1, 2),
   -- score ui
   newSprite(0, 8, 5, 1), -- 10
   -- blue score numbers
   newSprite(0.0, 7 + sixteenth, 0.5, 1 - 2*sixteenth),
   newSprite(0.5, 7 + sixteenth, 0.5, 1 - 2*sixteenth),
   newSprite(1.0, 7 + sixteenth, 0.5, 1 - 2*sixteenth),
   newSprite(1.5, 7 + sixteenth, 0.5, 1 - 2*sixteenth),
   newSprite(2.0, 7 + sixteenth, 0.5, 1 - 2*sixteenth),
   newSprite(2.5, 7 + sixteenth, 0.5, 1 - 2*sixteenth),
   newSprite(3.0, 7 + sixteenth, 0.5, 1 - 2*sixteenth),
   newSprite(3.5, 7 + sixteenth, 0.5, 1 - 2*sixteenth),
   newSprite(4.0, 7 + sixteenth, 0.5, 1 - 2*sixteenth),
   newSprite(4.5, 7 + sixteenth, 0.5, 1 - 2*sixteenth), -- 20
   -- red score numbers
   newSprite(5.0 + sixteenth, 7 + sixteenth, 0.5, 1 - sixteenth),
   newSprite(5.5 + sixteenth, 7 + sixteenth, 0.5, 1 - sixteenth),
   newSprite(6.0 + sixteenth, 7 + sixteenth, 0.5, 1 - sixteenth),
   newSprite(6.5 + sixteenth, 7 + sixteenth, 0.5, 1 - sixteenth),
   newSprite(7.0 + sixteenth, 7 + sixteenth, 0.5, 1 - sixteenth),
   newSprite(7.5 + sixteenth, 7 + sixteenth, 0.5, 1 - sixteenth),
   newSprite(8.0 + sixteenth, 7 + sixteenth, 0.5, 1 - sixteenth),
   newSprite(8.5 + sixteenth, 7 + sixteenth, 0.5, 1 - sixteenth),
   newSprite(9.0 + sixteenth, 7 + sixteenth, 0.5, 1 - sixteenth),
   newSprite(9.5, 7 + sixteenth, 0.5, 1 - sixteenth), -- 30
   
   altPalette = newPalette(0,0)
  }
 
 }
 
 
end








