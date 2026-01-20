{
	if(!global._debug){
		visible = false;
	} else {
		visible = global._showHitbox;
	}
	
	scr_enemyscript_inactive();
	
	if(!global._pause && !_inactive){
		scr_enemyscript_colors();
		
		if(!_init){
			scr_enemyscript_init("step");
		} else {
			_startTimer --;
			if(!_idiot && _startTimer <= 0){
				scr_enemyscript_behavior("");
				if(_freeze <= 0){
					_movetimer ++;
					
					scr_enemyscript_spd();
				
					if(_hurttimer == 0){
						switch(_behaviortype){
							case "move":
								if(_curstate == STATE_WALK){
									scr_enemyscript_behavior("walk");
								} else {
									_randoffset = [random_range(-_walkdist[0],_walkdist[0]),random_range(-_walkdist[1],_walkdist[1])];
									_multdist = 1;
								}
								if(_curstate == STATE_FOLLOW){
									scr_enemyscript_behavior("follow");
								}
							break;
							case "attack":
								scr_enemyscript_behavior("attack");
							break;
						}
					}
				
					scr_enemyscript_behavior("battlezone");
					scr_enemyscript_behavior("grab");
					
					scr_enemyscript_falling();
			
					scr_enemyscript_animation("step");
				
					if(!_death){
						if(_anim_transition){
							//transitions
							switch(_anim_tr_anim){
								case "standup_idle":
									_anim = "tr_standup_idle";
								break;
								case "grabstart_grabbed":
									_anim = "tr_grabstart_grabbed";
								break;
							}
							if(_displayobj.image_index >= _displayobj.image_number-1){
								_anim_tr_anim = "";
								_anim_prev = _anim;
								_anim_transition = false;
							}
						} else {
							if(_hurttimer == 0){
								switch(_behaviortype){
									case "idle":
										_anim_prev = _anim;
										_anim = "idle";
										_idletimer = 0;
							
										_curspd = [0,0];
										clearpath();
									break;
									case "move":
										walk();
									break;
									case "attack":
										if(!_attack){
											walk();
										}
									break;
								}
							}
							if(_attack){
								switch(_attacktype){
									case "idle":
										_anim_prev = _anim;
										_anim = "melee_idle"+string(_curatk);
									break;
								}
								_curspd = [0,0];
								clearpath();
							}
							if(_did_ko == 1 && _anim != "melee_idle3"){
								_did_ko = 2;
							}
							if(_did_ko == 2){
								clearpath();
								_anim_prev = _anim;
								_anim = "melee_idle3";
								if(_displayobj.image_index >= _displayobj.image_number-1){
									_did_ko = 0;
								}
								if(_hurttimer > 0){
									_did_ko = 0;
								}
							}
							if(_taunt > 0){
								_anim_prev = _anim;
								_anim = "taunt";
								_curspd = [0,0];
								clearpath();
							}
					
							//hurt anim
							if(_hurttimer > 0){
								_anim_prev = _anim;
								_anim = "hurt"+string(_hurtanim);
								if(_mashed){
									_anim_prev = _anim;
									_anim = "mashhurt";
									_displayobj.image_index = _mashhurt;
								}
							}
							if(_fall_ko){
								_anim_prev = _anim;
								_anim = "dead";
								if(_standup && _hurttimer <= 0){
									_anim_prev = _anim;
									_anim = "standup";
								}
							}
							if(_grabout && _hurttimer <= 0){
								_anim_prev = _anim;
								_anim = "standup";
							}
							if(_grabbed){
								if(_grabstart){
									_anim_prev = _anim;
									_anim = "grabstart";
								} else {
									_anim_prev = _anim;
									_anim = "grabbed";
								}
							}
							if(_shockwave){
								_anim_prev = _anim;
								_anim = "shockwave";
							}
							if(_mashed && _hurttimer <= 0){
								_anim_prev = _anim;
								_anim = "shockwave";
							}
						
							if(_fallabove && _hurttimer <= 0){
								_anim_prev = _anim;
								_anim = "standup";
							}
						}
					} else {
						_anim_prev = "";
						_anim = "skull";
					}
					
					//make transition
					if(_anim_prev != _anim){
						if(compare_anim("standup", "idle") || compare_anim("standup", "walk") || compare_anim("hop", "idle") || compare_anim("hop", "walk") || compare_anim("hop", "follow")){
							_displayobj.image_index = 0;
							_anim_tr_anim = "standup_idle";
							_anim_tr_init = false;
							_anim_transition = true;
						}
						
						if(compare_anim("grabstart", "grabbed")){
							_displayobj.image_index = 0;
							_anim_tr_anim = "grabstart_grabbed";
							_anim_tr_init = false;
							_anim_transition = true;
						}
					
						_anim_prev = _anim;
					}
			
					//end attacking
					if(_attack){
						if(_displayobj.image_index >= _displayobj.image_number-1){
							_attack = false;
						}
					}
			
					scr_enemyscript_detect();
			
					scr_enemyscript_other();
				} else {
					_curstate = STATE_OTHER;
					clearpath();
				}
				
				scr_enemyscript_death();
				
				//animation not affected by freeze
				if(!_death){
					if(_falling && !_grabout){
						_anim = "fall";
					}
					/*if(!_grabbed && _grabout && _hurttimer <= 0 && _height > _groundlevel){
						_anim_prev = _anim;
						_anim = "standup";
					}*/
					if(_grabfall){
						_anim_prev = _anim;
						_anim = "fall";
					}
				}
				
				scr_enemyscript_dir();

				scr_enemyscript_bottomscript();
			}
		}
	} else {
		clearpath();
		with(_displayobj){
			image_speed = 0;
		}
	}
}