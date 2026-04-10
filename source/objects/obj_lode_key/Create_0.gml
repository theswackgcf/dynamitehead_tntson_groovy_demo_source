{
	_lode_object = true;
	
	_sintimer = random(1000);
	_depth = 0;
	
	_show = false;
	
	_id = "";
	
	_tilepos = [0,0];
	_tilelayer = -1;

	_project = true;
	_deadtimer = 0;
	
	_sparkles = noone;
	_disppos = [x,y];
	_sparklesoffset = [0,0];
	
	_collectable_timer = 1;
	
	_followobj = noone;
	_depth_type = false;
	_reset_depth = false;
	
	x += sprite_width*0.5;
	y += sprite_height*0.5;
	
	visible = false;
}