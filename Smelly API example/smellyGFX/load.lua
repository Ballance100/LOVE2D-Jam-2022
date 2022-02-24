


-- set filters
love.graphics.setDefaultFilter("nearest","nearest",1)
love.graphics.setLineStyle("rough")
love.graphics.setPointSize(1)


-- set font. this call along with the text widths in text.lua are what you need to change to change the font stuff.
-- feel free to replace.. might make a new font that's bigger for this game anyways cause I like making fonts.
love.graphics.setFont(love.graphics.newImageFont("smellyGFX/sprites/font.png","abcdefghijklmnopqrstuvwxyz 1234567890.,!¡?¿-+=~()<>★Ω#:;$`≀P%∙□"))


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