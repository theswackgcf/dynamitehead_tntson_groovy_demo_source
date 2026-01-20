{
	depth = 9993;
	_ind = 0;
	_indnext = _ind+1;
	_alp = 0;
	
	_inview = false;
	
	_timer = 0;
	t = shader_get_uniform(shd_wavy, "timer");
	fX = shader_get_uniform(shd_wavy, "freqX");
	fY = shader_get_uniform(shd_wavy, "freqY");
	s = shader_get_uniform(shd_wavy, "scaling");
	aX = shader_get_uniform(shd_wavy, "ampX");
	aY = shader_get_uniform(shd_wavy, "ampY");
}