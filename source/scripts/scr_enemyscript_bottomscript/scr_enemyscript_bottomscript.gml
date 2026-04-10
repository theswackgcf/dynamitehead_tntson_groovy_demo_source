function scr_enemyscript_bottomscript(){
	//getting parried
	if(_codename != "boss2"){
		if(_successparry > 0){
			_curstate = STATE_IDLE;
			_docrouchkick = 0;
			_curspd = [0,0];
			clearpath();
			_attack = false;
			_attacktype = "";
			_did_ko = 0;
			if(_successparry % 10 == 0){
				_parryframe = irandom(_mashhurt_max-1);
			}
			if(!_death){
				if(_height > _groundlevel){
					_anim = "fall"
				} else {
					_anim = "mashhurt";
				}
			}
			if(_falling && _vspd < 0 && _height <= _groundlevel+12){
				if(_falls == 0){
					_height = _groundlevel+13;
				} else {
					_falling = false;
					_fall_ko = false;
					_standup = false;
					_vspd = 0;
					_height = _groundlevel;
				}
			}
			if(_standup){
				_standup = false;
				_height = _groundlevel;
			}
			_displayobj.image_index = _parryframe;
			_successparry --;
		}
	}
	
	if(_grabfall || _grabout){
		_freeze = 0;
	}
	
	if(_nockatk == 1){
		if(_anim == "idle" || _anim == "walk" || _anim == "follow" || _anim == "backoff" || _anim == "block"){
			if(_nockanim != ""){
				var sprite_ = asset_get_index("spr_"+string(_codename)+"_"+_nockanim);
				if(sprite_exists(sprite_)){
					_displayobj.sprite_index = sprite_;
				}
			}
			_displayobj.image_index = _nockframe;
			_nockatk = 2;
		} else {
			_nockatk = 0;
		}
	}
	if(_nockatk == 2){
		if(_displayobj.image_index >= _displayobj.image_number-1){
			_anim = "idle";
			_nockatk = 0;
		}
	}
	
	//freeze
	if(_freeze > 0){
		_speed = 0;
		_freeze -= 1;
	} else if(_freeze < 0){
		_freeze = 0;
	}
	if(_freeze == 0 && _speed == 0){
		_speed = 1;
	}
	
	if(_force_freeze > 0){
		_freeze = _force_freeze;
		_force_freeze --;
	}
}