

-- fill out a box
function paletteMaskSetBox(self, x1,y1,x2,y2,v)
 for i=x1,x2 do
  for j=y1,y2 do
   self:set(i,j,v or 1)
  end
 end
end


-- fill out a box with a mask
function paletteMaskSelectiveBox(self, x1,y1,x2,y2,v, mask)
 for i=x1,x2 do
  for j=y1,y2 do
   if self:get(i,j) == (mask or 0) then
    self:set(i,j,v or 1)
   end
  end
 end
end



-- draw a line
function paletteMaskSetLine(self, x1,y1,x2,y2, value, timer, swayX,swayY, swayXLen, swayYLen, spaceout,chunkate, cutOff)
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
 
 local a=linesize/spaceout
 for i=1,a do
  
  if not cutOff or i>cutOff then
   local x=floor(x1)+floor(h)*spaceout + floor( floor( (sin( (timer + (i /swayXLen)))*swayX)/chunkate )*chunkate )
   local y=floor(y1)+floor(g)*spaceout + floor( floor( (sin( (timer + (i /swayYLen)))*swayY)/chunkate )*chunkate )
   
    self:set(x+.5,y+.5,value or 1)
    
  end
   h = h + dx/linesize
   g = g + dy/linesize
 end
 
 
end








-- fade effect that's kinda janky
function paletteMaskFade(self, t, v)
 v = v or 0
 for j=0,121 do
  for i=0,191 do
   if i%2==0 and j%2~=0 and t%4>2 then
    self:set(i,j,0-floor(t) + v )
   else
    self:set(i,j,1-floor(t) + v )
   end
  end
 end
 
end




-- action bars
function paletteMaskActionBars(t,v)
 v = v or 4
 local b = floor(t)
 paletteMaskSetBox(mainScreen.paletteMask, 0,0,  192,b,  v)
 paletteMaskSetBox(mainScreen.paletteMask, 0,112-b,  192,112-b+16, v)
end


-- testing, remove later... or keep this? it's quite fun . _.
function wipcircleMaskTest(self)
 
 
 for l=1,2 do
 
 
 for k=1,3 do
  local x,y = sin( (globalTimer+k*100)/60)*28+96, cos( (globalTimer+k*100)/60)*28+56
  
  local r = floor( (sin(globalTimer/60)*30+32 )*2)/2
  for i=-r,r do
   for j=-r,r do
    if i^2+j^2<r^2 then
     
     if l==1 then
      self:set(x+i,y+j,1)
     else
     
      self:add(x+i,y+j,k*2-1)
     end
     
    end
   end
  end
 end
 
 end
 
end




-- maybe rework?
function maskSelectiveBackgroundTiles(self, v,size,offset, mask, rate)
 offset = offset or 0
 local i,j = 0,0
 
 BGTileTimer = BGTileTimer%(size^2) + (rate or 0.8)
 while true do
  i = i + 1
  local x, y = floor(-BGTileTimer   + (i-1)*size ), floor(-BGTileTimer/2 + (j-1)*size )
  
  if x+size>0 and y+size>0 and (i+j)%2==0 then
   paletteMaskSelectiveBox(self, x,y,x+size,y+size,v, mask or 0)
  end
  
  if x + size > 192 then
   i, j = 0, j + 1
   if y + size > 112 then
    return
   end
  end
  
 end
end




