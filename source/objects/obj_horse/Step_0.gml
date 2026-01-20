{
	if(!global._pause){
		if(_appear){
			if(!_trigger){
				if(place_meeting(x, y, obj_dh_mask)){
					sfx_play(snd_horse);
					global._horse = true;
					_trigger = true;
				}
			} else {
				_yoffset -= 2;
				_alpha -= 0.06;
				if(_alpha <= 0){
					_alpha = 0;
				}
			}
		} else {
			if(global._horse){
				instance_destroy();
			}
		}
	}
}
