function scr_lode_enm_animation(){
	image_xscale = _curdir;
	_animspeed = 1;
		
	//animations
	if(_anim_transition){
		switch(_anim_tr_anim){
			case "climb_in":
				_anim = "climb_in";
			break;
			case "fall_idle":
				_anim = "fall_idle";
			break;
		}
			
		if(image_index >= image_number-1){
			image_index = 0;
			_anim_tr_anim = "";
			_anim_transition = false;
		}
	} else {
		switch(_state){
			case LODE_STATE_DEFAULT:
				if(_groundtimer > 0){
					if(abs(_xspd) < _movespd){
						_anim_prev = _anim;
						_anim = "idle";
					} else {
						_anim_prev = _anim;
						_anim = "walk";
					}
				} else {
					_anim_prev = _anim;
					_anim = "fall";
				}
			break;
			case LODE_STATE_LADDER:
			case LODE_STATE_ROPE:
				_anim_prev = _anim;
				if(place_meeting(x,y,obj_lode_rope)){
					_anim = "rope";
				}
				if(place_meeting(x,y,obj_lode_ladder)){
					if(_yspd != 0){
						_anim = "climb";
					}
				}
						
				_animspeed = 0;
				if(_moving){
					_animspeed = 1;
				}
			break;
		}
		
		if(_getup_timer > 0){
			_getup_timer --;
		}
		
		if(_getup){
			_getup_timer = 32;
			
			if(!_getup_same_y){
				_anim_prev = _anim;
				_anim = "pit";
				
				_getup_index += 0.2;
				
				image_index = _getup_index;
				if(image_index >= image_number-1){
					_getup_index = 0;
					x = _getup_pos[0];
					y = _getup_pos[1];
					_curdir = _getup_dir;
					_getup = false;
				}
			} else {
				_anim_prev = _anim;
				_anim = "walk";
				
				if(diff_abs(_disppos[0],_getup_pos[0])<=_movespd){
					_is_stuck = true;
					_getup = false;
					_getup_same_y = false;
				} else {
					x = _getup_pos[0];
					_disppos[0] = lerp(_disppos[0],_getup_pos[0],0.12);
				}
			}
		}
		if(_taunt){
			_anim_prev = _anim;
			_anim = "taunt";
			if(!_tauntsnd){
				if(_snd.taunt != -1){
					sfx_play(_snd.taunt);
				}
				_tauntsnd = true;
			}
		}
		
		if(compare_anim("fall","rope")){
			image_index = 0;
			_anim_tr_anim = "rope_in";
			_anim_transition = true;
			_anim_prev = _anim;
		}
		if(compare_anim("fall","idle") || compare_anim("fall","walk") || compare_anim("climb","idle") || compare_anim("climb","walk")){
			image_index = 0;
			_anim_tr_anim = "fall_idle";
			_anim_transition = true;
			_anim_prev = _anim;
		}
	}
		
	var spr = asset_get_index("spr_lode_"+_codename+"_"+_anim);
	if(sprite_exists(spr)){
		sprite_index = spr;
	}
	image_speed = _animspeed*global._lode_spd;
}