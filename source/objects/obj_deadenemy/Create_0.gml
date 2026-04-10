{
	_init = false;
	
	_timer = random(1000);
	_intimer = 0;
	_startx = x;
	
	_codename = "enm1";
	
	_allsounds = ds_map_create();
	
	image_xscale = 1;
	image_yscale = 1;
	
	visible = false;
	
	_alpha = 1;
	
	_timer = 0;
	t = shader_get_uniform(shd_wavy, "timer");
	f = shader_get_uniform(shd_wavy, "freq");
	s = shader_get_uniform(shd_wavy, "scaling");
	aX = shader_get_uniform(shd_wavy, "ampX");
	aY = shader_get_uniform(shd_wavy, "ampY");
}