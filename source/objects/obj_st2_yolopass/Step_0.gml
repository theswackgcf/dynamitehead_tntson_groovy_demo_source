{
	if(!global._pause){
		if(!_delete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					instance_destroy();
				}
			}
			_delete = true;
		}
		
		_alphato = 1;
		if(_dissaptimer > 0){
			_alphato = 0;
			_dissaptimer--;
		}
		
		image_alpha = lerp(image_alpha, _alphato, 0.04);
		
		visible = !_trigger;
		
		if(_trigger){
			_deadtimer ++;
			if(!sfx_isplaying(snd_secret) || _deadtimer >= 300){
				global._deletedStuff[? self.id] = 1;
				instance_destroy();
			}
		}
	}
}