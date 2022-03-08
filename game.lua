local bump = require('bump')
local SpriteObj = require 'spriteObj'
local BreakableSprite = require 'breakableSprite'
local Game = {}
local Score = {0, 0}

local gameWidth, gameHeight = 200, 104
local cursorX, cursorY = gameWidth / 2, gameHeight / 2

local Cat = require('cat')
local player = Cat:new(cursorX, cursorY)

local world = bump.newWorld(8)
local features
local breakables

do
  local GW, GH = gameWidth, gameHeight
  local spr = SpriteObj
  -- the first two characters of name are read by the collision function
  -- 'ss' is for semi-solid, ba stands for break-able 
  features = {
    spr:new({x =    0, y =     0, w =  16, h = GH, name = "lwall"}),
    spr:new({x =  592, y =     0, w =  16, h = GH, name = "rwall"}),
    spr:new({x =    0, y = GH-20, w = 608, h = 20, name = "floor"}),
    spr:new({x =   63, y =    68, w =  40, h =  1, name = "sstable"}),
    spr:new({x =   48, y =    75, w =  11, h =  1, name = "ssstool"}),
    spr:new({x =   16, y =    56, w =  16, h =  1, name = "ssshelf"}),
    spr:new({x =  125, y =    61, w =  15, h =  1, name = "sswindwosill"}),
  }

  --[[breakables = {
    spr:new({x =   16, y =    40, w =  16, h =  16, name = "bacup", img = 5}),
    spr:new({x =   48, y =    70, w =  16, h =  16, name = "bacup2", img = 5}),
  }
  --]]
  breakables = {
    BreakableSprite:new(16, 40, 'cup'),
    BreakableSprite:new(48, 70, 'cup'),
  }


  for i, item in ipairs(breakables) do
    local x, y = item.x + item.bbox_x, item.y + item.bbox_y
    local w, h = item.bbox_w, item.bbox_h
    world:add(item, x, y, w, h)
  end

  for i, item in ipairs(features) do
    local x, y, w, h = item.x, item.y, item.w, item.h
    world:add(item, x, y, w, h)
  end

  world:add(player, player.x, player.y, 9, 15)
end

function semisolid(actor, other)
  local prefix = other.name:sub(1, 2)
  if prefix == "ss" then -- semi-solid
    if actor.vy < 0 then
      return false
    elseif actor.y + actor.h > other.y then
      return false
    end
  elseif prefix == "ba" then
    return "cross"
  end
  return "slide"
end

local blueSpriteNumbers = {[0] = 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}
local redSpriteNumbers  = {[0] = 21, 22, 23, 24, 25, 26, 27, 28, 29, 30}
function drawScoreUI(blueScore, redScore)
  local score_ui_x = (gameWidth - 80) / 2
  sprite(sp.test[10], score_ui_x, 0)

  local blueNumOne = math.floor(blueScore / 10)
  local blueNumTwo = blueScore % 10
  print("bNumOne, NumTwo: ", blueNumOne, blueNumTwo)
  local blueSpriteIdxOne = blueSpriteNumbers[blueNumOne]
  local blueSpriteIdxTwo = blueSpriteNumbers[blueNumTwo]
  print("bSprIdxOne, IdxTwo", blueSpriteIdxOne, blueSpriteIdxTwo)

  local redNumOne = math.floor(redScore / 10)
  local redNumTwo = redScore % 10
  local redSpriteIdxOne = redSpriteNumbers[redNumOne]
  local redSpriteIdxTwo = redSpriteNumbers[redNumTwo]

  -- blue
  sprite(sp.test[blueSpriteIdxOne], score_ui_x + 23, 0)
  sprite(sp.test[blueSpriteIdxTwo], score_ui_x + 31, 0)
  -- red
  sprite(sp.test[redSpriteIdxOne], score_ui_x + 42, 0)
  sprite(sp.test[redSpriteIdxTwo], score_ui_x + 49, 0)
end

function Game:draw()
  sprite(sp.test[1], 0, 0)
  -- [[ test example 1
  local c=17
  -- rectangle(2,2,34,34, c)
  do
    sprite(sp.test[2], player.x - 3, player.y - 1)
    
    for i, item in ipairs(breakables) do
      sprite(sp.test[item.img], item.x, item.y)
    end
    
    drawScoreUI(13, 10)
    circleOutLine(cursorX, cursorY, 4, 6, c, globalTimer/20)
  end
end

function Game:update(dt)
  local collisions
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
    local actualX, actualY, cols, len = world:move(player, goalX, goalY, semisolid)
    collisions = cols
    local onGround = goalY > actualY
    player:moveTo(actualX, actualY, onGround)

  end


  -- collision response for breakables
  local targetObj
  local idx
  for i, collision in ipairs(collisions) do
    local prefix = collisions[i].other.name:sub(1, 2)
    for ii, item in ipairs(breakables) do
      if item == collisions[i].other then
        idx = ii
        break
      end
    end

    if breakables[idx] then
      if love.mouse.isDown(2) then
        print("swiped breakable object!")
        targetObj = collisions[i].other
        break
      end
    end
  end

  if targetObj then
    table.remove(breakables, idx)
    world:remove(targetObj)
    Score[1] = Score[1] + 1
  end

  -- targetObj.tweenOutAndRemove
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

function Game:mousepressed(screenX, screenY, button, istouch, presses)
  local scaleFactor, offsetX, offsetY = getStageScaleAndOffset()
  cursorX = screenX / scaleFactor - offsetX
  cursorY = screenY / scaleFactor - offsetY
  if button == 1 then
    local jumped = player.canJump and player:jump() or false
    print("the player jumped?", jumped)
  elseif button == 2 then
    print("swipe!")
  end
end

return Game
