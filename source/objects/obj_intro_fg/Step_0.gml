{
	depth = -1000;
	
	image_xscale = _scale;
	image_yscale = _scale;
	
	x -= _fgspd;
	y = HEIGHT;
	if(x <= -(WIDTH*1.5)){
		instance_destroy();
	}
}
