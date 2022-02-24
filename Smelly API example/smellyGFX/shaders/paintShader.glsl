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
 vec4 palpixel = Texel(palette, vec2(pixel.r*7+0.005,0.5) );
 
 // mask
 if (palpixel.r==0.95294117647059) { palpixel = vec4(mask[0],0,0,1); }
 if (palpixel.r==0.96862745098039) { palpixel = vec4(mask[1],0,0,1); }
 
 if (palpixel.r==0) {
  discard;
 }
 
 return palpixel;
 
}