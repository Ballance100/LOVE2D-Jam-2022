-- make screens to use
mainScreen = newScreen()
pushScreen = newScreen()
overlayScreen = newScreen()

gameScreens = {
 mainScreen,
 overlayScreen,
 pushScreen,
 
}


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
  mainScreen.paletteMask:update(true,wipcircleMaskTest)
  local c=50
  rectangle(2,2,34,34, c)
  circleOutLine(56,18, 16, 16, c, globalTimer/20)
  circleFill(80,2,16, c)
  for i=0,7 do
   line(129+sin(globalTimer/60)*16 + i, 2, 145+sin(globalTimer/30)*16 + i, 34, c, globalTimer/4, 2,0 )
  end
  ovalFill(2 + sin(globalTimer/20)*6, 40 + cos(globalTimer/20)*6, 18,56, c)
  starFill(40 + sin(globalTimer/20)*6, 40+ cos(globalTimer/20)*6, 56, 56, c)
  
  if sp then
   sprite(sp.test[1],80,40, 1,1 )
  end
  
  text("test text graphic",120,56,c,5,c-2)
 --]]
 
 --[[ test example 2
 
 text("testing... this bob is kinda janky but whatever.",3,3,63,5)
 
 local s = 1+floor(globalTimer/20)%2
 sprite(sp.test[s],48,48 )
 
 sprite(sp.test[s],84,48, sin(globalTimer/30), cos(globalTimer/30))
 
 sprite(sp.test[s],124,48, 1,1, sp.test.altPalette )
 
 
 maskSprite(sp.test[s],1,mainScreen.palettemask,48+sin(globalTimer/30)*64,48, 1,1)
 
 maskSprite(sp.test[s],1,mainScreen.palettemask,48+sin(globalTimer/40)*64,48, 1,1) 
 
 rectangle(8,16,12,12,20)
 
 circleOutLine(32,22,6, 16, 20,globalTimer/30)
 
 circleFill(48,16,6,20)
 
 ovalFill(64,16, 80,24, 20)
 
 starFill(100,8, 116,24, 20)
 
 line(140,24,180,24, 20, globalTimer/8, 2,4, nil, nil, 2,1)
 --]]
 
 -- draw to overlay screen
 setScreen(overlayScreen)
 
 
 
 -- push
 pushScreenData()
 
end


