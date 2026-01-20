{
	_inview = false;
	
	depth = -5000;
	_startangle = image_angle;
	_timer = 0;
	_spd = random_range(0.04,0.11);
	image_index = irandom_range(0,sprite_get_info(sprite_index).num_subimages-1);
}