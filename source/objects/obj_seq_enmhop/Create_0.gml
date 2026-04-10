{
	_timer = 0;
	
	_parentobj = noone;
	
	_codename = "";
	_enmtypes = [];
	_enmtype = -1;
	
	_dir = 1;
	_xscale = _dir;
	_yscale = 1;
	image_xscale = _xscale;
	image_yscale = _yscale;
	
	_sort = true;
	_depthoffset = 0;
	
	_forcedepth = 0;
	
	_sequence_id = 0;
	
	_seqhop_archeight = 0;
	_seqhop_spd = 0;
	
	_hop_startpos = [x,y];
	_jumptopos = [x,y];
	_hop_base_y = y;
	_hop_arcstart = false;
	_hop_time = 0;
	_hop_arc = 0;
	
	_walking = false;
	
	_depth = 0;
	
	_colorsinit = false;
	_rep = "";
	
	_docolors = false;
	
	//start fade
	_startFade = false;
	_fadeInit = false;
	_doFade = false;
	_fadeCol = [255,255,255];
	_fadeTo = [255,255,255];
	
	//colors
	_maxcolors = 1;
		
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
}