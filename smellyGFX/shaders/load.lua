-- load shaders needed.

-- putting it in a table cause .read returns more than just contents and I don't want to deal with it.
local f = {
 love.filesystem.read("smellyGFX/shaders/screenShader.glsl"),
 love.filesystem.read("smellyGFX/shaders/paletteMaskShader.glsl"),
 love.filesystem.read("smellyGFX/shaders/paintShader.glsl"),
 love.filesystem.read("smellyGFX/shaders/transparentShader.glsl")
}

-- convert indexed color to supplied palette
screenShader      = love.graphics.newShader( f[1] )
screenShader:send("screenPalette", love.graphics.newImage("smellyGFX/sprites/key.png") )

-- convert the indexes present with the overlapping indexes in a paletteMask
paletteMaskShader = love.graphics.newShader( f[2] )

-- apply optional color palettes if needed
paintShader       = love.graphics.newShader( f[3] )
-- same thing just for returning alpha instead of index 0?
transparentShader = love.graphics.newShader( f[4] )

-- default mask colors for the mask colors 61,62 in the pallete (feel free to ignore.)
paintShader:send("mask", 0, 0 )
transparentShader:send("mask", 0, 0 )