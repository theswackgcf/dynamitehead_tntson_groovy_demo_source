{
	if(!global._pause){
		if(!_init){
			_init = true;
		} else {
			image_alpha = _alpha;
			_alpha -= _decaytime;
			if(_alpha <= 0){
				instance_destroy();
			}
		}
	}
}