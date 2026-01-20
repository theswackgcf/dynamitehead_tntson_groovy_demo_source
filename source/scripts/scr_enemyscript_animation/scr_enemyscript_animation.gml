function scr_enemyscript_animation(type){
	if(type == "step"){
		//animation
		if(!_slam){
			_animspeed = 1;
		}
		_walk_animspeed = max(abs(sqrt_value(_curspd[0],_curspd[1]))/5,0.3);
				
		if(_codename != "boss2"){
			function walk(){
				if(_curspd[0] == 0 && _curspd[1] == 0){
					_idletimer ++;
					if(_idletimer >= 12){
						_anim_prev = _anim;
						if(!_boss){
							_anim = "idle";
						} else {
							_anim = "idle"+string(_phase+1);
						}
					}
				} else {
					_idletimer = 0;
					_anim_prev = _anim;
					if(!_boss){
						_anim = "walk";
					} else {
						_anim = "walk"+string(_phase+1);
					}
					if(_curstate == STATE_FOLLOW && has_trait(TRAIT_SPOT)){
						_anim = "follow";
					}
					if(has_trait(TRAIT_BACKOFF) && _backoff > 0){
						_anim = "back";
					}
					if(_panictimer > 0){
						_anim = "back";
					}
					_animspeed = _walk_animspeed;
					if(variable_instance_exists(self.id, "_docrouchkick")){
						_docrouchkick = false;
					}
				}
			}	
		}
		
		//animation loops
		if(_displayobj != noone && instance_exists(_displayobj)){
			if(_displayobj.image_index >= _displayobj.image_number-1){
				if(ds_map_exists(_animloop, _anim)){
					_displayobj.image_index = _animloop[? _anim];
				}
			}
		}
	}
	if(type == "endstep"){
		if(_mashed){
			_anim_transition = false;
			
			if(_hurttimer > 0){
				_anim_prev = _anim;
				_anim = "mashhurt";
				_displayobj.image_index = _mashhurt;
			} else {
				_anim_prev = _anim;
				_anim = "shockwave";
			}
		}
		
		//animations
		_displayobj.sprite_index = asset_get_index("spr_"+string(_codename)+"_"+_anim);
		if(_freeze <= 0){
			_displayobj.image_speed = _animspeed;
			if(_force_animspeed_timer > 0){
				_displayobj.image_speed = _force_animspeed;
				_force_animspeed_timer --;
			}
		} else {
			_displayobj.image_speed = 0;
		}
	}
}