{
	_codename = "";
	
	depth = -5001;
	
	_allsounds = ds_map_create();
	
	_init = false;
	_spd = [0,0];
	
	_battlezone = false;
	
	_act = 0;
	_sintimer = 0;
	_timer = 0;
	
	_scale = 0.65;
	
	_freeze = 0;
	
	_speedup = 2.1;
	
	_alpha = 1;
	
	image_xscale = _scale;
	image_yscale = _scale;
	
	_confirmkill = false;
	
	_dovoice = false;
	_playvoice = -1;
	
	//colors
	_enmtype = -1;
	_docolors = false;
	_maxcolors = 4;
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
}