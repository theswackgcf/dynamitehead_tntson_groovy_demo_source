function scr_player_movement_other(){
	//height
	if(_jump){
		if(_height < _groundlevel){
			_preservespd = 0;
			if(_jumpback){
				_deadtimer = 0;
				_dead = false;
				_jumpback = false;
			}
			_vspd = 0;
			_height = _groundlevel;
			_prevstate = _state;
			if(_state != "win"){
				_state = "default";
			}
			_jump = false;
					
			sfx_play_choose([asset_get_index("snd_land1_"+_floortype),asset_get_index("snd_land2_"+_floortype)]);
		}
		if(_hurtTimer <= 0){
			_spd[0] += _preservespd*_curdir;
			_preservespd = lerp(_preservespd, 0, 0.02);
			_spd[0] = clamp(_spd[0],-_maxspd[0]-5,_maxspd[0]+5);
		}
		_crouch = false;
		_height += _vspd * _speed;
		_vspd -= 0.8 * _speed;
	} else {
		if(!_slide){
			_slide_sfx = false;
			_preservespd = 0;
		}
		if(_jumpback){
			_jumpback = false;
		}
	}
	
	//sliding
	if(_slide){
		_slidetimer ++;
		_slidedecel -= 0.02;
		if(_slidetimer >= 3 && !_slide_sfx){
			sfx_play(snd_slide);
			_slide_sfx = true;
		}
		if(_slidetimer < 48){
			_spd[0] = _slidespd*_slidedecel;
		}
		if(_slidetimer >= 10){
			_preservespd = clamp(abs(_spd[0]),0,_maxspd[0]);
		} else {
			_preservespd = 2;
		}
		
		if(place_meeting(x,y,obj_slidespot)){
			var s_num = 16;
			if(abs(_spd[0]) <= s_num){
				if(_spd[0] < 0){
					_spd[0] = -s_num;
				} else {
					_spd[0] = s_num;
				}
			}
		}
		
		if(!place_meeting(x,y,obj_slidespot)){
			if(_crouch && (abs(_spd[0]) < 0.4 || _walltouch[0] > 0)){
				_prevstate = _state;
				_state = "crouch";
				_slide = false;
				_runslide = false;
			}
			if(!_crouch && (abs(_spd[0]) < 0.4 || _walltouch[0] > 0)){
				_prevstate = _state;
				_state = "default";
				_slide = false;
				_runslide = false;
			}
		}
		if(_jump){
			_slide = false;
		}
	} else {
		_slidetimer = 0;
		_slidedecel = _slidedecel_max;
		
		if(_runroll && place_meeting(x,y,obj_slidespot)){
			var rolls = 8;
			if(_rollspd < 0 && _rollspd >= -rolls){
				_runroll = true;
				_rollspd = -rolls;
			}
			if(_rollspd > 0 && _rollspd <= rolls){
				_runroll = true;
				_rollspd = rolls;
			}
		}
	}
	
	//acceleration / deceleration
	_stopspd = false;
	if(_crouch){
		_decel = 0.78;
		_stopspd = true;
	}
	if(_slide){
		_accel = 1;
		_decel = 0.8;
		_stopspd = true;
	}
	if(_nojump > 0){
		_stopspd = true;
	}
	if(_attack){
		_stopwalk = 3;
		if(_attacktype != "air"){
			_accel = 1;
			_decel = 0.7;
			_stopspd = true;
		}
	}
	if(_state == "default" || _state == "jump"){
		if(!_jump){
			_accel = 1;
			_decel = 0;
		} else {
			_accel = 0.5;
			if(_prevstate != "slide"){
				_decel = 0.8;
			} else {
				_decel = 1;
			}
		}
	}
	if(_running || _skidtimer > 0){
		_accel = 0.5;
		_decel = 0.2;
	}
	
	if(_shield){
		_attack = false;
		_state = "shield";
		if(_height <= _groundlevel){
			_stopspd = true;
			_decel = 0.1;
		}
		_stopwalk = 3;
		_jumpjuice = 0;
		if(_vspd > 0){
			_vspd = 0;
		}
	} else {
		if(_state == "shield"){
			_state = "default";
		}
	}
	
	if(_stunnedtimer > 0){
		_spd = [0,0];
		if((_height <= _groundlevel && !_falling) || _jumpback){
			_state = "nomove";
		}
	} else {
		_shakeoff = false;
		if(_state == "nomove"){
			_state = "default";
		}
	}
		
	if(_stopspd){
		_spd[0] *= _decel;
		_spd[1] *= _decel;
	}
	
	//run roll
	if(_runroll){
		_prevstate = _state;
		_state = "roll";
		
		_attack = false;
		_jumpjuice = 0;
		
		_stopspd = true;
		
		if(!_runroll_dive && !_runroll_slide){
			var subroll = 0.045;
			if(_curdir == DIR_R){
				if(_rollspd > 0){
					_rollspd -= subroll;
				}
				if(_rollspd <= 6){
					_runroll = false;
				}
			} else if(_curdir == DIR_L){
				if(_rollspd < 0){
					_rollspd += subroll;
				}
				if(_rollspd >= -6){
					_runroll = false;
				}
			}
		}
		
		_maxspd[0] = _rollspd;
		_spd[0] = _rollspd;
		
		if(_height <= _groundlevel && _runhops == 0){
			with(obj_camera){
				_ampY = 8;
			}
			var pos = 90;
			var partc = instance_create_depth((x-170)+pos, y, 0, obj_particle);
			partc._type = "fx5";
					
			sfx_play_choose_proximity([snd_thud,snd_thud2,snd_thud3,snd_thud4]);
			
			if(!_runroll_dive){
				_vspd = 5;
				_runhops = 1;
			}
			
			global._pad_vibrate = 8;
		}
		
		if(_height <= _groundlevel && _runroll_dive){	
			//slide
			if(!place_meeting(x + 16*abs(_spd[0]), y, obj_solid)){
				_crouch = true;
				_slide = true;
				_spd[0] = _maxspd[0]/1.5;
				_slidespd = _spd[0];
				_curdir_prev = _curdir;
				if(_slidespd > 0){
					_curdir = DIR_R;
				} else if(_slidespd < 0){
					_curdir = DIR_L;
				}
				_prevstate = _state;
				_state = "slide";
							
				_jump = false;
				_runroll_slide = true;
			}
			
			_runroll = false;
			_runroll_dive = false;
		}
		
		//wall bump
		if(_walltouch[0] > 0 || _slidetouch > 0){
			_curdir *= -1;
			
			var partc = instance_create_depth(_displayobj.x, _displayobj.y-96, 0, obj_particle);
			partc._type = "fx6";
				
			with(obj_camera){
				_ampX = 20;
			}
					
			sfx_play_choose([snd_wallslam,snd_wallslam2,snd_wallslam3]);

			_state = "default";

			_spd = [0,0];
			_runroll = false;
			_runroll_dive = false;
			_runroll_slide = false;
			_runroll_bump = true;
			_falling = true;
			_vspd = 12;
			_jump = true;
			
			global._pad_vibrate = 6;
		}
	}
	
	//shielding
	if(!_shield){
		_shieldpower += _shieldgain[1];
	}
		
	//ground
	if(_height <= _groundlevel){
		_jumpjuice = _maxjumpjuice;
	}
	
	if(_hurtTimer > 0 && !_falling){
		_vspd = 0;
		_jumpjuice = 0;
	}
	
	//damage numbers stuff
	if(_height == _groundlevel){
		_hplastframe = _hp;
	}
}