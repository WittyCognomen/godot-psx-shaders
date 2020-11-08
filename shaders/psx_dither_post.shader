shader_type canvas_item;

uniform sampler2D scene_col;
uniform sampler2D dither_tex: hint_white;
uniform float col_depth = 32.0;
uniform float screen_fraction = 4.0; // must match the stretch shrink parameter of the ViewportContainer

void fragment() {
	vec4 color = texture(scene_col, SCREEN_UV);
	
	vec2 size = vec2(textureSize(dither_tex,0)); // for GLES2: substitute for the dimensions of the dithering matrix
	vec2 screen_size = 1.0/SCREEN_PIXEL_SIZE;
	screen_size -= mod(screen_size, vec2(screen_fraction));
	
	vec2 d_uv = SCREEN_UV*screen_size/(size*screen_fraction);

	float dith = texture(dither_tex, d_uv).r / col_depth;
	dith -= dith*.5;
	dith *= 2.0;
	
	color = vec4(round((color.rgb + dith) * col_depth) / col_depth, color.a);
	
	COLOR.rgba = color.rgba;
}