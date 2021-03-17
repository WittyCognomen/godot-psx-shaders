shader_type spatial; 
render_mode skip_vertex_transform, diffuse_lambert_wrap, specular_phong, vertex_lighting, depth_draw_alpha_prepass, cull_disabled;

uniform vec4 tint_color : hint_color = vec4(1.0);
uniform sampler2D albedoTex : hint_white;
uniform float specular_intensity : hint_range(0, 1);
uniform float vertex_resolution = 256;
uniform float cull_distance = 9999;
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(.0, .0);
uniform vec2 uv_speed = vec2(0,-1);

uniform bool affine_texture_mapping = true;
uniform bool emissive = false;
uniform bool moving_uv = false;
uniform bool double_sided = false;

varying vec4 vertex_coordinates;

void vertex() {
	UV = UV * uv_scale + uv_offset + ((moving_uv)?uv_speed*TIME:vec2(0.0));
	
	float vertex_distance = length((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)));
	
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	NORMAL = abs(vec4(NORMAL, 1.) * MODELVIEW_MATRIX).xyz;
	
	float vPos_w = (PROJECTION_MATRIX * vec4(VERTEX, 1.0)).w;
	VERTEX.xy = vPos_w * round(vertex_resolution * VERTEX.xy / vPos_w) / vertex_resolution;
	vertex_coordinates = vec4(UV * VERTEX.z, VERTEX.z, 0.0);
	
	if (vertex_distance > cull_distance)
		VERTEX = vec3(.0);
}

void fragment() {
	vec4 tex;
	if (affine_texture_mapping){
		tex = texture(albedoTex, vertex_coordinates.xy / vertex_coordinates.z);
	} else {
		tex = texture(albedoTex, UV);
	}
	
	if (!double_sided && !FRONT_FACING){
		ALPHA = 0.0;
	} else {
		ALPHA = tex.a * tint_color.a * COLOR.a;
	}

	if (emissive){
		EMISSION = tex.rgb * tint_color.rgb * COLOR.rgb;
		ALBEDO = vec3(0.0);
	} else {
		ALBEDO = tex.rgb * tint_color.rgb * COLOR.rgb;
	}
	SPECULAR = specular_intensity;
	ROUGHNESS = 1.0;
	
}
