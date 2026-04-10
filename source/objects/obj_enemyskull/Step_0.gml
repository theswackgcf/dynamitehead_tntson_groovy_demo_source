{
	if(!global._pause){
		if(_active){
			if(_height > _groundlevel){
				_height += _vspd;
				_vspd -= (0.8*global._gravmult);
			} else {
				_rest = true;
				_vspd = 0;
			}
		
			//getting hit by player
			if(_freeze <= 0 && _height <= _groundlevel && _deathtimer >= 4 && _rest && !_kill){
				if(place_meeting(x, y, obj_punchhitbox)){
					var atk_obj = instance_place(x, y, obj_punchhitbox);
					if(atk_obj._delay > 0) return;
					var atk_parent = atk_obj._parentobj;
					if(instance_exists(atk_obj) && instance_exists(atk_parent)){
						//check blind zone
						if(atk_obj._damage == ATK_KO && atk_obj._ptype == "pl" && (atk_obj._type == "crouch" || atk_obj._type == "slide")){
							sfx_play_proximity(snd_punchmute, 0.9);
							
							var p = instance_create_depth(x-24,y-96,depth-16,obj_particle);
							p._type = "fx6";
							
							with(obj_camera){
								_ampX = 5;
							}
							
							atk_parent._freeze = global._freezeFrames.mid_freeze-4;
							_freeze = global._freezeFrames.mid_freeze-4;
							global._hits += 1;
							global._hitmeter = 50;
							
							global._pad_vibrate = 4;
							
							_kill = true;
						}
					}
				}
			}
		
			//disappear after some time
			if(_freeze <= 0){
				_deathtimer ++;
				if(_deathtimer >= 280 || _kill){
					var p = instance_create_depth(x-46,y-46,depth-1,obj_particle);
					p._type = "vanish";
					if(_kill){
						sfx_play(snd_skullcrack);
					}
				
					_active = false;
				}
			} else {
				_freeze -= 1;
			}
		} else {
			_deadtimer ++;
			if(!sfx_isplaying(snd_skullcrack) || _deadtimer >= 160){
				instance_destroy();
			}
		}
	}
}