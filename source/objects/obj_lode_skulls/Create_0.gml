{
	_lode_object = true;
	
	_depth = 0;
	
	_show = false;
	_show_timer = 0;
	_show_particle = false;
	_active = true;
	
	_id = "";
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_project = true;
	_deadtimer = 0;
	
	_boss_show = false;
	
	x += sprite_width*0.5;
	y += sprite_height*0.5;
	
	image_speed = 0;
	
	random_set_seed(x+y);
	image_index = irandom(image_number-1);
	image_xscale = choose(-1,1);
	randomize();
	
	visible = false;
}