local bump = require('bump')
local Game = {}

local gameWidth, gameHeight = 200, 104
local cursorX, cursorY = gameWidth / 2, gameHeight / 2

local Cat = require('cat')
local player = Cat:new(cursorX, cursorY)

local world = bump.newWorld(8)
do
  local GW, GH = gameWidth, gameHeight
  world:add("floor", 0, GH - 16, 200, 200)
  world:add("stool", 51, 74, 5, 1)
  world:add("shelf", 16, 58, 16, 1)
  world:add("windowsill", 72, 63, 15, 1)
  world:add("lwall", 0, 0, 16, 104)
  world:add("rwall", GW - 16, 0, 16, 104)
  world:add(player, player.x, player.y, 9, 15)
end

function Game:draw()
  sprite(sp.test[1], 0, 0)
  -- [[ test example 1
  local c=17
  -- rectangle(2,2,34,34, c)
  circleOutLine(cursorX, cursorY, 4, 6, c, globalTimer/20)
  do
    sprite(sp.test[2], player.x, player.y - 1)
  end
end

function Game:update(dt)
  do -- player controller
    -- get x distance from cursor to the player
    local signed_dx = cursorX - (player.x + 6)
    local dx_sign = signed_dx < 0 and -1 or 1
    local dx = math.abs(signed_dx)
    local speed
    local speed_lookup = {
      4 , 0 ,
      8, 20,
      32, 50,
      10000, 90
    }
    for i = 1, #speed_lookup - 1, 2 do
      if dx < speed_lookup[i] then
        speed = speed_lookup[i+1]
        break
      end
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
