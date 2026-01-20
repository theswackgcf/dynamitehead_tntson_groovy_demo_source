{
	depth = 9998;
	_bgName = "";
	_scale = 1.4;
	_scrollSpeed = 1.06;
	
	_thunder = false;
	_thunderalp = 1;
	_thundertimer = 0;
	
	_timer = 0;
	t = shader_get_uniform(shd_wavy, "timer");
	fX = shader_get_uniform(shd_wavy, "freqX");
	fY = shader_get_uniform(shd_wavy, "freqY");
	s = shader_get_uniform(shd_wavy, "scaling");
	aX = shader_get_uniform(shd_wavy, "ampX");
	aY = shader_get_uniform(shd_wavy, "ampY");
	
	_lv2_bgoffset = [0,0,0,-50,-100];
	_lv2_bgangle = [0,0,0,0,0];
	_lv2_anglespeed = 0.002;
	_lv2_tint = c_white;
}
