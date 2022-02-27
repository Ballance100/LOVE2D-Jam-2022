
-- shorthands (inherited from api)
local abs = math.abs
local floor, ceil = math.floor, math.ceil
local sin, cos = math.sin, math.cos
local min, max = math.min, math.max
local tau = 2 * math.pi

-- defined by Nathan
local lg = love.graphics



function love.load()
  -- some helper functions and such
  --require("helper")

  -- load in the gfx api
  require("smellyGFX/load")

  -- make screens to use
  mainScreen = newScreen()
  pushScreen = newScreen()
  overlayScreen = newScreen()

  gameScreens = {
    mainScreen,
    overlayScreen,
    pushScreen,
  }

end

-- push the screen datas to the screen at the end.
function pushScreenData()
 
  setScreen(pushScreen)
  mainScreen.paletteMask:push()
  mainScreen.paletteMask:use()
  
  love.graphics.setColor(1,1,1)
  love.graphics.draw(mainScreen.canvas)
  
  love.graphics.setShader(transparentShader)
  love.graphics.draw(overlayScreen.canvas)
  
  love.graphics.setCanvas()
  local s,x,y = setWindowScale()
  love.graphics.scale(scaleSize/s)
  
  love.graphics.setShader(screenShader)
  love.graphics.draw(pushScreen.canvas, x, y)
 love.graphics.setShader()
end




-- example drawing
function love.draw()
 -- if sprites aren't done rendering
 if renderSprites then return end
 
 -- clear screens
 for i=1,#gameScreens do
  gameScreens[i].paletteMask:update(true)
  setScreen(gameScreens[i])
  clear(0)
 end
 
 -- set to main screen
 setScreen(mainScreen)
  clear(63)
 
 -- [[ test example 1
  local c=50
  rectangle(2,2,34,34, c)
  circleOutLine(56,18, 16, 16, c, globalTimer/20)
  circleFill(80,2,16, c)
  ovalFill(2 + sin(globalTimer/20)*6, 40 + cos(globalTimer/20)*6, 18,56, c)
  starFill(40 + sin(globalTimer/20)*6, 40+ cos(globalTimer/20)*6, 56, 56, c)
  
  if sp then
   sprite(sp.test[1],80,40, 1,1 )
  end
  
  text("test text graphic",120,56,c,5,c-2)
 
 -- draw to overlay screen
 setScreen(overlayScreen)
 
 
 
 -- push
 pushScreenData()
 
end


-- time
globalTimer=0

-- needs to use update to render the spriets as needed to avoid lag.
function love.update()
 if renderSprites then renderSprites() end
 globalTimer = globalTimer + 1
end

function love.draw()
end
