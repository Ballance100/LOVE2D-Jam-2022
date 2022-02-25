

-- quick way to get the indexed colors.
function getColor(i)
 return math.max(math.min(i,64),0)/64,0,0,1
end


-- set a indexed color
function setIndexColor(i)
 love.graphics.setColor( getColor(i) )
end