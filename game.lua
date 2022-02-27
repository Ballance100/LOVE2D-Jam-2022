local Game = {}

function Game:draw()
  -- [[ test example 1
  local c=50
  rectangle(2,2,34,34, c)
  circleOutLine(56,18, 16, 16, c, globalTimer/20)
  circleFill(80,2,16, c)

end

return Game
