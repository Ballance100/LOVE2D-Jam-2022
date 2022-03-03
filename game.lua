local bump = require('bump')
local Game = {}

local gameWidth, gameHeight = 200, 104
local cursorX, cursorY = gameWidth / 2, gameHeight / 2

local Cat = require('cat')
local player = Cat:new(cursorX, cursorY)

local world = bump.newWorld(8)
do
  local GW, GH = gameWidth, gameHeight
  world:add("floor", 0, GH - 8, 200, 200)
  world:add(player, player.x, player.y, 16, 16)
end

function Game:draw()
  sprite(sp.test[1], 0, 0)
  -- [[ test example 1
  local c=17
  -- rectangle(2,2,34,34, c)
  circleOutLine(cursorX, cursorY, 4, 6, c, globalTimer/20)
  do
    local r = 8
    circleFill(player.x - 0, player.y - 0, r, c)
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

  local goalX = player.x + (speed * dx_sign * dt)
  player.vy = player.vy + (16 * dt)
  local goalY = player.y + player.vy
  local actualX, actualY, cols, len = world:move(player, goalX, goalY)
  local onGround = goalY > actualY
  player:moveTo(actualX, actualY, onGround)
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
  -- player.x = cursorX
  -- player.y = cursorY
  local jumped = player.canJump and player:jump() or false
  print("the player jumped?", jumped)
end

return Game
