{
	_createtype = 0;
	
	_spd = [0,0];
	_spd[0] = random_range(-4, 4);
	_spd[1] = random_range(2, 4);
	_xscale = 1;
	_height = floor(HEIGHT/2);
	_type = round(random_range(0,3));

	_angle = 0;
	
	_sort = true;
	_depthoffset = 48;
	_forcedepth = 0;
	
	_setscale = false;
	_scalemult = 1;
	
	_rot2 = choose(-32,32);
	_bump = false;
	_fell = false;
}