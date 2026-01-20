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
					
					if(_hurttimer == 0 && !_falling && !_death && !_grabbed){
						if(!_attack){
							_punch = false;
							_punchtimer = 0;
							sfx_stop(snd_swinging);
						} else {
							//huge punch
							if(_attacktype == "idle" && !_punch){
								_punchtimer ++;
								if(_punchtimer >= 50){
									_displayobj.image_index = 4;
									var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
									atk._parentobj = self.id;
									atk._ptype = "enm";
									atk._scale = [4, 2.2];
									atk._offset = [176,-76];
									atk._timer = 9;
									atk._damage = ATK_KO;
					
									sfx_stop(snd_swinging);
									sfx_play_choose_proximity(global._swishsounds[0]);
									
									_punchtimer = 0;
									_punch = true;
								} else {
									clearpath();
									if(_displayobj.image_index >= 4){
										_displayobj.image_index = 0;
									}
								}
							}
						}
					} else {
						_attack = false;
						_punchtimer = 0;
						_punch = false;
						sfx_stop(snd_swinging);
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
										_anim = "melee_punch";
									
										if(_displayobj.image_index >= _displayobj.image_number-1){
											_attack = false;
										}
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