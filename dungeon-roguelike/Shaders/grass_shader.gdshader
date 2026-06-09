shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled;

uniform sampler2D albedo_texture : source_color, hint_default_white;
uniform vec4 albedo_color : source_color = vec4(1.0);

uniform float roughness : hint_range(0,1) = 1.0;
uniform float metallic : hint_range(0, 1) = 0.0;


void vertex() {
	// Called for every vertex the material is visible on.
	
	// Billboarding
	// Get the world position into view space cleanly
    vec4 origin = MODELVIEW_MATRIX * vec4(0.0, 0.0, 0.0, 1.0);

    MODELVIEW_MATRIX[0] = vec4(1.0, 0.0, 0.0, 0.0);
    MODELVIEW_MATRIX[1] = vec4(0.0, 1.0, 0.0, 0.0);
    MODELVIEW_MATRIX[2] = vec4(0.0, 0.0, 1.0, 0.0);
    MODELVIEW_MATRIX[3] = origin;
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 tex = texture(albedo_texture, UV);
	ALBEDO = tex.rgb * albedo_color.rgb;
	ALPHA = tex.a;
	ALPHA_SCISSOR_THRESHOLD = 0.5;
}

void light() {
	// Called for every pixel for every light affecting the material.

    // If this light is casting a shadow on any part, darken the whole object
    //if (ATTENUATION < 1.0) {
    //    DIFFUSE_LIGHT += LIGHT_COLOR * ALBEDO * 0.1;
    //} else {
    //    DIFFUSE_LIGHT += LIGHT_COLOR * ALBEDO;
    //}
	//DIFFUSE_LIGHT += ALBEDO * ATTENUATION;
}
