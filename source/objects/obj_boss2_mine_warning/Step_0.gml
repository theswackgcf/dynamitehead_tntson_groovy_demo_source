{
	if(!global._pause){
		image_speed = 1;
		
		if(_parentobj != noone && instance_exists(_parentobj)){
			x = _parentobj.x;
		}
		
		if(floor(image_index) == 0){
			if(!_snd){
				sfx_play_proximity(snd_warning);
				
				_snd = true;
			}
		}
		if(floor(image_index) == 1){
			_snd = false;
		}
		
		_timer ++;
		if(_timer >= 120){
			instance_destroy();
		}
	} else {
		image_speed = 0;
	}
}