-- text manip gfx



--[[ text table:

normal:

a b c d e f g h i j k l m n o p q r s t u v w x y z
space
1 2 3 4 5 6 7 8 9 0 . , ! ¡ ? ¿ - + = ≈ ( )
★ Ω # : ; $ ` ≀ % ∙ □

text cmds:

Q W E R T
P Y U I @

--]]


local tau = math.pi * 2
local sin, cos = math.sin, math.cos
local floor, ceil = math.floor, math.ceil
local max, min = math.max, math.min

local utf8 = require('utf8')

-- dump out a table of the chars seperated by the codepoints.
function utf8.dump(str)
 local t={}
 for i=1,#str do
  
  local o=utf8.offset(str,i)-i
  
  if i+o>#str then return t end
  
  local c=utf8.char( utf8.codepoint(str, i+o, i+o) )
  t[#t+1]=c
  
 end
 
 return t
end


-- draw text
function text(str,x,y, color, mode, outlineColor, timer)
 love.graphics.setShader()
 str = tostring(str)
 local t = utf8.dump(str)
 --[[
 local originalX = originalX or x
 local cursor = originalX or 0
 local originalY = originalY or y
 local cursorY = originalY or 0
 --]]
 x, y = x or 0, y or 0
 local cursor, cursorY = x, y
 
 for i=1,#t do
  
  
  local o,ox,oy = 0, 0, 0
  if mode then
   
   o = sin((i+(timer or globalTimer))/(#str/4))*4
   o = floor(o-o/2+.5)
   
   if mode~=0 or not mode then
    if (mode-1)%3==1 then oy=o end
    if (mode)%3==1 then ox=o end
   end
   
  end
  
  
  if not mode or mode<3 then
   if mode and mode>3 then 
    setIndexColor(outlineColor or 1)
   else
    setIndexColor(color or 63)
   end
   
   love.graphics.print(t[i],cursor+ox-.5,cursorY+oy)
   cursor = cursor + textCursor(t[i])
   
   if t[i]=="\n" then
    cursor  = x
    cursorY = cursorY + 10
   end
   
  else
   
   for k=-1,2 do--max( textCursor(t[i])-6 ,1) do
    for j=-1,1 do
     text(t[i],cursor+ox+k, 0 + cursorY+oy+j, outlineColor or 1)
    end
   end
   
   
   setIndexColor(color or 63)
   love.graphics.print(t[i],cursor+ox-.5, oy+cursorY, nil,nil,nil)
   cursor=cursor+textCursor(t[i])
   -- [[
   if t[i]=="\n" then
    cursor  = x
    cursorY = cursorY + 10
   end
   --]]
  end
 end
 
end


-- move cursor based on how big certain glyphs are
function textCursor(char)
 local textcursorsizes={"i",6,"l",7,"t",7,"m",9,"M",9,"W",9}
 local a = 8
 for j=1,#textcursorsizes/2 do
  if char==textcursorsizes[j*2-1] then
   a=textcursorsizes[j*2]
  end
 end
 return a
 
end



-- return size of a string if it was printed
function getStringSize(str)
 str = tostring(str)
 
 local a={0}
 for i=1,#str do
  if string.sub(str,i,i)=="\n" then
   a[2] = a[1]
   a[1] = 0
  end
  a[1] = a[1] + textCursor( string.sub(str,i,i) )
 end
 
 local n=0
 for i=1,#a do
  if a[i]>n then n = a[i] end
 end
 
 return n
end



