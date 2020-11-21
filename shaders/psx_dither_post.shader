shader_type canvas_item;

uniform sampler2D scene_col;
uniform sampler2D dither_tex: hint_white;
uniform float col_depth = 32.0;

uniform float dith_range: hint_range(0,1) = 1.0;

void fragment() {
	vec2 dith_size = vec2(textureSize(dither_tex,0)); // for GLES2: substitute for the dimensions of the dithering matrix
	vec2 buf_size = vec2(textureSize(scene_col,0));
	
	vec4 color = texture(scene_col, SCREEN_UV);
	color = round(color*255.0)/255.0;

	vec3 dith = texture(dither_tex, SCREEN_UV*(buf_size/dith_size)).rgb;
	dith -= 0.5;
	
	color.rgb = round((color.rgb + (dith_range*dith)/col_depth) * col_depth) / col_depth;
	
	COLOR.rgba = color.rgba;
	
}