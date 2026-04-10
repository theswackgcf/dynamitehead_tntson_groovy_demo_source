{
	depth = -10000;
	
	_starttimer = 0;
	_startval = 6;
	_drawnorm = false;
	_drawnorm_alp = 1;
	
	_allsounds = ds_map_create();
	
	_timer = 0;
	_act = 0;
	
	
	_ripped = false;
	
	_poster = true;
	_poster_scaleup = 0;
	_poster_scaleup_bool = false;
	
	_showbg = true;
	
	_posterframe = 0;
	_postertimer = 0;
	_postershow = true;
	_posterscale = 0.85;
	
	_handframe = 0;
	_handtimer = 0;
	_handshow = false;
	
	_dynamiteframe = 0;
	_dynamitetimer = 0;
	_dynamiteshow = false;
	
	_offset = 0;
	_xpos = _offset;
	_ypos = HEIGHT+_offset;
	
	_yvel = 0;
	_grav = 0.9;
	
	_scale = 5;
	
	_dhoffset = [-220,-48];
	_setdir = false;
	_dir = DIR_R;
	
	_end_anim = false;
	
	//colors
	_maxcolors = global._maxcolors[? "dh"];
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	_colorsinit = false;
	_rep = "";
}