

-- set up window properties like width and such
window={
 width     = 12,
 height    = 7,
 upScale   = 6,
 tileScale = 16,
 x = 145,
 y = 0
}
scaleSize=12

version = "v0.1"


function love.conf(t)
 t.window.resizable=true
 t.window.title = "SmellyGFX example "..version

 t.window.minwidth = window.width*window.tileScale
 t.window.minheight = window.height*window.tileScale
 
end
