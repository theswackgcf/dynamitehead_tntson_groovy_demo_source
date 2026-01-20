varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D backgroundTex; //feed a surface of the scene without lights here

void main()
{
    vec4 bg = texture2D(backgroundTex, v_vTexcoord);
    vec4 mask = texture2D(gm_BaseTexture, v_vTexcoord);
	
    if(mask.a > 0.01){
        if(bg.rgb == vec3(0.0) && bg.a > 0.99){
            gl_FragColor = bg;
        }
		else{
            gl_FragColor = vec4(v_vColour.rgb, 1.0);
        }
    }
	else{
        gl_FragColor = bg;
    }
}