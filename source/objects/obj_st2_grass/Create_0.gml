{
	_inview = false;
	
	_sort = true;
	_depthoffset = 0;
	
	_timer = random(1000);
	_windoffset = [0,0];
	_windAmp = 6;
	_windSpd = random_range(0.07,0.12);
	_midpoint = 0.5;
	
	_colfade = c_white;
	
	_index = irandom_range(0,1);
	
	_surf = surface_create(sprite_width*1.5,sprite_height*1.5);
}