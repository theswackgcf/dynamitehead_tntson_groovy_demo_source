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
			if(place_meeting(x,y,obj_bosszone) && _spawndir == "u"){
				_glass = true;
			}
			
			if(!_parachute && !_hn_crucified){
				if(_battlezone || (!_battlezone && _spawncutscene)){
					_didspot = true;
					_sequence_finished = false;
					if(_spawndir == "l" || _spawndir == "r"){
						_sequence_id = seq_st2_enm1_entH;
					} else if(_spawndir == "u"){
						_sequence_id = seq_st2_enm1_entU;
					} else if(_spawndir == "c"){
						_sequence_id = seq_st2_enm1_entC;
					} else if(_spawndir == "d"){
						_sequence_id = seq_st2_enm1_entD;
						_seq_forcedepth = -5000;
					}
				}
			}
			
			//ringmaster
			if(_enmtype == 0){
				_movespd[? SPD_WALK] = 7;
				_movespd[? SPD_BACK] = 5;
				_movespd[? SPD_PANIC] = 9;
			}
			
			//grasshopper
			if(_enmtype == 1){
				_movespd[? SPD_WALK] = 6;
				_movespd[? SPD_BACK] = 4;
				_movespd[? SPD_PANIC] = 6;
			}
			
			scr_enemyscript_init("step");
		} else {
			_maxblockcount = 4;
			if(_enmtype == 0){
				_maxblockcount = 2;
			}
			if(_enmtype == 1){
				_maxblockcount = 0;
			}
			
			if(_hn_shake > 0){
				_maxblockcount = 99;
			}
			
			_startTimer --;
			if(!_idiot && _startTimer <= 0){
				if(!_sequence_finished){
					scr_enemyscript_startsequence();
				} else {
					if(_hn_crucified){
						_anim_prev = _anim;
						_anim = "crucified";
						
						if(has_trait(TRAIT_HURT)){
							remove_trait(TRAIT_HURT);
						}
						if(has_trait(TRAIT_GRAB)){
							remove_trait(TRAIT_GRAB);
						}
						
						//triggered
						_hn_c_timer ++;
						
						if(!_hn_c_trigger){
							if(place_meeting(x,y,obj_fade)){
								var dh = instance_nearest(x,y,obj_dh_mask);
								if(instance_exists(dh) && distance_to_object(dh) <= 180){
									_hn_c_timer = 9999;
								}
								if(_hn_c_timer >= 600){
									_hn_c_timer = 0;
									_hn_c_trigger = true;
								}
							}
						} else {
							if(_hn_c_amp > 0){
								_hn_c_amp --;
							} else if(_hn_c_amp < 0){
								_hn_c_amp = 0;
							}
							_dispoffset[0] = sin(random(480))*_hn_c_amp;
							
							if(_hn_c_snd){
								sfx_play_proximity(snd_henchie_shake);
								sfx_pitch(snd_henchie_shake, random_range(0.7, 1.3));
								
								_hn_c_snd = false;
							}
							
							switch(_hn_c_shakes){
								case 0:
									_hn_c_amp = 16;
									_hn_c_timer = 0;
									_hn_c_shakes ++;
									_hn_c_snd = true;
								break;
								case 1:
									if(_hn_c_timer >= 30){
										_hn_c_amp = 20;
										_hn_c_timer = 0;
										_hn_c_shakes ++;
										_hn_c_snd = true;
									}
								break;
								case 2:
									if(_hn_c_timer >= 17){
										_hn_c_amp = 28;
										_hn_c_timer = 0;
										_hn_c_shakes ++;
										_hn_c_snd = true;
									}
								break;
								case 3:
									if(_hn_c_timer >= 30){
										_holdframetimer = 2;
										
										if(!has_trait(TRAIT_HURT)){
											add_trait(TRAIT_HURT);
										}
										if(!has_trait(TRAIT_GRAB)){
											add_trait(TRAIT_GRAB);
										}
										scr_enemyscript_sequenceinit();
										
										_dispoffset[0] = 0;
										
										_depthoffset = 0;
										
										_spawncutscene = true;
										_spawndir = "u";
										_sequence_id = seq_st2_enm1_entU;
										_seq_forcehop = true;
										_spawnpos = [x,y];
										_offscreenpos[0] = x;
										_offscreenpos[1] = y-300;
										
										_didspot = true;
										_spottimer = 0;
										
										sfx_play_proximity(snd_henchie_notice);
										
										sfx_play_proximity(snd_henchie_breakfree);
										sfx_pitch(snd_henchie_breakfree, random_range(0.8, 1.2));
										
										_hn_crucified = false;
									}
								break;
							}
						}
						
						scr_enemyscript_death();
					} else {
						scr_enemyscript_behavior("");
						if(_freeze <= 0){
							_movetimer ++;
					
							scr_enemyscript_spd();
				
							if(_behaviortype != "hopping"){
								_hop_startpos[0] = x;
								_hop_startpos[1] = y;
							}
				
							//attack code
							if(_curstate != STATE_JUMP && (_falling || _attack || _grabbed || _fall_ko || _successparry > 0)){
								if(_anim != "jumpprep"){
									_hn_atkact = 0;
									_hn_timer = 0;
									_hn_attack = false;
									_hn_hop = false;
								}
							}
						
							if(!_attack && _hn_hop && _prev_hop_arc < _hop_arc){
								_displayobj.image_index = 0;
								_attacktype = "air";
								_attack = true;
								sfx_play_choose_proximity(global._swishsounds[2]);
							}
						
							if(_attack && _attacktype == "air" && _displayobj.image_index >= 1){
								_afterim_active = 3;
								if(!_attackhb){
									_attackhb = true;
									var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
									atk._parentobj = self.id;
									atk._scale = [4, 4.6];
									atk._offset = [50,-86];
									atk._diffabs[1] = 145;
									atk._timer = 320;
									atk._damage = ATK_KO;
									atk._ptype = "enm";
									atk._type = "air_enm";
									atk._delay = 12;
									atk._persist = true;
								}
							}
						
							if(_attack && _attacktype == "crouch"){
								_afterim_active = 3;
							}
							
							if(_attack && _attacktype == "crouch" && !_hn_crouchhit){
								//create ko attack
								var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
								atk._parentobj = self.id;
								atk._ptype = "enm";
								atk._scale = [18, 5];
								atk._offset = [0,0];
								atk._timer = 6;
								atk._height = 20;
								atk._bothdir = true;
								atk._damage = ATK_KO;
								atk._type = "crouch_enm";
							
								_hn_crouchhit = true;
							}
							if(!_attack){
								_hn_crouchhit = false;
							}
						
							//hop values
							if(_hn_hop){
								_hop_archeight = 1560;
								_hop_spd = 0.022;
								if(_total_ailevel >= 6){
									_hop_archeight = 1430;
									_hop_spd = 0.03;
								}
							} else {
								_hop_archeight = _hop_archeight_def;
								_hop_spd = _hop_spd_def;
							}
						
							if(_hn_hop){
								_hop_walk = false;
								if(_behaviortype == "hopping"){
									_afterim_active = 3;
								}
							}
							
							if(_hn_cooldown > 0){
								_hn_cooldown --;
							}
						
							if(_hn_attack){
								_curspd = [0,0];
								clearpath();
							
								switch(_hn_atkact){
									case 0:
										if(_hn_cooldown <= 0){
											_hn_atktimer ++;
											if(_displayobj.image_index >= _displayobj.image_number-1 || _hn_atktimer >= 120){
												_hn_atkact = 1;
												_hn_atktimer = 0;
											}
										} else {
											_hn_atkact = 0;
											_hn_attack = false;
										}
									break;
									case 1:
										if(_hn_cooldown <= 0){
											_alt_attack = true;
									
											if(!_hn_hop && _curstate != STATE_JUMP){
												scr_hopspot(HOP_DH);
								
												if(scr_enemyscript_calculatejump(0)){
													sfx_play_proximity(snd_jump);
													_hn_cooldown = 120;
													_hn_timer = 0;
													_hn_attack = false;
													_hn_atkact = 0;
													_hn_hop = true;
													_dohop = true;
												}
											}
										} else {
											_hn_atkact = 0;
											_hn_attack = false;
										}
									break;
								}
							} else {
								_hn_atktimer = 0;
							}
					
							if(_hn_hopstart && _behaviortype != "hopping"){
								_hn_cooldown = 0;
								_hn_slamdown = 0;
								_hn_shake = 28;
								if(_total_ailevel >= 4){
									_hn_shake = 20;
								}
								if(_total_ailevel >= 7){
									_hn_shake = 8;
								}
								if(_total_ailevel >= 9){
									_hn_shake = 5;
								}
							
								for(var i = 0; i < 2; i++){
									var p = instance_create_depth(x-42, y+32, depth, obj_particle);
									p._move = true;
									if(i == 0){
										p._type = "run4";
										p._xspd = -14;
									} else if(i == 1){
										p._type = "run5";
										p._xspd = 14;
									}
								}
							
								_hn_hopstart = false;
							}
							if(_hn_shake > 0){
								_hn_endinit = true;
								_curspd = [0,0];
								clearpath();
								_hn_shake --;
							}
							if(_hn_shake <= 0 && _hn_endinit){
								_height = _groundlevel+2;
				
								_fall_ko = true;
								_jump = true;
								_vspd = 12;
				
								_displayobj.image_index = 0;
				
								_standup = true;
								_nocrouchatk = true;
							
								_hn_endinit = false;
							}
							if(_falling || _fall_ko){
								_hn_slamdown = 0;
								_hn_shake = 0;
							}
							
							if(_hn_attack || _hn_multjump || _hn_hop || _hn_shake > 0){
								_panictimer = 0;
							}
					
							if(_hurttimer == 0){
								switch(_behaviortype){
									case "move":
										if(_hn_shake <= 0){
											if(_curstate == STATE_WALK){
												scr_enemyscript_behavior("walk");
											} else {
												_randoffset = [random_range(-_walkdist[0],_walkdist[0]),random_range(-_walkdist[1],_walkdist[1])];
												_multdist = 1;
											}
											if(_curstate == STATE_FOLLOW){
												scr_enemyscript_behavior("follow");
											}
										}
									
									
										//special henchie move
										_hn_addtimer = true;
										if(_hurttimer > 0 || _taunt > 0 || _attack || _blocktimer > 0 || _falling || _grabbed || _docrouchkick || (_behaviortype == "hopping" && _hop_walk)){
											_hn_addtimer = false;
										}
									
										if(!_hn_attack && !_hn_hop){
											var dh = instance_nearest(x, y, obj_dh_mask);
											if(distance_to_object(dh) >= HEIGHT*0.22 && distance_to_object(dh) < WIDTH*0.7){
												if(_hn_addtimer){
													_hn_timer ++;
												}
											} else {
												_hn_addtimer = false;
											}
										}
										
										//force attack move
										if(instance_number_array(global._enemyArray) == 1 && _enmtype != -1 && !_alt_attack){
											_hn_timer = 9999;
										}
									
										if(_hn_jumpcd > 0){
											_hn_jumpcd --;
										}
									
										if(_panictimer > 0 && _anim != "jumpprep"){
											_hn_timer = 0;
											_hn_attack = false;
											_hn_atkact = 0;
											_hn_hop = false;
										}
									
										var maxvalue = scr_ailevel(90,random_range(90,140));
									
										if(_hn_shake <= 0){
											if(_enmtype == 0){
												//ringmaster
												if(_hn_cooldown <= 0 && !_block && _blocktimer <= 0 && _anim != "blockko" && !_docrouchkick){
													if(_taunt <= 0 && _hn_jumpcd <= 0 && !_hn_attack && !_hn_hop && _hn_timer >= maxvalue){
														scr_hopspot(HOP_DH);
										
														_hn_jumpcd = scr_ailevel(4,random_range(15,40));
														_dh = instance_nearest(x,y,obj_dh_mask);
														if(_dh._mashact == 0 && (_dh._occupycenter <= 0 || place_meeting_array(_dh.x,_dh.y,_collide_solid) || place_meeting_array(_dh.x,_dh.y,_collide_other))){
															if(scr_enemyscript_calculatejump()){
																if(!_hn_attack){
																	_displayobj.image_index = 0;
																	_hn_attack = true;
																	_hn_atkact = 0;
																	_hn_timer = 0;
																}
															} else {
																_hn_attack = false;
																_hn_atkact = 0;
																_hn_timer = 0;
															}
														} else {
															_hn_attack = false;
															_hn_atkact = 0;
															_hn_timer = 0;
														}
													}
												} else {
													_hn_attack = false;
													_hn_atkact = 0;
													_hn_timer = 0;
												}
											} else if(_enmtype == 1){
												//grasshopper
												if(_hn_multjump){
													_hn_timer = 9999;
													if(!_block && _blocktimer <= 0 && _anim != "blockko" && !_docrouchkick){
														if(_curstate != STATE_JUMP && _hn_jumpcd <= 0 && _taunt <= 0){
															_hn_jumpcd = scr_ailevel(4,random_range(15,40));
															_dh = instance_nearest(x,y,obj_dh_mask);
															if(_dh._mashact == 0 && _hn_jumpamnt < 3){
																scr_hopspot(HOP_RANDOM_DH);
																if(scr_enemyscript_calculatejump(0)){
																	if(!_hn_attack){
																		_hn_cooldown = 0;
																		_hn_jumpamnt ++;
																		_displayobj.image_index = 0;
																		_hn_attack = true;
																		_hn_atkact = 0;
																		if(_hn_jumpamnt > 0){
																			_hn_atkact = 1;
																		}
																		_hn_timer = 0;
																	}
																}
															} else {
																_hn_multjump = false;
																_hn_timer = 0;
																_hn_hop = false;
																_hn_attack = false;
															}
														}
													} else {
														_hn_multjump = false;
														_hn_timer = 0;
														_hn_hop = false;
														_hn_attack = false;
													}
												}
												if(!_hn_attack && !_hn_hop && _hn_timer >= maxvalue){
													if(!_hn_multjump){
														_hn_jumpamnt = 0;
														_hn_multjump = true;
													}
												}
											}
										} else {
											_freeze = 5;
											_jumpingtimer = 0;
											_stuntimer = 0;
											_stunpunch = 0;
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
					
							if(_falling){
								_hn_shake = 0;
							}
							if(_hn_shake <= 0){
								scr_enemyscript_falling();
							}
			
							scr_enemyscript_animation("step");
					
							//henchie sfx
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
					
							if(_anim == "spot"){
								if(has_trait(TRAIT_SPOT) && _didnoticesound == false){
									voice_play_overlap_proximity(snd_henchie_notice, 1);
									_didnoticesound = true;
								}
							}
						
							if(_jumpoff_snd){
								voice_play_overlap_proximity(snd_henchie_notice, 1);
								_jumpoff_snd = false;
							}
					
							if(_anim == "taunt"){
								if(_didtauntsound == false){
									voice_play_overlap_proximity(snd_henchie_taunt, 1);
									_didtauntsound = true;
								}
							}
							else{
								_didtauntsound = false;
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
									
										case "spot_in":
											_anim = "spot";
										break;
										case "spot_out":
											_anim = "spot_out";
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
											case "blockko":
												_did_ko = 0;
												_anim_prev = _anim;
												_anim = "blockko";
											break;
											case "crouch":
												if(_crouchkicktime > 12){
													_displayobj.image_index = 0;
												}
												_did_ko = 0;
												_anim_prev = _anim;
												_anim = "crouchkick";
											break;
										}
										_curspd = [0,0];
										clearpath();
									}
								
									if(_hn_attack){
										if(_hn_atkact == 0){
											_anim_prev = _anim;
											_anim = "jumpprep";
										}
									}
								
									if(_did_ko < 2){
										_didko_timer = 0;
									}
									if(_did_ko == 1 && _anim != "melee_idle3"){
										_displayobj.image_index = 0;
										_did_ko = 2;
									}
									if(_did_ko == 2){
										_didko_timer ++;
										clearpath();
										_anim_prev = _anim;
										_anim = "melee_idle3";
										if(_didko_timer >= 3 && _displayobj.image_index >= _displayobj.image_number-1){
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
								
									if(_spottimer > 0){
										_anim = "spot_loop";
										if(_curspd[0] <> 0 || _curspd[1] <> 0){
											_spottimer = 0;
										}
									}
								
									if(_behaviortype == "hopping"){
										if(!_hop_walk){
											_anim_prev = _anim;
											_anim = "hop";
										} else {
											_docrouchkick = false;
											_anim_prev = _anim;
											_anim = "walk";
											_animspeed = _walk_animspeed;;
										}
										if(_hn_hop){
											_curstate = STATE_JUMP;
											_anim_prev = _anim;
											_anim = "jump";
											if(_attack){
												_hn_hopstart = true;
											
												_anim_prev = _anim;
												_anim = "jumpko";
											}
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
												if(_height <= _groundlevel){
													_anim_prev = _anim;
													_anim = "idle";
												}
											}
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
								
									if(_grabout){
										_anim_prev = _anim;
										_anim = "standup";
										if(_height <= _groundlevel){
											_anim_prev = _anim;
											_anim = "idle";
										}
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
									if(_mashed && _hurttimer <= 0){
										_anim_prev = _anim;
										_anim = "shockwave";
									}
									if(_hn_shake > 0){
										_anim_prev = _anim;
										_anim = "jumpko_after";
									}
						
									if(_fallabove){
										_anim_prev = _anim;
										_anim = "standup";
										if(_height <= _groundlevel){
											_anim_prev = _anim;
											_anim = "idle";
										}
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
								if(compare_anim("standup", "idle") || compare_anim("standup", "walk")){
									_displayobj.image_index = 0;
									_anim_tr_anim = "standup_idle";
									_anim_tr_init = false;
									_anim_transition = true;
								}
							
								if(compare_anim("idle", "spot_loop") || compare_anim("walk", "spot_loop") || compare_anim("follow", "spot_loop") || compare_anim("bckoff", "spot_loop")){
									_displayobj.image_index = 0;
									_anim_tr_anim = "spot_in";
									_anim_tr_init = false;
									_anim_transition = true;
								}
								if(compare_anim("spot_loop", "idle") || compare_anim("spot_loop", "walk") || compare_anim("spot_loop", "follow") || compare_anim("spot_loop", "backoff")){
									_displayobj.image_index = 0;
									_anim_tr_anim = "spot_out";
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
								//alt behavior
								if(_enmtype != -1){
									if(!_hn_attack && !_hn_hop && _hn_shake <= 0 && !_falling && _grabbed){
										_grabdodge = true;
										if(_dh != noone && instance_exists(_dh)){
											with(_dh){
												force_throw_enemy();
											}
										}
										sfx_play_choose_proximity(global._swishsounds[1]);
									}
								}
							
								//end attacking
								if(_attack){
									if(!_hn_hop && !_anim_transition){
										if(_anim == "crouchkick"){
											if(_crouchkicktime <= 4 && _displayobj.image_index >= _displayobj.image_number-1){
												_attack = false;
												_attacktype = "";
											}
										} else {
											if(_displayobj.image_index >= _displayobj.image_number-1){
												_attack = false;
												_attacktype = "";
											}
										}
									}
								} else {
									if(_crouchkicktime > 0){
										_anim = "crouchkick";
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
			}
		}
	} else {
		clearpath();
		with(_displayobj){
			image_speed = 0;
		}
	}
}