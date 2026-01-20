//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_SepiaAmount;

void main()
{
    vec4 original_color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    mat3 sepia_matrix = mat3(
        0.59,0.95,0.31,
		0.29,0.82,0.04,
		0.21,0.47,0.10
    );
    
    vec3 sepia_color = original_color.rgb * sepia_matrix;
    
    gl_FragColor.rgb = mix(original_color.rgb, sepia_color, u_SepiaAmount);
    gl_FragColor.a = original_color.a;
}