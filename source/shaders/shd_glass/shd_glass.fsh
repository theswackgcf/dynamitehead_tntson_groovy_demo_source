varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D overlayTex;
uniform float overlayScale;
uniform float windowScale;

void main()
{
	vec4 base = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 overlay = texture2D(overlayTex, fract((gl_FragCoord.xy / vec2(windowScale, windowScale)) * vec2(overlayScale, overlayScale)));
    
	gl_FragColor = vec4(mix(base.rgb, overlay.rgb, overlay.a * base.a), base.a);
}