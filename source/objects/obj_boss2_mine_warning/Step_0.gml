{
	if(!global._pause){
		image_speed = 1*_increase_mult;
		
		if(_increase){
			_increase_mult += _increase_mult_amnt;
		}
		
		if(_parentobj != noone && instance_exists(_parentobj)){
			if(!_lerp){
				x = _parentobj.x;
				if(_do_y){
					y = _parentobj.y;
				}
			} else {
				x = lerp(x,_parentobj.x,_lerp_amnt);
				if(_do_y){
					y = lerp(y,_parentobj.y,_lerp_amnt);
				}
			}
		}
		
		if(floor(image_index) == 0){
			if(!_snd){
				sfx_play_proximity(snd_warning);
				if(_timer >= _maxtimer-20){
					sfx_pitch(snd_warning,1.5);
				}
				
				_snd = true;
			}
		}
		if(floor(image_index) == 1){
			_snd = false;
		}
		
		_timer ++;
		
		if(_timer >= 2){
			visible = true;
		}
		
		if(_timer >= _maxtimer){
			instance_destroy();
		}
	} else {
		image_speed = 0;
	}
}