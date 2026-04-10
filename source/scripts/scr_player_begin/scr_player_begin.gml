function scr_player_begin(){
	if(instance_number(obj_stageentrance) != 0){
		//no checkpoint start
		if(!_begin && _begintimer < 5){
			with(obj_fade){
				_fadefgTo = 1;
			}
		}
		if(!_begin && !global._stageentrance){
			_begintimer ++;
			if(_begintimer >= 15){
				if(!_beginstar){
					with(obj_startstar){
						_forcedepth = other._displayobj.depth+2;
						_draw = true;
					}
					with(obj_fade){
						_fadefgTo = 0;
						_fadeTo = 0;
						_fadeSpd = 0.08;
					}
					sfx_play(snd_starentrance);
							
					_beginstar = true;
				}
			}
			if(_begintimer >= 50){
				with(obj_fade){
					_fadefgTo = 0;
					_fadeSpd = 0.08;
				}
			}
			if(_begintimer >= 70){
				_begintimer = 0;
				_state = "default";
				_begin = true;
				with(_displayobj){
					_forcedepth = 0;
				}
					
				with(obj_fade){
					_mode = 0;
				}
					
				with(obj_music){
					_musicstart = true;
				}
			} else {
				_hptimer = 25;
				with(obj_gui){
					ui_fade("dh", 0);
					ui_fade("tnt", 0);
				}
			}
		}
		if(_begin){
			_begintimer ++;
			if(_begintimer < 10){
				with(obj_gui){
					ui_fade("dh", 1);
					ui_fade("tnt", 1);
				}
			}
		}
	} else {
		if(!_begin){
			//checkpoint start
			_hptimer = 0;
			with(obj_gui){
				ui_fade("dh", 1);
				ui_fade("tnt", 1);
			}
			_state = "default";
			with(_displayobj){
				_forcedepth = 0;
			}
			_begin = true;
		}
	}
}