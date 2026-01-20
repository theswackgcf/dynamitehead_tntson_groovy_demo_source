{
	_init = false;
	
	_xpos = WIDTH/2;
	
	_bgpos = [0,0];
	
	_dhact = 0;
	_dhpos = -512;
	_dhspd = 0;
	_dhframe = 0;
	_dhtime = 0;
	
	_confirm = false;
	
	_allsounds = ds_map_create();
	
	_timer = 0;
	t = shader_get_uniform(shd_wavy, "timer");
	fX = shader_get_uniform(shd_wavy, "freqX");
	fY = shader_get_uniform(shd_wavy, "freqY");
	s = shader_get_uniform(shd_wavy, "scaling");
	aX = shader_get_uniform(shd_wavy, "ampX");
	aY = shader_get_uniform(shd_wavy, "ampY");

	_randfgtimer = 0;
	
	sfx_play(snd_surf, 0, true);
	
	instance_create_depth(0,0,0,obj_stagelogo);
	
	_rep = "";
	_colorsinit = false;
	
	//colors
	_maxcolors = global._maxcolors[? "dh"];
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
}