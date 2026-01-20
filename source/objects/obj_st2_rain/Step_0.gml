{
	depth = -1800;
	
	y = global._cameraY;
	_rainfloor.y = y;
	
	if(global._checkpoint != noone){
		instance_destroy();
	}
	
	if(!global._pause){
		if(!_init){
			for(var i = 0; i < _maxframes; i++){
				for(var r = 0; r < _rainamnt; r++){
					var offs = 256;
					_rainframes[i][r] = [random_range(-offs,(WIDTH*2.5)+offs),random_range(-offs,HEIGHT+offs)];
				}
			}
			
			_rainfloor._rainframes = _rainframes;
			
			_init = true;
		} else {
			if(_start){
				visible = true;
				if(!_stop){
					global._forceStopMusic = true;
					mus_stop();
				}
				
				if(global._buildver != HTML){
					if(!global._died){
						var startstar = instance_find(obj_startstar,0);
						if(instance_exists(startstar)){
							if(startstar._starscale >= 2){
								_rainsound = true;
							}
						}
					} else {
						_rainsound = true;
					}
				} else {
					if(!global._died){
						_rainstarttimer ++;
						if(_rainstarttimer >= 260){
							_rainsound = true;
						}
					} else {
						_rainsound = true;
					}
				}
				if(_rainsound){
					if(!_tint){
						with(obj_bg){
							_lv2_tint = c_purple;
						}
						_tint = true;
					}
					
					if(!_stop){
						_gain += 0.04;
						if(_gain >= 1){
							_gain = 1;
						}
					}
					
					if(!sfx_isplaying(snd_rain)){
						sfx_play(snd_rain, _gain, true);
					}
					
					//thunder
					if(!_stop){
						_thundertimer ++;
						if(_thundertimer >= random_range(240, 600)){
							_thundertimer = 0;
							with(obj_bg){
								_thunder = true;
								_thunderalp = 1;
								_thundertimer = 0;
							}
							sfx_play_choose([snd_thunder1,snd_thunder2]);
							sfx_pitch(snd_thunder1, random_range(0.6,1.4));
							sfx_pitch(snd_thunder2, random_range(0.6,1.4));
						}
					}
				}
				
				_timer ++;
				if(_timer >= 4){
					if(array_length(_curframes) == 0){
						for(var i = 0; i < _maxframes; i++){
							array_push(_curframes, i);
						}
					}
					var f = irandom_range(0,array_length(_curframes)-1);
					_curframe = _curframes[f];
					array_delete(_curframes,f,1);
				
					_timer = 0;
				}
				
				if(_stop){
					_gain -= 0.012;
					if(_gain <= 0){
						_gain = 0;
					}
					_stoptimer += 1.5;
					if(_stoptimer >= _rainamnt+45){
						with(obj_music){
							global._forceStopMusic = false;
							if(!audio_is_playing(other._curtheme)){
								mus_play(other._curtheme, 0.8);
							}
						}
						
						sfx_stop(snd_rain);
						
						instance_destroy(_rainfloor.id);
						instance_destroy();
					}
				}
			} else {
				visible = false;
			}
		}
	}
}