{
	_codename = "fella";
	_init = false;
	
	_dir = choose(DIR_L, DIR_R);
	_changedir = false;
	
	_idletimer_max = 100;
	_walktimer_max = 220;
	_xspd_max = 6;
	
	_scale = 0.86;
	
	image_xscale = _scale*_dir;
	image_yscale = _scale;
	
	_act = 0;
	_timer = 0;
	_xspd = 0;
	_yspd = 0;
	
	_anim = "idle";
	
	_idletype = 0;
	
	_override = false;
	_idlet = 0;
	_idlea = 0;
	
	_jump = false;
	
	_starty = y;
}