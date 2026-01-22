{
	_allsounds = ds_map_create();
	
	_rainsound = false;
	_gain = 0;
	
	_col = make_color_rgb(135, 101, 240);
	_alp = 0.88;
	
	_floorpoint = HEIGHT*0.72;
	
	_rainfloor = instance_create_depth(x,y,0,obj_st2_rain_floor);
	_rainfloor._parentobj = self;
	_rainfloor._col = _col;
	_rainfloor._alp = _alp;
	_rainfloor._floorpoint = _floorpoint;
	
	_rainactive = false;
	
	_start = false;
	_stop = false;
	_stoptimer = 0;
	
	_rainframes = [];
	_curframes = [];
	_curframe = 0;
	_timer = 0;
	
	_maxframes = 6;
	_rainamnt = 100;
	_tint = false;
	
	_init = false;
	
	_curtheme = mus_theme2;
	
	_thundertimer = 100;
	
	_rainstarttimer = 0;
}