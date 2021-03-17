shader_type spatial;
render_mode unshaded;

uniform float pixel_size = 4.0;
uniform float col_depth = 32.0;
uniform bool active = true;
uniform float outline_extrusion = 0.01;

// Implementation from https://github.com/hughsk/glsl-dither
float dither4x4(vec2 position) {
  int x = int(mod(position.x, 4.0));
  int y = int(mod(position.y, 4.0));
  int index = x + y * 4;
  float limit = 0.0;

  if (x < 8) {
    if (index == 0) limit = 0.0625;
    if (index == 1) limit = 0.5625;
    if (index == 2) limit = 0.1875;
    if (index == 3) limit = 0.6875;
    if (index == 4) limit = 0.8125;
    if (index == 5) limit = 0.3125;
    if (index == 6) limit = 0.9375;
    if (index == 7) limit = 0.4375;
    if (index == 8) limit = 0.25;
    if (index == 9) limit = 0.75;
    if (index == 10) limit = 0.125;
    if (index == 11) limit = 0.625;
    if (index == 12) limit = 1.0;
    if (index == 13) limit = 0.5;
    if (index == 14) limit = 0.875;
    if (index == 15) limit = 0.375;
  }

  return limit;
}

void vertex() {
	VERTEX += NORMAL * outline_extrusion;
}

// Based on Arlez80's mosaic shader: https://bitbucket.org/arlez80/godot-mosaic-shader/src/master/
void fragment( )
{
	// For scene editing convenience due to transparency bugs in editor.
	if (!active)
		discard;
	
	vec2 p = round( FRAGCOORD.xy / pixel_size ) * pixel_size;
	vec3 col = texelFetch( SCREEN_TEXTURE, ivec2( p ), 0 ).rgb;
	float dith = dither4x4(p / pixel_size) - 0.5;
	ALBEDO = round(col*col_depth + dith) / col_depth;
}