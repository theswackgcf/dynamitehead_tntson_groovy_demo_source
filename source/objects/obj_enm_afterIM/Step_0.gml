{
	if(!global._pause){
		if(!_init){
			_init = true;
		} else {
			x += _xspd;
			y += _yspd;
			
			image_alpha = _alpha;
			_alpha -= _decaytime;
			if(_alpha <= 0){
				instance_destroy();
			}
		}
	}
}