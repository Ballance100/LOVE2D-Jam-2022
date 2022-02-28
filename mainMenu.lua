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
  text("welcome to Catlateral damage 2:\n\n\t\t\t\t seismic boogaloo",3,3,63,5)
end

return MainMenu
