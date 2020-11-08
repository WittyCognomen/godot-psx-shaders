shader_type canvas_item;

uniform sampler2D scene_col;
uniform sampler2D dither_tex: hint_white;
uniform float col_depth = 32.0;

void fragment() {
	vec2 dith_size = vec2(textureSize(dither_tex,0)); // for GLES2: substitute for the dimensions of the dithering matrix
	vec2 buf_size = vec2(textureSize(scene_col,0));
	vec2 screen_size = 1.0/SCREEN_PIXEL_SIZE;
	
	vec4 color = texture(scene_col, SCREEN_UV);

	float dith = texture(dither_tex, SCREEN_UV*(buf_size/dith_size)).r / col_depth;
	dith -= dith*.5;
	dith *= 2.0;
	
	color = vec4(round((color.rgb + dith) * col_depth) / col_depth, color.a);
	
	COLOR.rgba = color.rgba;
}