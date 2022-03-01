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
    local r = 8
    circleFill(player.x - r, player.y - r, r, c)
  end
end

function Game:update(dt)
  do -- player controller
    -- get x distance from cursor to the player
    local signed_dx = cursorX - player.x
    local dx_sign = signed_dx < 0 and -1 or 1
    local dx = math.abs(signed_dx)
    local speed
    local speed_lookup = {
      8 , 10,
      16, 20,
      32, 50,
      10000, 90
    }
    for i = (#speed_lookup - 1), 1, -2 do
      if dx < speed_lookup[i] then
        speed = speed_lookup[i+1]
        break
      end
    end

    if dx < 8 then
      speed = 0
    elseif dx < 10 then
      speed = 20
    elseif dx < 30 then
      speed = 50
    else
      speed = 90
    end
  player.x = player.x + (speed * dx_sign * dt)
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
