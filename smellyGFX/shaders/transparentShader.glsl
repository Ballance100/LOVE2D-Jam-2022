uniform Image palette;
uniform float mask[2];

vec4 effect(
 vec4 color,
 Image texture,
 vec2 texture_coords,
 vec2 screen_coords
)
{
 vec4 pixel = Texel(texture, texture_coords);
 
 // mask
 if (pixel.r==0.95294117647059) { pixel = vec4(mask[0],0,0,1); }
 if (pixel.r==0.96862745098039) { pixel = vec4(mask[1],0,0,1); }
 
 if (pixel.r==0) {
  discard;
 }
 return pixel;
}