local Game = {}
local earthquake = true
local shake = {x=0,y=0}

function tweenShaking()--Smooths shaking to avoid motion sickness
---@diagnostic disable-next-line: redundant-parameter
  libs.timer.tween(.1,shake,{x=love.math.random(0.0000000,.9999999999),y=love.math.random(0,1)},"linear",tweenShaking)
end
tweenShaking()
function Game:draw()

  if earthquake then love.graphics.translate(shake.x,shake.y) end
  -- [[ test example 1
  local c=50
  rectangle(2,2,34,34, c)
  circleOutLine(56,18, 16, 16, c, globalTimer/20)
  circleFill(80,2,16, c)

  if earthquake then love.graphics.translate(0,0) end
end

return Game
