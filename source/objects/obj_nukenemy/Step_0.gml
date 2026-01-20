{
	depth = 9994;
	if(!global._pause){
		x += _spd[0];
		y += _spd[1];
		
		if(_spd[0] < 0){
			image_xscale = -1;
		} else {
			image_xscale = 1;
		}
		
		if(y <= -320){
			instance_destroy();
		}
	}
}