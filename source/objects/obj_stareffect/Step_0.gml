{
	if(!global._pause){
		depth = 2000;
		image_xscale = _scale;
		image_yscale = _scale;
		_scale += 0.1;
		image_angle += 8;
		image_alpha -= 0.01;
		if(image_alpha <= 0.05){
			instance_destroy();
		}
	}
}