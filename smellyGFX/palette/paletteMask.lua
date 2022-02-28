

-- create a palettemask object thingy
function createPaletteMask()
 return {
  imageData=love.image.newImageData(200,104),
  paletteImage=love.graphics.newImage( love.image.newImageData(200,104) ),
  update=updatePaletteMask,
  set=setPaletteMask,
  add=addPaletteMask,
  get=getPaletteMask,
  use=sendToShader,
  push=pushPaletteMask
 }
end



-- clear a mask, draw a function and push that imagedata to the palettemask's image
function updatePaletteMask(self, ifClear, func, ...)
 -- reset the imagedata
 local p = self.imageData
 if ifClear then
  for i=0,p:getWidth()-1 do
   for j=0,p:getHeight()-1 do
    p:setPixel( i, j, 0, 0, 0 )
   end
  end
 end
 
 
 if func then func(self,...) end
 
 
 -- push it to the image
 self:push()
 
end

-- send a paletteScreen to the shader to be used
function sendToShader(self)
 if globalTimer>1 then
  paletteMaskShader:send("paletteMask",self.paletteImage)
  love.graphics.setShader(paletteMaskShader)
 end
end



-- set pixel in the paletteMask
function setPaletteMask(self, x,y,v)
 if x<0 or x>=192 or y<0 or y>=112 then return end
 
 self.imageData:setPixel( x, y, ((v or 1)%64)/128, 0, 0 )
end


-- get pixel in the paletteMask
function getPaletteMask(self, x,y)
 if x<0 or x>=192 or y<0 or y>=112 then return end
 
 local a = self.imageData:getPixel(x, y)
 return a*127.5
end


-- add to a pixel in the paletteMask
function addPaletteMask(self, x,y,v)
 if x<0 or x>=192 or y<0 or y>=112 then return end
 
 self.imageData:setPixel( x, y, self.imageData:getPixel( x, y )+((v or 1)%64)/128, 0, 0 )
end



-- send imagedata to image
function pushPaletteMask(self)
 self.paletteImage:replacePixels(self.imageData)
end



