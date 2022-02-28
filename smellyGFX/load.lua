local function split(str,find)
 local i, items=0, {}
 
 while true do
  local siz=str:find(find,i,true) or #str+1
  items[#items+1]=str:sub(i,siz-1)
  i=siz+#find
  if i>#str then break end
 end
 return items
end


-- set filters
love.graphics.setDefaultFilter("nearest","nearest",1)
love.graphics.setLineStyle("rough")
love.graphics.setPointSize(1)


-- set font. this call along with the text widths in text.lua are what you need to change to change the font stuff.
-- feel free to replace.. might make a new font that's bigger for this game anyways cause I like making fonts.
--love.graphics.setFont(love.graphics.newImageFont("smellyGFX/sprites/font.png","abcdefghijklmnopqrstuvwxyz 1234567890.,!¡?¿-+=~()<>★Ω#:;$`≀P%∙□"))
local characters = [[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ _0123456789.,!¡?¿:;'`\"-+*/\|^%~=><()[]{}#$@&←→↑↓❤️🎮🖥☀️☁️☂️⛄️⚠️🌎🌍🌏]]
print("----------CHARACTERS----------")
print(characters)
love.graphics.setFont(love.graphics.newImageFont(
  "smellyGFX/sprites/font.png",
  characters
  ))


-- load the needed files
local files = split([[
shaders/load
sprites/init
sprites/load
sprites/sprite
palette/color
palette/paletteMask
palette/maskEffects
shape
text
window
screen
]],"\n")

for i=1,#files do
 require("smellyGFX/"..files[i])
end
