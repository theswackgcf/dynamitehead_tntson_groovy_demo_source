varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_color;

void main() {
	vec4 textureColor = texture2D(gm_BaseTexture, v_vTexcoord);
	gl_FragColor = u_color * ceil(textureColor.a);
}