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
			if(!_parachute){
				if(_battlezone || (!_battlezone && _spawncutscene)){
					_sequence_finished = false;
					if(_spawndir == "c"){
						_sequence_id = seq_st2_enm2_entC;
					} else {
						_sequence_id = seq_st2_enm2_entH;
					}
				}
			}
			
			//alt behavior
			if(_enmtype == 0){
				//red cap
				_movespd[? SPD_WALK] = 7;
				_movespd[? SPD_BACK] = 4;
				_movespd[? SPD_PANIC] = 9;
							
				_stunrange = [50, 100];
				
				_slidespd_max = 35;
				_slidedecel_max = 0.1;
			}
						
			if(_enmtype == 1){
				//milkman
				_movespd[? SPD_WALK] = 5;
				_movespd[? SPD_BACK] = 5;
				_movespd[? SPD_PANIC] = 9;
				
				_stunrange = [90, 190];
			}
			
			scr_enemyscript_init("step");
		} else {
			_startTimer --;
			if(!_idiot && _startTimer <= 0){
				if(!_sequence_finished){
					scr_enemyscript_startsequence();
				} else {
					scr_enemyscript_behavior("");
					if(_freeze <= 0){
						_movetimer ++;
						
						scr_enemyscript_spd();
					
						if(_hurttimer == 0 && _dodgetimer == 0){
							switch(_behaviortype){
								case "move":
									if(_curstate == STATE_WALK){
										scr_enemyscript_behavior("walk");
									} else {
										_randoffset = [random_range(-_walkdist[0],_walkdist[0]),random_range(-_walkdist[1],_walkdist[1])];
										_multdist = 1;
									}
									if(_curstate == STATE_FOLLOW && !_yolob_milk){
										scr_enemyscript_behavior("follow");
									}
								break;
								case "attack":
									if(!_yolob_milk){
										scr_enemyscript_behavior("attack");
									}
								break;
							}
						}
					
						if(!_death){
							scr_enemyscript_behavior("battlezone");
							scr_enemyscript_behavior("grab");
							
							_grabhp = false;
							
							if(_stuntimer > 0){
								_grabhp = true;
							}
							
							//stuns
							
							if(!_falling && _grabbed && _stuntimer == 0 && !_fall_ko){
								_grabdodge = true;
								if(_dh != noone && instance_exists(_dh)){
									with(_dh){
										force_throw_enemy();
									}
								}
								sfx_play_choose_proximity(global._swishsounds[1]);
							}
						
							if(_grabbed && _stuntimer > 0){
								_stun = false;
								_stunact = 0;
								_stuntimer = 1;
							}
						
							//trait removal/addition
							if(_curstate == STATE_SLIDE){
								if(has_trait(TRAIT_GRAB)){
									remove_trait(TRAIT_GRAB);
								}
								if(has_trait(TRAIT_DODGE)){
									remove_trait(TRAIT_DODGE);
								}
							} else {
								if(!has_trait(TRAIT_GRAB)){
									add_trait(TRAIT_GRAB);
								}
								if(!has_trait(TRAIT_DODGE)){
									add_trait(TRAIT_DODGE);
								}
							}
							
							if(_falling || _fall_ko){
								if(has_trait(TRAIT_HOP) || has_trait(TRAIT_SLIDE)){
									remove_trait([TRAIT_HOP, TRAIT_SLIDE]);
								}
							} else {
								if(!has_trait(TRAIT_HOP) || !has_trait(TRAIT_SLIDE)){
									add_trait([TRAIT_HOP, TRAIT_SLIDE]);
								}
							}
							
							if(_curstate == STATE_IDLE && _anim == "dead"){
								if(has_trait(TRAIT_DODGE)){
									remove_trait(TRAIT_DODGE);
								}
							} else {
								if(!has_trait(TRAIT_DODGE)){
									add_trait(TRAIT_DODGE);
								}
							}
						}
						
						scr_enemyscript_falling();
					
						scr_enemyscript_animation("step");
						
						if(_anim == "follow"){
							if(_displayobj.image_index >= 0 && _displayobj.image_index < 1){
								if(_dostepsound){
									sfx_play_choose_proximity([asset_get_index("snd_footstep1_"+_floortype),asset_get_index("snd_footstep2_"+_floortype)], 1, false);
									_dostepsound = false;
								}
							} else {
								_dostepsound = true;
							}
						} else if(_anim == "walk"){
							if((_displayobj.image_index >= 2 && _displayobj.image_index < 3)||(_displayobj.image_index >= 5 && _displayobj.image_index < 6)){
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
								if(_hurttimer > 0 || _dodgetimer > 0){
									_anim_transition = false;
								}
								
								//transitions
								switch(_anim_tr_anim){
									case "standup_idle":
										_anim = "tr_standup_idle";
									break;
									case "standup_stun":
										_anim = "tr_standup_stun";
									break;
									case "crouch_in":
										if(_slideact > 0 || _attack){
											_anim_transition = false;
										}
										_anim = "tr_crouch_in";
									break;
									case "crouch_out":
										if(_attack){
											_anim_transition = false;
										}
										_anim = "tr_crouch_out";
									break;
								}
								if(_displayobj.image_index >= _displayobj.image_number-1){
									_anim_tr_anim = "";
									_anim_prev = _anim;
									_anim_transition = false;
								}
							} else {
								if(_hurttimer == 0 && _dodgetimer == 0){
									switch(_behaviortype){
										case "idle":
											_anim_prev = _anim;
											if(_stuntimer == 0){
												_anim = "idle";
											} else {
												if(_stunact == 0){
													_anim = "stun";
												} else if(_stunact > 0){
													_anim = "stun2";
												}
											}
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
								
								if(_yolob_milk){
									switch(_yolob_milkact){
										case 0:
											_anim = "glontch";
										break;
										case 1:
											_anim = "throw";
										break;
									}
								}
								
								if(_attack){
									switch(_attacktype){
										case "idle":
											if(!_yolob_kick){
												_anim_prev = _anim;
												_anim = "kick1";
												//loop kick1
												if(_displayobj.image_index >= _displayobj.image_number-1){
													_displayobj.image_index = 3;
												}
											} else {
												_anim_prev = _anim;
												_anim = "kick2";
											}
										break;
									}
									_curspd = [0,0];
									clearpath();
								}
								
								//slide
								if(_curstate == STATE_SLIDE){
									_anim_prev = _anim;
									if(_slideact == 0){
										_anim = "crouch";
									} else if(_slideact > 0){
										_anim = "slide";
									}
								}
								
								if(_taunt > 0){
									_anim_prev = _anim;
									_anim = "taunt";
									_curspd = [0,0];
									clearpath();
								}
								
								if(_anim == "taunt"){
									if(_didtauntsound == false){
										voice_play_overlap_proximity(snd_yolo_taunt, 1);
										_didtauntsound = true;
									}
								}
								else{
									_didtauntsound = false;
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
								
						
								//dodge anim
								if(_dodgetimer > 0){
									_anim_prev = _anim;
									_anim = "dodge";
								}
								
								if(_fall_ko){
									if(_stuntimer <= 0){
										_anim_prev = _anim;
										_anim = "dead";
										if(_standup && _hurttimer <= 0){
											_anim_prev = _anim;
											_anim = "standup";
										}
									} else {
										_anim_prev = _anim;
										_anim = "dead_stun";
										if(_standup && _hurttimer <= 0){
											_anim_prev = _anim;
											_anim = "standup_stun";
										}
									}
									if(_grabdodge){
										_anim_prev = _anim;
										_anim = "hop";
									}
								}
								if(_parachute){
									_anim_prev = _anim;
									_anim = "parachute";
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
							
								if(_fallabove && _hurttimer <= 0){
									_anim_prev = _anim;
									_anim = "standup";
								}
							}
						} else {
							_anim_prev = "";
							_anim = "skull";
							if(_downkill){
								_anim_prev = "";
								_anim = "dead";
							}
						}
						
						//make transition
						if(_anim_prev != _anim){
							if(compare_anim("standup", "idle") || compare_anim("standup", "walk") || compare_anim("hop", "idle") || compare_anim("hop", "walk")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
							if(compare_anim("standup_stun", "stun")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_stun";
								_anim_tr_init = false;
								_anim_transition = true;
							}
							if(compare_anim("parachute", "idle") || compare_anim("parachute", "walk") || compare_anim("parachute", "backoff")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
						
							_anim_prev = _anim;
						}
					
						if(!_death){
							//end attacking
							if(_attack){
								switch(_attacktype){
									case "idle":
										if(!_yolob_milk){
											if(_yolob_kickdir == 0){
												_yolob_kickdir = _curdir;
											} else {
												_curdir = _yolob_kickdir;
											}
									
											if(_curstate == STATE_JUMP){
												_attack = false;
												_yolob_timer = 0;
												_yolob_kick = false;
											}
								
											_jumpingtimer = 0;
											_yolob_timer ++;
											if(!_yolob_kick && _anim != "standup" && _behaviortype != "hopping"){
												if(_displayobj.image_index >= _displayobj.image_number-1){
													_displayobj.image_index = _displayobj.image_number-2;
												}
										
												if(_yolob_timer >= scr_ailevel(16,30)){
													//kick
													_displayobj.image_index = 0;
											
													var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
													atk._parentobj = self.id;
													atk._ptype = "enm";
													atk._scale = [12, 3];
													atk._offset = [150,-60];
													atk._timer = 9;
													atk._damage = ATK_KO;
											
													_afterim_active = 60;
											
													sfx_play_choose_proximity(global._swishsounds[0]);
											
													_yolob_kick = true;
												}
											} else {
												if(_displayobj.image_index >= _displayobj.image_number-1){
													_yolob_kickdir = 0;
													_attack = false;
												}
											}
										}
									break;
								}
							} else {
								_yolob_kickdir = 0;
								_yolob_kick = false;
								_yolob_timer = 0;
							}
							
							//milk gimmick
							_yolob_addtimer = true;
							
							if(_yolob_milk && _attack){
								_attack = false;
							}
							if(_yolob_milk && _taunt > 0){
								_taunt = 0;
							}
							if(_yolob_milk && _curstate == STATE_JUMP){
								_jumpingtimer = 0;
								_curstate = STATE_IDLE;
							}
							if(_falling){
								_yolob_milk = false;
								_yolob_addtimer = false;
								_yolob_milkact = 0;
							}
							if(_shockwave || _grabbed){
								_yolob_milk = false;
								_yolob_milktimer = 0;
								_yolob_milkact = 0;
								_yolob_heal = false;
							}
							
							var sub = 5;
							if(_enmtype == 1){
								sub = 0;
							}
							
							//milk man
							if(_enmtype == 1){
								if(_stuntimer > 0 || _curstate == STATE_SLIDE){
									_yolob_milktimer = 999;
								}
							}
							
							var canmilk = true;
							if(_yolob_kick || _falling || _fall_ko || _standup || _taunt > 0 || _shockwave || _mashed || _stuntimer > 0 || _slide || _attack){
								canmilk = false;
							}
							if(_anim_transition){
								canmilk = false;
							}
							
							if(_enmtype != -1){
								if(_hp < _maxhp-sub){
									if(_behaviortype == "move" && _curstate != STATE_JUMP && canmilk){
										if(!_yolob_milk){
											if(_yolob_addtimer){
												_yolob_milktimer ++;
											}
											
											//force attack move
											if(instance_number_array(global._enemyArray) == 1 && _enmtype != -1 && !_alt_attack){
												_yolob_milktimer = 9999;
											}
											
											var maxtimer = scr_ailevel(180,random_range(300,550));
									
											//milkman
											if(_enmtype == 1){
												maxtimer = scr_ailevel(50,random_range(120,300));
											}
									
											if(_yolob_milktimer >= maxtimer){
												for(var i = 0; i < array_length(_yolob_sfx); i++){
													_yolob_sfx[i][2] = false;
												}
										
												_anim = "glontch";
												_displayobj.image_index = 0;
												_yolob_milktimer = 0;
												_yolob_milkact = 0;
												_yolob_milk = true;
												_yolob_heal = false;
											}
										}
									}
								}	
							}
							
							if(_yolob_milk){
								_slide = false;
								_attack = false;
								_jumpingtimer = 0;
								_taunt = 0;
								
								_jumpingtimer = 0;
								_slidetimer = 0;
								
								_yolob_timer = 0;
								_yolob_kick = false;
								
								_curspd = [0,0];
								clearpath();
								
								if(_dodgetimer > 0 || _hurttimer > 0 || _falling){
									_yolob_milk = false;
									_yolob_milkact = 0;
									_yolob_milktimer = 0;
									_yolob_heal = false;
								}
								
								switch(_yolob_milkact){
									case 0:
										//glontching animation
										_alt_attack = true;
										
										if(!_yolob_heal && _displayobj.image_index >= 16){
											//healing
											var hpheal = 10;
											if(_enmtype == 1){
												hpheal = 4;
											}
											
											_storehp = _hp;
											_hp += hpheal;
											if(_hp > _maxhp){
												_hp = _maxhp;
											}
											
											with(obj_game){
												ui_fade("enemy", 1);
											}
											
											sfx_play_proximity(snd_item);
											
											var healnum = instance_create_depth(x, y - 220, 0, obj_nums);
											if(_hp < _maxhp){
												healnum._num = hpheal;
											} else {
												healnum._num = diff_abs(_storehp, _maxhp);
											}
											healnum._plus = true;
											
											_yolob_heal = true;
										}
										
										//sounds
										for(var i = 0; i < array_length(_yolob_sfx); i++){
											if(!_yolob_sfx[i][2] && _displayobj.image_index >= _yolob_sfx[i][0]){
												sfx_play_proximity(_yolob_sfx[i][1]);
												sfx_pitch(_yolob_sfx[i][1], random_range(0.86, 1.12));
												_yolob_sfx[i][2] = true;
											}
										}
										
										if(_anim == "glontch" && !_anim_transition && _displayobj.image_index >= _displayobj.image_number-1){
											_displayobj.image_index = 0;
											_yolob_milkact = 1;
											var milk = instance_create_depth(x+(32*_curdir), y+48, _displayobj.depth, obj_st2_enm2_milk);
											milk._curdir = _curdir;
											milk._enmtype = _enmtype;
											
											milk._maxcolors = _maxcolors;
											milk._mult_colorinArray = _mult_colorinArray;
											milk._mult_coloroutArray = _mult_coloroutArray;
											milk._mult_tolrArray = _mult_tolrArray;
											milk._mult_blendArray = _mult_blendArray;
											
											sfx_play_choose_proximity(global._punchsounds[0]);
										}
									break;
									case 1:
										//throwing animation
										if(_displayobj.image_index >= _displayobj.image_number-1){
											_yolob_milk = false;
											_yolob_milktimer = 0;
											_yolob_milkact = 0;
											_yolob_heal = false;
										}
									break;
								}
							}
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
							if(_stuntimer > 0){
								_anim = "fall_stun";
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
					}
					
					scr_enemyscript_dir();
					
					scr_enemyscript_bottomscript();
				}
			}
		}
	} else {
		clearpath();
		with(_displayobj){
			image_speed = 0;
		}
	}
}