{
	visible = false;
	
	_allsounds = ds_map_create();
	
	_init = false;
	
	_order = 0;
	_spawndir = "";
	_enmtype = -1;
	_delay = 0;
	
	_codename = "st2_enm2";
	_enmtypes = global._enmtypes[? _codename];
	
	_canspawn = 0;
	
	_curdir = DIR_R;
	_xspd = 0;
	
	_yoffs = 0;
	_timer = 0;
	
	_sndtimer = 0;
	
	_colorsinit = false;
	
	_maxcolors = global._maxcolors[? _codename];
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	_rep = "";
}