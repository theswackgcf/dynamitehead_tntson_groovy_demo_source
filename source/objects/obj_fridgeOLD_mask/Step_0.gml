{
	if(!global._pause){
		scr_enemyscript_colors();
		
		if(_invinc){
			_hp = 99;
		}
		
		with(_displayobj){
			image_speed = 1;
		}
		
		if(_startTimer > 0){
			_startTimer --;
		}
		if(_startTimer <= 0){
			if(!_init){
				scr_enemyscript_init("step");
			} else {
				if(_grabfall){
					_begin = true;
				}
				
				if(_begin){
					_movetimer ++;
					
					if(_standup){
						x = lerp(x, WIDTH/2, 0.07);
						y = lerp(y, _starty, 0.07);
					}
					
					scr_enemyscript_behavior("");
					
					if(_freeze <= 0){
						scr_enemyscript_spd();
						
						scr_enemyscript_behavior("grab");
					}
				} else {
					_curdir = DIR_L;
					x = lerp(x, floor(WIDTH/2), 0.2);
					if(diff(x, floor(WIDTH/2)) < 10){
						_begin = true;
					}
				}
	
				if(_anim_transition){
					//transitions
					switch(_anim_tr_anim){
						case "standup_idle":
							_anim = "tr_standup_idle";
						break;
					}
					if(_displayobj.image_index >= _displayobj.image_number-1){
						_anim_tr_anim = "";
						_anim_prev = _anim;
						_anim_transition = false;
					}
				} else {
					if(_curspd[0] == 0 && _curspd[1] == 0){
						_anim_prev = _anim;
						_anim = "idle";
					}
					
					if(_falling){
						_anim_prev = _anim;
						_anim = "fall";
					}
					if(_grabbed){
						_anim_prev = _anim;
						_anim = "grabbed";
					}
					if(_fall_ko){
						_anim_prev = _anim;
						_anim = "dead";
						if(_standup && _hurttimer <= 0){
							_anim_prev = _anim;
							_anim = "standup";
						}
					}
					if(_fallabove && _standup && _hurttimer <= 0){
						_anim_prev = _anim;
						_anim = "standup";
					}
				}
	
				//make transition
				if(_anim_prev != _anim){
					if(compare_anim("standup", "idle")){
						_displayobj.image_index = 0;
						_anim_tr_anim = "standup_idle";
						_anim_tr_init = false;
						_anim_transition = true;
					}
					
					_anim_prev = _anim;
				}
	
				scr_enemyscript_animation("step");
	
				if(_begin){
					//ko types
					if(_falling || _fall_ko || _standup){
						if(!_setko){
							if(_dh_atk > 0 && _dh_atk_inst != noone && instance_exists(_dh_atk_inst)){
								if(_dh_atk_inst._attacktype != ""){
									_kotype = _dh_atk_inst._attacktype;
								}
								if(_dh_atk_inst._slide){
									_kotype = "slide";
								}
								if(_dh_atk_inst._mashact > 0){
									_kotype = "mash";
								}
							}
							
							_setko = true;
						}
					} else {
						_setko = false;
					}
					
					if(global._blowup_kill > 0){
						_invinc = false;
					}
					
					switch(global._tutrEvent){
						case 0:
							if(!global._tutrAct[global._tutrEvent] && _fall_ko && _kotype == "idle"){
								global._tutrAct[global._tutrEvent] = true;
							}
						break;
						case 1:
							if(!global._tutrAct[global._tutrEvent] && _fall_ko && _kotype == "air"){
								global._tutrAct[global._tutrEvent] = true;
							}
						break;
						case 2:
							if(!global._tutrAct[global._tutrEvent] && _fall_ko && _kotype == "upper"){
								global._tutrAct[global._tutrEvent] = true;
							}
						break;
						case 3:
							if(!global._tutrAct[global._tutrEvent] && _fall_ko && _kotype == "crouch"){
								global._tutrAct[global._tutrEvent] = true;
							}
						break;
						case 4:
							if(!global._tutrAct[global._tutrEvent] && _fall_ko && _kotype == "slide"){
								global._tutrAct[global._tutrEvent] = true;
							}
						break;
						case 6:
							if(!global._tutrAct[global._tutrEvent] && !_falling && _kotype == "grabfall"){
								global._tutrAct[global._tutrEvent] = true;
							}
						break;
						case 7:
							if(!global._tutrAct[global._tutrEvent] && _fall_ko && _kotype == "mash"){
								global._tutrAct[global._tutrEvent] = true;
							}
						break;
					}
				}
				
				scr_enemyscript_dir();
				
				if(_freeze <= 0){
					scr_enemyscript_other();
					scr_enemyscript_falling();
				}
				
				scr_enemyscript_death();
			}
		}
		
		scr_enemyscript_bottomscript();
	} else {
		with(_displayobj){
			image_speed = 0;
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