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
 
 
 
 
 
 
 sp={
  test={
    -- background
   newSprite(0,0,12.5,6.5),
   
   altPalette = newPalette(0,0)
  }
 
 }
 
 
end








