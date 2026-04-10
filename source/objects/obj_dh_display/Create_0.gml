{
	_parentobj = noone;
	_offset = [0,42];
	_xscale = 1;
	_yscale = 1;
	_scale = 1;
	_height = 0;
	_groundlevel = 0;
	_beginoffset = [0,0];
	_grav = true;
	_beginspd = [0,0];
	_starty = y;
	
	_starttime = 0;
	_startsurf = false;
	_startdir = DIR_R;
	_startsfx = false;
	_startvoice = false;
	
	_allsounds = ds_map_create();
	
	_shadowoffset = [0,0];
	_shadowlerp = [0,0]
	
	_ampX = 0;
	_ampY = 0;
	_shakeOffset = [0,0];
	
	_sort = true;
	
	_newdepth = 0;
	
	_shadowmult = 1;
	
	_rep = "";
	_colorsinit = false;
	
	_outline_dist = 0;
	_outline_idle = false;
	_outline_alp = 0;
	_outline_alpto = _outline_alp;
	_outline_col = c_white;
	_outline_timer = 0;
	_outline_maxtimer = 100;
	
	//colors
	_maxcolors = global._maxcolors[? "dh"];
	
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
	
	_shadowsinit = false;
}