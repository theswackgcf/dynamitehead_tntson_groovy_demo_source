{
	if(!global._debug){
		visible = false;
	} else {
		visible = global._showHitbox;
	}
	
	scr_sequence_pause();
	
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
						
					//hop values
					_hop_archeight = _hop_archeight_def;
					_hop_spd = _hop_spd_def;
					
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
				
					if(!_death){
						scr_enemyscript_behavior("battlezone");
						scr_enemyscript_behavior("grab");
					}
					
					scr_enemyscript_falling();
			
					scr_enemyscript_animation("step");
					
					//sfx
					if(_anim == "follow"){
						if(_displayobj.image_index >= 2){
							if(_dostepsound){
								sfx_play_choose_proximity([asset_get_index("snd_footstep1_"+_floortype),asset_get_index("snd_footstep2_"+_floortype)], 1, false);
								_dostepsound = false;
							}
						} else {
							_dostepsound = true;
						}
					} else if(_anim == "walk"){
						if((_displayobj.image_index >= 2 && _displayobj.image_index < 3)||(_displayobj.image_index >= 12 && _displayobj.image_index < 13)){
							if(_dostepsound){
								sfx_play_choose_proximity([asset_get_index("snd_footstep1_"+_floortype),asset_get_index("snd_footstep2_"+_floortype)], 1, false);
								_dostepsound = false;
							}
						} else {
							_dostepsound = true;
						}
					} else {
						_dostepsound = true;
					}
					
					if(!_death){
						if(_anim_transition){
							//transitions
							switch(_anim_tr_anim){
								case "standup_idle":
									if(_crouchkicktime > 0){
										_anim_transition = false;
									}
									_anim = "tr_standup_idle";
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
										
										if(_block){
											_anim = "block";
										}
							
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
							
							if(_taunt > 0){
								_anim_prev = _anim;
								_anim = "taunt";
								_curspd = [0,0];
								clearpath();
							}
								
							if(_behaviortype == "hopping"){
								if(!_hop_walk){
									_anim_prev = _anim;
									_anim = "hop";
								} else {
									_anim_prev = _anim;
									_anim = "walk";
									_animspeed = _walk_animspeed;;
								}
							}
					
							if(_fall_ko){
								if(!_standup){
									_anim_prev = _anim;
									_anim = "dead";
								} else {
									if(_hurttimer <= 0){
										_anim_prev = _anim;
										_anim = "standup";
									}
								}
							}
							
							//hurt anim
							if(_hurttimer > 0){
								_anim_prev = _anim;
								_anim = "hurt"+string(_hurtanim);
								if((_fall_ko || _falling) && !_standup){
									_anim = "fall";
								}
							}
							
							if(_grabout && _hurttimer <= 0){
								_anim_prev = _anim;
								_anim = "standup";
							}
							if(_grabbed){
								if(_grabstart){
									_anim_prev = _anim;
									_anim = "picked";
								} else {
									_anim_prev = _anim;
									_anim = "grabbed";
								}
							}
							
							if(_shockwave){
								_anim_prev = _anim;
								_anim = "shockwave";
							}
						
							if(_fallabove && _hurttimer <= 0){
								_anim_prev = _anim;
								_anim = "standup";
							}
						}
					}
					
					//make transition
					if(_anim_prev != _anim){
						if(compare_anim("standup", "idle") || compare_anim("standup", "walk")){
							_displayobj.image_index = 0;
							_anim_tr_anim = "standup_idle";
							_anim_tr_init = false;
							_anim_transition = true;
						}
					
						_anim_prev = _anim;
					}
			
					if(!_death){
						scr_enemyscript_detect();
					}
			
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
					
					if(_grabbed && _slam){
						_anim_prev = "slam";
						_anim = "slam";
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