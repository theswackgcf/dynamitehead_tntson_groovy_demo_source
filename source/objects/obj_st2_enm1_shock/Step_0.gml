{
	if(!global._pause){
		image_speed = 1;
		
		_scale += 0.32;
		_alpha -= 0.15;
		
		image_xscale = _scale;
		image_yscale = _scale;
		image_alpha = _alpha;
		
		if(_alpha <= 0){
			instance_destroy();
		}
	} else {
		image_speed = 0;
	}
}