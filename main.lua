libraries = {timer = require "hump.timer"}
libs = libraries--shortcut
-- shorthands (inherited from api)
local abs = math.abs
local floor, ceil = math.floor, math.ceil
local sin, cos = math.sin, math.cos
local min, max = math.min, math.max
local tau = 2 * math.pi

-- defined by Nathan
local lg = love.graphics

local Game


function love.load()
  -- some helper functions and such

  -- load in the gfx api
  require("smellyGFX/load")
  Game = require('game')

  -- make screens to use
  mainScreen = newScreen()
  pushScreen = newScreen()
  overlayScreen = newScreen()

  gameScreens = {
    mainScreen,
    overlayScreen,
    pushScreen,
  }

  -- time
  globalTimer=0



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
 
  -- delegate drawing game stuff
  Game:draw()

  -- draw to overlay screen
  setScreen(overlayScreen)
 
 
 
  -- push
  pushScreenData()
 
end


-- needs to use update to render the sprites as needed to avoid lag.
function love.update(dt)
 libs.timer.update(dt)
 if renderSprites then renderSprites() end
 globalTimer = globalTimer + 1
end
