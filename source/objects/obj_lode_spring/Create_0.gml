{
	_allsounds = ds_map_create();
	
	_lode_object = true;
	
	image_speed = 0;
	visible = false;
	
	_trigger = false;
	_launch = false;
	
	_jump_power = 4; //blocks
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_pitch = 0;
	_index_timer = 0;
	_prev_index = 0;
	
	_show = true;
	
	_depth = 0;
}