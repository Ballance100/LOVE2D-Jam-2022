uniform Image paletteMask;
uniform Image screenPalette;

 vec4 effect
 (
  vec4 color,
  Image texture,
  vec2 texture_coords,
  vec2 screen_coords
 )
 
 {
  
  // get the stuffs
  float screenPixel = Texel(texture, texture_coords).r;
  float palettePixel = Texel(paletteMask,texture_coords ).r;
  
  
  // blast it out
  return Texel(screenPalette, vec2(screenPixel+0.01,palettePixel*2) );
  
 }