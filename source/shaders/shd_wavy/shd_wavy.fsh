varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ampX;
uniform float ampY;
uniform float freqX;
uniform float freqY;
uniform float scaling;
uniform float timer;

void main()
{
    vec2 coord = v_vTexcoord;
    float dx = ampX * sin(freqX * coord.y + scaling * timer);
	float dy = ampY * cos(freqY * coord.x + scaling * timer);
    coord.x = coord.x + dx;
	coord.y = coord.y + dy;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, coord );
}
