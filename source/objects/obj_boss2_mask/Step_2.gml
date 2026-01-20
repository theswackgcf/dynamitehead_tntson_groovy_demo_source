{
	if(!global._pause){
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
		
		if(_phaseend_act < 4){
			if(_anim_transition){
				_animerrtimer ++;
				if(_animerrtimer >= 90){
					_anim_transition = false;
				}
					
				//transitions
				switch(_anim_tr_anim){
					case "standup_idle":
						if(_crouchkicktime > 0){
							_anim_transition = false;
						}
						_curspd = [0,0];
						clearpath();
						_anim = "tr_standup_idle";
					break;
					case "skid_idle":
						_curspd = [0,0];
						clearpath();
						_anim = "tr_skid_idle";
					break;
				}
				if(_displayobj.image_index >= _displayobj.image_number-1){
					_anim_tr_anim = "";
					_anim_prev = _anim;
					_anim_transition = false;
				}
			} else {
				_animerrtimer = 0;
			
				if(_hurttimer <= 0){
					switch(_behaviortype){
						case "idle":
							_anim_prev = _anim;
							if(_stuntimer == 0){
								_anim = "idle"+string(_phase+1);
								if(_curspd[0] <> 0 || _curspd[1] <> 0){
									_anim = "walk"+string(_phase+1);
								}
							} else {
								_anim = "dizzy";
							}
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
								
				if(_anim != "runskid"){
					sfx_stop(snd_skid2);
				}
			
				if(_height <= _groundlevel){
					if(_block){
						_anim = "block";
					}
				}
			
				if(_attack){
					switch(_attacktype){
						case "idle":
							_anim_prev = _anim;
							_anim = "runprepare";
							if(_ll_atk_prepare > 0){
								_anim_prev = _anim;
								_anim = "runprepare";
								_ll_atk_dusttimer ++;
								if(_ll_atk_dusttimer >= 5){
									var p = instance_create_depth(_displayobj.x,_displayobj.y-10, _displayobj.depth+8, obj_particle);
									p._type = "run"+string(choose(1,2,3,4,5));
									p._move = true;
									p._xspd = random_range(2,7)*_curdir;
									_ll_atk_dusttimer = 0;
								}
							} else {
								_anim_prev = _anim;
								_anim = "runattack";
							}
						break;
						case "blockko":
							_anim_prev = _anim;
							_anim = "blockko";
											
							if(!_setframe){
								_displayobj.image_index = 0;
												
								_setframe = true;
							}
											
							if(_setframe && _displayobj.image_index >= 6 && !_blockko_fx){
								with(obj_camera){
									_ampY = 22;
								}
								var p = instance_create_depth(x+(64*_curdir),y+48,depth, obj_particle);
								p._type = "fx4";
								sfx_play(snd_thud);
								sfx_pitch(snd_thud, random_range(0.9,1.3));
								_blockko_fx = true;
							}
						break;
						case "vinyl":
							_anim_prev = _anim;
							_anim = "vinyl";
						break;
					}
					_curspd = [0,0];
					clearpath();
				}
			
				if(_attack && _attacktype == "idle" && _anim == "walk"+string(_phase+1)){
					_ll_badatk ++;
					if(_ll_badatk >= 3){
						_attack = false;
						_attacktype = "";
						_ll_badatk = 0;
					}
				}
				if(!_attack){
					_ll_badatk = 0;
				}
			
				if(_ll_atk1_attack){
					if(_ll_atk1_atkact == 0){
						_anim_prev = _anim;
						_anim = "jumpprep";
					}
				}
							
				if(_ll_atk4_dopose){
					if(_ll_lightgag <> 1){
						_anim_prev = _anim;
						_anim = "lighttaunt"+string(_ll_atk4_posetype);
					} else {
						_anim_prev = _anim;
						_anim = "lightgag";
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
					if(_slam){
						_anim_prev = _anim;
						_anim = "slam";
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
						
				if(_ll_atk1_shake > 0){
					_anim_prev = _anim;
					_anim = "jumpko_after";
				}
							
				if(_fallabove && _hurttimer <= 0){
					_anim_prev = _anim;
					_anim = "standup";
				}
								
				if(_behaviortype == "spinning"){
					_anim_prev = _anim;
					_anim = "spin1";
				}
				if(_anim == "spin1" && _stuntimer > 0){
					_specialatk = 0;
					_anim = "dizzy";
					_anim_prev = _anim;
				}
							
				switch(_ll_atk6_act){
					case 1:
						_anim_prev = _anim;
						_anim = "hench1";
					break;
					case 2:
						_specialatk = 0;
						_anim_prev = _anim;
						_anim = "hench2";
					break;
				}
			}
			
			if(!_attack && _behaviortype == "hopping"){
				if(_hop_arc < 0){
					_anim_prev = _anim;
					_anim = "hop";
				} else {
					_anim_prev = _anim;
					_anim = "walk"+string(_phase+1);
					_animspeed = _walk_animspeed;;
				}
			}	
			
			//animation not affected by freeze
			if(!_death){
				if(_falling && !_grabout){
					_anim = "fall";
				}
				if(_height > _groundlevel && _stunlock_dodge){
					if(_freeze > 0){
						_anim_prev = _anim;
						_anim = "ricochet";
						_displayobj.image_index = _stunlock_pose;
					} else {
						_anim_prev = _anim;
						_anim = "hop";
					}
				}
				/*if(!_grabbed && _grabout && _hurttimer <= 0 && _height > _groundlevel){
					_anim_prev = _anim;
					_anim = "standup";
				}*/
				if(_grabfall){
					_anim_prev = _anim;
					_anim = "fall";
				}
						
				if(_ll_atk3_quickflash){
					_anim_prev = _anim;
					_anim = "quickflash";
				}
						
				if(_ll_atk5_act == 1){
					_freeze = 0;
				}
			}
			
			if(_taunt > 0){
				_anim_prev = _anim;
				_anim = "taunt";
				_curspd = [0,0];
				clearpath();
			}
		
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
				_anim = "mashhurt";
				_displayobj.image_index = _parryframe;
				_successparry --;
			}
		}
			
		if(global._finalhit > 0 && global._finalhit_phase){
			_anim = "hurt"+string(_hurtanim);
			_freeze = 2;
		}
		if(global._finalhit > 0 && !global._finalhit_phase){
			if(_phasehit <= 0){
				_fallxspd = 0;
				_curspd = [0,0];
				clearpath();
				_anim = "mashhurt";
				_displayobj.image_index = 2;
				_freeze = 2;
			}
		}
		if(_phasehit > 0){
			_anim = _phasehit_anim;
			_displayobj.image_index = _phasehit_frame;
		}
			
		//phase end
		if(_phaseend_act == 1){
			if(global._finalhit <= 0){
				_freeze = 0;
					
				_anim_prev = _anim;
				_anim = "quickflash";
				if(abs(_slideoffspd) <= 28){
					_anim_prev = _anim;
					_anim = "phaseend1_2";
				} 
				if(abs(_slideoffspd) <= 14){
					_anim_prev = _anim;
					_anim = "phaseend1_1";
				}
				_animspeed = max(0.28,_slideoffspd/12);
			}
		} else if(_phaseend_act == 2){
			_anim_prev = _anim;
			_anim = "phaseend2";
			_animspeed = 1;
		} else if(_phaseend_act == 3 || _phaseend_act == 4){
			_anim_prev = _anim;
			_anim = "phaseend3";
		}
		
		scr_enemyscript_animation("endstep");
		
		if(global._lightsout){
			with(_displayobj){
				if(_shadowsinit && ds_map_exists(global._gameshadows, _occupy_id)){
					global._gameshadows[? _occupy_id][? "draw"] = false;
				}
			}
		}
		
		if(instance_number(obj_boss_finalko) > 0){
			_ll_disappear = true;
		}
		
		if(_ll_disappear){
			_draw_display = false;
		}
	}
}