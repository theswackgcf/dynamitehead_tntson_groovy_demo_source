{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		if(!global._lode_editor){
			if(_parentobj != noone && instance_exists(_parentobj)){
				x = _parentobj.x;
				y = _parentobj.y;
				
				if(_parentobj._tnt_activation || _parentobj._tnt_power > 0){
					_show = true;
					
					_fire_timer ++;
					switch(_fire_act){
						case 0:
							_fire_spd = 0.2;
							_scalex = 0.43;
							_scaley = 2;
							if(_fire_timer >= 6){
								_fire_timer = 0;
								_fire_act = 1;
							}
						break;
						case 1:
							_fire_spd = 0.12;
							_scalex = 1.5;
							_scaley = 0.76;
							if(_fire_timer >= 30){
								_fire_timer = 0;
								_fire_act = 2;
							}
						break;
						case 2:
							_fire_spd = 0.07;
							_scalex = 0.94;
							_scaley = 1.16;
							if(_fire_timer >= 30){
								_fire_timer = 0;
								_fire_act = 3;
							}
						break;
						case 3:
							_scalex = 1;
							_scaley = 1;
							_sine = true;
							_timer ++;
						break;
					}
				} else {
					_show = false;
					
					_scalex = 0;
					_scaley = 0;
					
					_scalex_lerp = 0;
					_scaley_lerp = 0;
					
					_fire_act = 0;
					_fire_timer = 0;
					_fire_spd = 0.014;
					
					_timer = 0;
					
					_sine = false;
				}
			}
		}
		
		_scalex_lerp = lerp(_scalex_lerp, _scalex, _fire_spd);
		_scaley_lerp = lerp(_scaley_lerp, _scaley, _fire_spd-0.04);
		
		var sine = 0;
		var cosine = 0;
		
		var firescale = 1;
		if(_parentobj != noone && instance_exists(_parentobj)){
			if(_parentobj._tnt_power > 0){
				firescale = _parentobj._tnt_power;
			}
		}
		
		if(_sine){
			sine = sin(_timer/14)*0.17;
			cosine = cos(_timer/14)*0.17;
		}
		
		image_xscale = (_scalex_lerp+sine)*firescale;
		image_yscale = (_scaley_lerp+cosine)*firescale;
		
		scr_lode_overtile();
		
		scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale]);
	} else {
		image_speed = 0;
	}
}