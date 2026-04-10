{
	image_speed = 0;
	visible = false;
	
	_allsounds = ds_map_create();
	
	_tilepos = [0,0];
	_timer = 0;
	_max_timer = 170;
	_subtimer = 0;
	
	_alp = 0;
	_alptimer = 0;
	
	_lode_object = true;
	
	_depth = 0;
	
	_show = true;
	
	_id = "wallgone"+string(irandom(9999));
	
	_tilelayer = -1;
	
	_project = true;
	_deadtimer = 0;
}