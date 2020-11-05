shader_type canvas_item;

uniform sampler2D scene_col;
uniform sampler2D dither_tex: hint_white;
uniform float col_depth = 32.0;
uniform float screen_fraction = 4.0; // must match the stretch shrink parameter of the ViewportContainer

void fragment() {
	vec4 color = texture(scene_col, SCREEN_UV);
	
	vec2 size = vec2(textureSize(dither_tex,0)); // for GLES2: substitute for the dimensions of the dithering matrix
	float dith = texture(dither_tex, SCREEN_UV*vec2(1.0/SCREEN_PIXEL_SIZE.x/(screen_fraction*size.x), 1.0/SCREEN_PIXEL_SIZE.y/(screen_fraction*size.y))).r / col_depth;
	dith -= dith*.5;
	dith *= 2.0;
	
	color = vec4(round((color.rgb + dith) * col_depth) / col_depth, color.a);
	
	COLOR.rgb = color.rgb;
}