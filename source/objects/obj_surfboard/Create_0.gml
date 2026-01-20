{
	_timer = 0;
	_allsounds = ds_map_create();
	_curdir = DIR_R;
	_xvel = 0;
	_yvel = 0;
	
	if(global._tutorial){
		image_index = 1;
	}
}