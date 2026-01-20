{
	_inview = false;
	
	_allsounds = ds_map_create();
	_init = false;
	_itemarray = [1];
	_dir = "r";
	_sort = true;
	_boxspawnpos = [0,0];
	
	_collidewith = "all";
	
	image_xscale = global._scale;
	image_yscale = global._scale;
	
	_freeze = 0;
	_trigger = false;
	_trigger_enm = false;
	_triggertimer = 0;
	
	_checkdelete = false;
	
	_flyhigh = false;
	_flyhigh_init = false;
	_flyhigh_act = 0;
	_yspd = 0;
	_height = 0;
	
	_boxonly = false;
	
	_shadowsinit = false;
	_shadowmult = 1;
	
	_deleteshadow = false;
	
	//colors
	_docolors = false;
	
	_maxcolors = global._maxcolors[? "dh"];
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
}