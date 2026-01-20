{
	depth = -9999;
	if(!global._pause){
		_scale -= 0.12;
		image_xscale = _scale;
		image_yscale = _scale;
		if(_scale <= 1){
			_scale = 1;
			instance_destroy();
		}
	}
}