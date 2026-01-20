{
	_init = false;
	
	_charw = [54,46,47,53,54,58,67,23,59,62]; // << c,h,e,c,k,p,o,i,n,t
	_offsetl = [0,0,0,0,0,0,-7,-24,23,7]; // << c,h,e,c,k,p,o,i,n,t
	_totalw = 0;
	_spacing = 7;
	
	_droptimer = 55;
	
	_grav = 0.45;
	
	x += random_range(-24,24);
	y += random_range(-24,24);
	
	_yvel = -8.8;
	_boxy = y;
	
	_alpha = 1;
	_timer = 0;
	visible = false;
	
	image_xscale = 2.4;
	image_yscale = 2.4;
	depth = -(9900+instance_number(obj_nums));
	
	_numstring = "";
	_nummap = ds_map_create();
	_amp = 12;
	_shakeoff = [0,0];
	_addoffset = 0;
	_drawback = true;
}