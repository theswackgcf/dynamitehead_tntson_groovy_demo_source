#extension GL_OES_standard_derivatives : enable

varying vec2 v_vTexcoord;
varying vec4 v_vBarycentric;

varying float v_DistanceFromCamera;

uniform vec3 wire_color;

void main() {
    float wire_thickness = 0.8;
    float wire_alpha = 1.0;
    vec3 col_normalized = vec3(wire_color.r/255.0,wire_color.g/255.0,wire_color.b/255.0);
    
    vec3 bc_width = fwidth(v_vBarycentric.rgb);
    vec3 aa_width = smoothstep(vec3(0), bc_width * wire_thickness, v_vBarycentric.rgb);
    float edge_factor = min(aa_width.r, min(aa_width.g, aa_width.b));
    
    edge_factor = 1.0 - edge_factor;
    
    gl_FragColor.rgb = mix(vec3(0,0,0), col_normalized, edge_factor * wire_alpha);
    gl_FragColor.a = 1.0;
}