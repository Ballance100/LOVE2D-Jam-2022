local Game = {}

local gameWidth, gameHeight = 200, 100
local cursorX, cursorY = gameWidth / 2, gameHeight / 2

function Game:draw()
  -- [[ test example 1
  local c=50
  rectangle(2,2,34,34, c)
  circleOutLine(cursorX, cursorY, 16, 16, c, globalTimer/20)
  circleFill(80,2,16, c)
end

function Game:mousemoved(event)
  local s,x,y = setWindowScale()
  local ratio = scaleSize / s
  cursorX = love.mouse.getX() / ratio - x
  cursorY = love.mouse.getY() / ratio - y
end

return Game
