{
	_allsounds = ds_map_create();
	
	_height = 0;
	_groundlevel = 0;
	_dispoffset = [0,0];
	_vspd = 0;
	_shadowsize = 0.46;
	_shadowmult = 0;
	_xscale = 1;
	
	_codename = "";
	
	_sort = true;
	_depthoffset = 0;
	
	_forcedepth = 0;
	
	_rest = false;
	
	_deathtimer = 0;
	_freeze = 0;
	_kill = false;
	
	_colorblend = c_white;
	
	_difftype = false;
	
	//colors
	_maxcolors = 4;
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	//set occupy id
	_occupy_id = "";
	_letr = global._occupyCharset;
	for(var i = 0; i < 7; i++){
		_occupy_id += string_char_at(_letr, round(random_range(1, string_length(_letr))));
	}
	
	_active = true;
	_deadtimer = 0;
	
	_shadowsinit = false;
}