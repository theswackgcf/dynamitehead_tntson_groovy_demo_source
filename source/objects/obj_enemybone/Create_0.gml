{
	image_speed = 0;
	image_xscale = 0.47;
	image_yscale = 0.47;
	
	_allsounds = ds_map_create();
	
	_codename = "st2_enm1";
	_enmtype_disp = string(0);
	_boneframe = irandom_range(0,2);
	
	_xspd = 0;
	_vspd = 0;
	_height = 0;
	_groundlevel = 0;
	_bump = false;
	_rotspeed = random_range(3,7);
	_randangle = random_range(-4,4);
	_freeze = 0;
	
	_rest = false;
	
	_sort = true;
	_depthoffset = 0;
	
	_forcedepth = 0;
	
	_deathtimer = 0;
	_plustimer = random_range(0,76);
	_kill = false;
	
	_colorblend = c_white;
	
	_active = true;
	_deadtimer = 0;
}