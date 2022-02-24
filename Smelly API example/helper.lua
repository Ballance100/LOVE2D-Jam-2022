



-- utf8 lib to help with text
utf8 = require("utf8")

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



-- split your strings arrg! (thanks MikuAuah!)
function split(str,find)
 local i, items=0, {}
 
 while true do
  local siz=str:find(find,i,true) or #str+1
  items[#items+1]=str:sub(i,siz-1)
  i=siz+#find
  if i>#str then break end
 end
 return items
end


-- shorthands
abs=math.abs
floor=math.floor
ceil=math.ceil
sin=math.sin
cos=math.cos
max=math.max
min=math.min
tau=6.28318