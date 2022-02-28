local MainMenu = {}

local cursorX, cursorY = 0, 0

function getStageScaleAndOffset()
  local s, offsetX, offsetY = setWindowScale()
  local scaleFactor = scaleSize / s
  return scaleFactor, offsetX, offsetY
end

function MainMenu:mousemoved(screenX, screenY, screenDX, screenDY)
  local scaleFactor, offsetX, offsetY = getStageScaleAndOffset()
  cursorX = screenX / scaleFactor - offsetX
  cursorY = screenY / scaleFactor - offsetY
end

function MainMenu:mousepressed(screenX, screenY, screenDX, screenDY)
  local scaleFactor, offsetX, offsetY = getStageScaleAndOffset()
  cursorX = screenX / scaleFactor - offsetX
  cursorY = screenY / scaleFactor - offsetY
  player.x = cursorX
  player.y = cursorY
end

function MainMenu:draw()
 
 text("\twelcome to Catlateral\n\t\t\t\t\t\tdamage 2:", 3, 3, 3, 3, 0)
 text("seismic boogaloo",36,32,3,5,0)

 text("- Start", 8, 55, 3, 3, 0)
 text("- How to play", 8, 70, 3, 3, 0)
 text("- About", 8, 85, 3, 3, 0)
end

return MainMenu
