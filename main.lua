-- defined by Nathan
local lg = love.graphics

local Game
local MainMenu


function love.load()
  -- some helper functions and such

  -- load in the gfx api
  require("smellyGFX/load")
  Game = require('game')
  MainMenu = require('mainMenu')

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
  clear(3)
 
  -- delegate drawing game stuff
  Game:draw()
  -- MainMenu:draw()

  -- draw to overlay screen
  setScreen(overlayScreen)
 
 
 
  -- push
  pushScreenData()
 
end


-- needs to use update to render the spriets as needed to avoid lag.
function love.update(dt)
 if renderSprites then renderSprites() end
 globalTimer = globalTimer + 1

 Game:update(dt)
end

function love.mousemoved(x, y, dx, dy, istouch)
  Game:mousemoved(x, y, dx, dy)
end

function love.mousepressed(x, y, dx, dy, istouch)
  Game:mousepressed(x, y, dx, dy)
end
