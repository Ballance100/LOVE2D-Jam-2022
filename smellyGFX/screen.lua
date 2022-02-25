
-- make a new screen object thingy (has a canvas and paletteMask bundled together.)
function newScreen(r)
 r = r or 1
 return {
  canvas = love.graphics.newCanvas(192*r,112*r, {format="r8"} ),
  paletteMask = createPaletteMask()
 }
end


-- use a screen eh
function setScreen(screen)
 love.graphics.setCanvas(screen.canvas)
end