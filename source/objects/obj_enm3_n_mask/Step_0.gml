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
					if(_notp > 0){
						_notp --;
					}
					
					if(_shockwave){
						_tp = false;
						_tptime = 0;
						_tpact = 0;
						_displayobj.visible = true;
					}
					
					_movetimer ++;
					
					if(_mashed){
						_tp = false;
						_notp = 20;
					}
					
					if(!_tp){
						if(_hurttimer > 0){
							_notp = 20;
						}
						
						_tptime = 0;
						_tpact = 0;
						
						add_trait([TRAIT_GRAB,TRAIT_HURT]);
						
						scr_enemyscript_spd();
				
						if(_hurttimer == 0){
							switch(_behaviortype){
								case "move":
									if(_curstate == STATE_WALK){
										scr_enemyscript_behavior("walk");
									} else {
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
									_anim_prev = _anim;
									_anim = "grabbed";
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
							if(compare_anim("standup", "idle") || compare_anim("standup", "walk")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_idle";
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
						//teleporting
						_curstate = STATE_OTHER;
						clearpath();
						
						remove_trait([TRAIT_GRAB, TRAIT_HURT]);
						
						_tptime ++;
						switch(_tpact){
							case 0:
								//become invisible
								_anim = "tpaway";
								if(_displayobj.image_index >= _displayobj.image_number-1){
									_tptime = 0;
									_tpact = 1;
								}
							break;
							case 1:
								//teleport near player
								_displayobj.visible = false;
								_dh = instance_nearest(x,y,obj_dh_mask);
							
								if(!place_meeting(_dh.x+110, _dh.y, obj_solid) && !place_meeting(_dh.x-110, _dh.y, obj_solid)){
									x = _dh.x + 110; 
								} else if(place_meeting(_dh.x+110, _dh.y, obj_solid) && !place_meeting(_dh.x-110, _dh.y, obj_solid)){
									x = _dh.x - 110; 
								} else if(!place_meeting(_dh.x+110, _dh.y, obj_solid) && place_meeting(_dh.x-110, _dh.y, obj_solid)){
									x = _dh.x + 110; 
								} else {
									x = _dh.x;
								}
							
								y = _dh.y;
								if(_tptime >= 35){
									_tptime = 0;
									_tpact = 2;
								}
							break;
							case 2:
								//play animation
								_anim = "tpin";
								_displayobj.image_index = 0;
								_displayobj.visible = true;
								sfx_play_proximity(snd_tp_in);
								if(_tptime > 0){
									_tptime = 0;
									_tpact = 3;
								}
							break;
							case 3:
								//attack
								if(_displayobj.image_index >= _displayobj.image_number-1){
									_interest = 45;
									_curstate = STATE_ATTACK;
									_tp = false;
								}
							break;
						}
						scr_enemyscript_animation("step");
					}
				} else {
					_curstate = STATE_OTHER;
					clearpath();
				}
				
				scr_enemyscript_death();				
				
				//animation not affected by freeze
				if(!_death && !_tp){
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