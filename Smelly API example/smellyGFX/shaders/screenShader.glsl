uniform Image screenPalette;

vec4 effect(
 vec4 color,
 Image texture,
 vec2 texture_coords,
 vec2 screen_coords
)
{
 
 float pixelR = Texel(texture, texture_coords).r;
 return Texel(screenPalette, vec2(pixelR+0.005,0) );
}