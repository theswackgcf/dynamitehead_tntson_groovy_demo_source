{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._minigame_nopause){
		global._minigame_nopause = true;
	}
	
	if(!global._pause && !global._gameover_stopall){
		image_speed = global._lode_spd;

		x += (_xspd*_spd)*_curdir;
		y += _yspd*_spd;
		_yspd += _grav;
		var changescale = 0.08*_spd;
		image_xscale += changescale;
		image_yscale += changescale;
		
		_deadtimer += global._lode_spd;
		if(_deadtimer >= 60){
			if(global._lode_lives > 0){
				if(!_transition){
					with(obj_mg_lode){
						_tr_draw = true;
						_tr_type = "out";
						_tr_alp = 0;
					}
					_transition = true;
				}
			} else {
				with(obj_mg_lode){
					if(!_gameover){
						_mus_spd = 1;
						_gameover = true;
					}
				}
			}
		}
		
		scr_lode_overtile();
		
		scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale],_depth);
	} else {
		image_speed = 0;
	}
}