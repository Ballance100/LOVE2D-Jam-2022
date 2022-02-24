

-- take a file and turn it into a indexed image to use.
-- (this adds a corutine to the list of files to convert and then dumps the name given and the indexed ver into _G
-- cause it's just easy that way IDK. feel free to change that.)
indexConvertFiles={}
function convertToIndex(img, var)
 local f={}
 f.imgData = love.image.newImageData(img)
 f.flag = false
 f.coroutine = coroutine.create(function()
  local dt=love.timer.getDelta()
  local framesTaken = 0
  for i=1,f.imgData:getWidth() do
   dt = dt + love.timer.step()
   
   if dt > framesTaken+1 then
    framesTaken=framesTaken+1
    coroutine.yield(false)
   end
  
  for j=1,f.imgData:getHeight() do
    local r,g,b,a = f.imgData:getPixel(i-1,j-1)
    -- compare against key
    for k=0,63 do
     local kr,kg,kb,ka = paletteKey:getPixel(k,0)
     if r==kr and g==kg and b==kb and a==ka then
      local v=k/64
      f.imgData:setPixel(i-1,j-1, v,0,0,1)
      break
     end
    end
   end
  end
  -- print("(debug) "..var.." took "..framesTaken.." frames to render!")
  
  _G[var]=love.graphics.newImage( f.imgData )
  _G[var.."Indexed"]=f.imgData
  
  coroutine.yield(true)
 end)
 
 indexConvertFiles[#indexConvertFiles+1] = f
end



-- go through and render each of the 'indexConvertFiles'
function renderSprites()
 
 -- indexing
 local doneFlag = true
 local _
 for i,v in ipairs(indexConvertFiles) do
  if not v.flag then
   _, v.flag = coroutine.resume(v.coroutine)
   doneFlag = false
  end
 end
 
 if doneFlag then
  paletteMaskShader:send("screenPalette",screenPalette)
  
  createSprites()
  spriteMappings = love.graphics.newImage( mappingImageData )
  renderSprites = nil
  print("(debug) sprites done rendering.")
 end
 
end


-- define palette to use
paletteKey = love.image.newImageData("smellyGFX/sprites/key.png",64,1)

-- convert the files needed
-- palette lookup
convertToIndex("smellyGFX/sprites/key.png","masterPal")
-- spritesheet
convertToIndex("smellyGFX/sprites/sheet.png","spriteSheet")
-- extra palettes to use if needed
convertToIndex("smellyGFX/sprites/paletteSheet.png","paletteSheet")
-- sheet for the palettemask to sample
convertToIndex("smellyGFX/sprites/screenPalette.png","screenPalette")

