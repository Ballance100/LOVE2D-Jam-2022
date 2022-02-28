local Game = {}

local gameWidth, gameHeight = 200, 100
local cursorX, cursorY = gameWidth / 2, gameHeight / 2

local Cat = require('cat')
local player = Cat:new(cursorX, cursorY)

function Game:draw()
  -- [[ test example 1
  local c=17
  -- rectangle(2,2,34,34, c)
  circleOutLine(cursorX, cursorY, 4, 6, c, globalTimer/20)
  do
    local r = 12
    circleFill(player.x - r, player.y - r, r, c)
  end
end

function getStageScaleAndOffset()
  local s, offsetX, offsetY = setWindowScale()
  local scaleFactor = scaleSize / s
  return scaleFactor, offsetX, offsetY
end

function Game:mousemoved(screenX, screenY, screenDX, screenDY)
  local scaleFactor, offsetX, offsetY = getStageScaleAndOffset()
  cursorX = screenX / scaleFactor - offsetX
  cursorY = screenY / scaleFactor - offsetY
end

function Game:mousepressed(screenX, screenY, screenDX, screenDY)
  local scaleFactor, offsetX, offsetY = getStageScaleAndOffset()
  cursorX = screenX / scaleFactor - offsetX
  cursorY = screenY / scaleFactor - offsetY
  player.x = cursorX
  player.y = cursorY
end

return Game
