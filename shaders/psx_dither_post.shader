shader_type canvas_item;

uniform sampler2D scene_col;
uniform sampler2D dither_tex: hint_white;
uniform float col_depth = 32.0;

void fragment() {
	vec2 dith_size = vec2(textureSize(dither_tex,0)); // for GLES2: substitute for the dimensions of the dithering matrix
	vec2 buf_size = vec2(textureSize(scene_col,0));
	
	vec4 color = texture(scene_col, SCREEN_UV);
	color = round(color*255.0)/255.0;

	float dith = texture(dither_tex, SCREEN_UV*(buf_size/dith_size)).r / col_depth;
	dith = 2.0*dith - dith;
	
	color.rgb = round((color.rgb + dith) * (col_depth-1.0)) / (col_depth-1.0);
	
	COLOR.rgba = color.rgba;
}