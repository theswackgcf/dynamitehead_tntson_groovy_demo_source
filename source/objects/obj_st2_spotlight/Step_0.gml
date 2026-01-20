{
	if(!global._pause){
		_spottimer ++;
		if(_spottimer >= 3){
			_spotframe ++;
			if(_spotframe > 1){
				_spotframe = 0;
			}
			_spottimer = 0;
		}
		
		_timer --;
		
		if(_timer <= 15){
			_alpha -= 0.15;
			if(_alpha <= 0){
				_alpha = 0;
			}
		}
		
		if(_timer <= 0){
			instance_destroy();
		}
	}
}