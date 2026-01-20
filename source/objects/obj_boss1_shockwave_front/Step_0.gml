{
	if(!global._pause){
		_timer ++;
		_shtime ++;
		if(_shtime % 4 == 0){
			_shframe ++;
			if(_shframe >= 2){
				_shframe = 0;
			}
		}
		_scale += 0.03;
		if(_scale >= 0.9){
			_alp -= 0.03;
		}
		if(_alp <= 0){
			with(_shockback){
				instance_destroy();
			}
			instance_destroy();
		}
		
		if(!sfx_isplaying(snd_zapattack)){
			sfx_play(snd_zapattack);
		}
		
		image_xscale = _scale;
		image_yscale = _scale;
	}
	depth = -5000;
}