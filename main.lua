



function love.load()
 
 -- some helper functions and such
 require("helper")
 
 -- load in the gfx api
 require("smellyGFX/load")
 
 
 -- load in the stuff needed to draw the example
 require("draw")
end


-- time
globalTimer=0

-- needs to use update to render the spriets as needed to avoid lag.
function love.update()
 if renderSprites then renderSprites() end
 globalTimer = globalTimer + 1
end