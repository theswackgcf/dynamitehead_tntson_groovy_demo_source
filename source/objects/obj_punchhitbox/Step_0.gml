{
	depth = -9000;
	if(!global._pause){
		_destroy_timer ++;
		
		if(_parentobj != noone && instance_exists(_parentobj)){
			if(_parentdir){
				_curdir = _parentobj._curdir;
			}
			
			if(_frame > 0 && !_frame_active){
				_delay = 2;
			}
			if(instance_exists(_parentobj._displayobj)){
				if((_parentobj._displayobj).image_index >= _frame){
					_frame_active = true;
				}
			}
			
			if(_delay > 0){
				image_blend = #555555;
				_delay --;
			} else {
				if(_frame_active){
					image_blend = c_white;
				}
			}
			
			image_xscale = _scale[0];
			image_yscale = _scale[1];
			var folpos = [_parentobj.x,_parentobj.y];
			if(_forcefollow){
				folpos = [_forcefollow_pos[0],_forcefollow_pos[1]];
			}
			x = folpos[0] + (_offset[0]*_curdir);
			y = (folpos[1] + _offset[1]) - _parentobj._height;
			if(variable_instance_exists(_parentobj.id, "_behaviortype")){
				if(_parentobj._behaviortype == "hopping"){
					_active = true;
					_height = -_parentobj._hop_arc;
				}
			}
		
			//delete after time runs out
			if(!_timerignore && _delay <= 0){
				_timer -= _parentobj._speed;
			}
			if(_timer <= 0){
				if(_ptype == "enm" && !_success){
					_parentobj._curatk = 0;
					_parentobj._interest = 0;
					_parentobj._forceattack = 0;
				}
				instance_destroy();
			}
			
			if(variable_instance_exists(_parentobj.id, "_state")){
				//some get deleted when states dont match
				if(_type == "slide"){
					if(_parentobj._slidetimer <= 16){
						_active = false;
					} else {
						_active = true;
					}
				}
				if(_destroy_timer >= 4){
					if(_type == "slide" && !_parentobj._runroll_slide){
						instance_destroy();
					}
					if(_type == "roll" && (_parentobj._state != "roll" || abs(_parentobj._rollspd) <= 10) || _parentobj._runroll_dive){
						instance_destroy();
					}
					if(_type == "air" && (_parentobj._state != "jump" || _parentobj._nojump > 0)){
						instance_destroy();
					}
				}
				
				if(_type == "air"){
					if(abs(_parentobj._rollspd) > 0){
						_damage = ATK_KO;
					} else {
						if(_parentobj._jumpreach >= _parentobj._mingroundko){
							_damage = ATK_KO;
						} else {
							_damage = ATK_NORM;
						}
					}
				}
			}
			
			if(variable_instance_exists(_parentobj.id, "_curstate")){
				//parent object is a skull
				if(_parentobj._death){
					instance_destroy();
				}
				
				if(_parentobj._shockwave > 0 || _parentobj._mashed){
					instance_destroy();
				}
				
				if(_type == "slide_enm" && (_parentobj._curstate != STATE_SLIDE || _parentobj._falling || _parentobj._fall_ko)){
					instance_destroy();
				}
				if((_type == "crouch_enm" || _type == "crouch_enm_henchie") && _parentobj._curstate == STATE_JUMP){
					instance_destroy();
				}
				if(_type == "crouch_enm_henchie" && _parentobj._anim != "crouchkick"){
					instance_destroy();
				}
				if(_type == "air_enm" && _parentobj._height <= _parentobj._groundlevel && _parentobj._curstate != STATE_JUMP){
					instance_destroy();
				}
				if(_type == "run_enm" && (!_parentobj._attack || abs(_parentobj._slidespd) <= 1)){
					instance_destroy();
				}
				if(_type == "blockko_enm" && _parentobj._anim != "blockko"){
					instance_destroy();
				}
				if(_delay <= 0 && _type == "lowkick_enm" && _parentobj._anim != "lowkick"){
					instance_destroy();
				}
				
				if(_type == "spin_enm"){
					_active = true;
					_height = _parentobj._height+25;
					if(_parentobj._enmtype == 1){
						_height = _parentobj._height-32;
					}
					if(!_parentobj._spin){
						instance_destroy();
					}
				}
			}
			
			//prevent draining the entire shield in a single frame
			if(!_shielded){
				_shieldt = 0;
			}
			if(_ptype == "enm" || _ptype == "all"){
				if(_shielded && !place_meeting(x,y,obj_dh_hurtbox)){
					_shieldt ++;
				}
			}
			if(_shieldt >= 8){
				_shielded = false;
			}
		}
		if(!instance_exists(_parentobj)){
			instance_destroy();
		}
	}
	
	if(global._debug){
		if(global._showHitbox){
			visible = true;
		} else {
			visible = false;
		}
	}
}
