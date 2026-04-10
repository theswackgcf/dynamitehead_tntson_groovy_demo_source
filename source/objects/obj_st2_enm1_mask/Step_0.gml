{
	if(!global._debug){
		visible = false;
	} else {
		visible = global._showHitbox;
	}
	
	scr_sequence_pause();
	
	scr_enemyscript_inactive();
	
	if(_hn_ring_fake){
		_startTimer = 0;
		_sequence_finished = true;
	}
	
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
				_movespd[? SPD_WALK] = 0;
				_movespd[? SPD_BACK] = 5;
				_movespd[? SPD_PANIC] = 9;
				_movespd[? SPD_FALL] = 14;
				
				_standup_mult = 0;
			}
			
			//grasshopper
			if(_enmtype == 1){
				_movespd[? SPD_WALK] = 6;
				_movespd[? SPD_BACK] = 4;
				_movespd[? SPD_PANIC] = 6;
			}
			
			if(instance_number(obj_boss2_mask) > 0){
				_hn_bosstimer = 30;
			}
			
			scr_enemyscript_init("step");
		} else {
			_maxblockcount = 4;
			if(_enmtype == 1){
				_maxblockcount = 0;
			}
			
			if(_enmtype == 1){
				if(_hn_shake > 0){
					_dodgezones = ["upper","doublekick"];
					_maxblockcount = 99;
				} else {
					_dodgezones = _dodgezones_start;
				}
			}
			
			_startTimer --;
			if(!_idiot && _startTimer <= 0){
				if(!_sequence_finished){
					scr_enemyscript_startsequence();
				} else {
					if(_displayobj != noone && instance_exists(_displayobj)){
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
							if(place_meeting(x,y,obj_battlezone) && !global._battlezone){
								_hn_c_timer = 0;
							}
						
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
											if(place_meeting(x,y,obj_event_other)){
												var ev = instance_place(x,y,obj_event_other);
												if(instance_exists(ev)){
													if(ev._event == "ringmaster"){
														//turn into ringmaster
														_enmtype = 0;
														
														_colorsinit = false;
														_althp = false;
														scr_enemyscript_colors();
														
														instance_create_depth(x,y,0,obj_st2_lightning);
														with(obj_bg){
															_thunder = true;
															_thunderalp = 1;
															_thundertimer = 0;
														}
														
														sfx_play(snd_secret);
														
														sfx_play_choose([snd_thunder1,snd_thunder2]);
														sfx_pitch(snd_thunder1, random_range(0.6,1.4));
														sfx_pitch(snd_thunder2, random_range(0.6,1.4));
														
														instance_destroy(ev.id);
													}
												}
											}
											
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
										
											voice_play_overlap_proximity(snd_henchie_notice);
										
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
								if(_hn_bosstimer > 0){
									_hn_bosstimer --;
								}
								
								switch(_hn_atkstate){
									case HENCHIE_ATK_NONE:
										_movetimer ++;
					
										scr_enemyscript_spd();
				
										if(_behaviortype != "hopping"){
											_hop_startpos[0] = x;
											_hop_startpos[1] = y;
										}
				
										if(_enmtype == -1){
											if(_fall_ko){
												_dodgezones = [];
											} else {
												_dodgezones = _dodgezones_start;
											}
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
											atk._timer = 8;
											atk._height = 20;
											atk._bothdir = true;
											atk._damage = ATK_KO;
											atk._type = "crouch_enm_hench";
											atk._delay = 4;
							
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
							
											_grabout = false;
							
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
																_hn_hopsnd = false;
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
					
										if(_hn_shake > 0){
											if(_hurttimer > 0 && _hn_slamdown_timer <= 0){
												_hn_shake -= 80;
												_hurttimer = 0;
											}
										}
										
										if(_hn_slamdown_timer > 0){
											_hn_slamdown_timer --;
											
											if(!_hn_slamdownsnd){
												sfx_play_choose_proximity([snd_henchie_slam1,snd_henchie_slam2,snd_henchie_slam3]);
												_hn_slamdownsnd = true;
											}
										} else {
											_hn_slamdownsnd = false;
										}
					
										if(_hn_hopstart && _behaviortype != "hopping"){
											sfx_play_proximity(snd_grasshopper_land);
											sfx_play_proximity(snd_grasshopper_shock);
											
											//shockwave attack
											with(obj_camera){
												_ampY = 35;
											}
											
											with(obj_dh_mask){
												if(_height == _groundlevel){
													_vspd = 20;
													_height += 4;
													_jump = true;
													_state = "shockwave";
													_shockwave = 75;
												}
											}
											
											_hn_cooldown = 0;
											_hn_slamdown = 0;
											
											_hn_shake = 55;
											if(_total_ailevel >= 6){
												_hn_shake = 40;
											}
											
											_hn_shocktimer = 999;
											_hn_shocks = 0;
							
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
											if(!_alt_tutorial){
												_hn_shake --;
											}
											_hn_shocktimer ++;
											if(_hn_shocks <= 5){
												with(obj_camera){
													if(_ampY < 5){
														_ampY = 5;
													}
												}
												
												if(_hn_shocktimer >= 9){
													instance_create_depth(x,y+42,0,obj_st2_enm1_shock);
													
													_hn_shocks ++
													_hn_shocktimer = 0;
												}
											}
										}
										if(_hn_shake <= 0 && _hn_endinit){
											_height = _groundlevel+2;
				
											_fall_ko = true;
											_nocked ++;
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
													if(_enmtype != -1 && !_alt_attack){
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
									
													if(_enmtype > -1 && _afterhop > 0){
														_hn_forceattack = true;
													}
													if(_hn_forceattack){
														_hn_timer = 9999;
													}
									
													if(!_hn_ring_fake && _hn_bosstimer <= 0){
														if(_enmtype == 0){
															//ringmaster
															if(has_trait(TRAIT_CROUCHKO)){
																remove_trait(TRAIT_CROUCHKO);
															}
															if(_falling || _fall_ko || _hurttimer > 0){
																if(!_hn_ring_hurt){
																	_hp -= ((4-_hn_rounds)*0.9)+_hn_dmgadd;
																	_hn_ring_hurt = true;
																}
															}
															if(_hn_setrounds && _hn_rounds > 0 && _hn_ring_hurt){
																if(_curstate != STATE_JUMP && _falling && _height > _groundlevel){
																	_vspd -= 3;
																}
																if(_standup){
																	_height = _groundlevel;
																}
																if(_hn_cooldown <= 0 && !_block && _blocktimer <= 0 && _anim != "blockko" && !_docrouchkick && !_falling){
																	if(_taunt <= 0 && _successparry <= 0 && _hn_jumpcd <= 0 && !_hn_attack && !_hn_hop){
																		_displayobj.image_index = 0;
																		_hn_atk_storepos = [x,y];
																		_curspd = [0,0];
																		_hn_rounds --;
																		_hn_atkstate = HENCHIE_ATK_ALT1;
																		_hn_ring_time = 0;
																			
																		voice_play_overlap_proximity(snd_ringmaster);
																	}
																}
															}
														} else if(_enmtype == 1){
															if(_hn_bosstimer <= 0 && _hn_shake <= 0){
																//grasshopper
																if(_hn_multjump){
																	_hn_timer = 9999;
																	if(!_block && !_attack && _hn_idle3_timer <= 0 && _blocktimer <= 0 && _anim != "blockko" && !_anim_transition && !_docrouchkick){
																		if(_curstate != STATE_JUMP && _hn_jumpcd <= 0 && _taunt <= 0 && _successparry <= 0){
																			_hn_jumpcd = scr_ailevel(4,random_range(15,40));
																			_dh = instance_nearest(x,y,obj_dh_mask);
																			if(_dh._mashact == 0 && _hn_jumpamnt < 3){
																				scr_hopspot(HOP_RANDOM_DH);
																				if(scr_enemyscript_calculatejump(0)){
																					if(!_hn_attack){
																						_hn_forceattack = false;
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
																if(!_hn_attack && !_hn_hop){
																	if(!_hn_multjump){
																		_hn_jumpamnt = 0;
																		_hn_multjump = true;
																	}
																}
															} else {
																_freeze = 5;
																_jumpingtimer = 0;
																_stuntimer = 0;
																_stunpunch = 0;
															}
														}
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
			
										if(!_death){
											//alt behavior
											if(_enmtype != -1){
												if(!_hn_attack && !_hn_hop && !_falling && _grabbed){
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
			
										if(!_death && !_hn_ring_fake){
											scr_enemyscript_detect();
										}
										if(_hn_ring_fake){
											_hn_wait ++;
											
											if(global._ringmaster <= 1){
												//the real one remains
												_hn_wait = 0;
												_hn_ring_fake = false;
												_hn_ring_hurt = false;
												if(_hn_rounds <= 0){
													_displayobj.image_index = 0;
													_didspot = true;
													_spottimer = 60;
													_dh = instance_nearest(x,y,obj_dh_mask);
													if(_dh != noone && instance_exists(_dh)){
														if(_dh.x < x){
															_curdir = DIR_L;
														} else {
															_curdir = DIR_R;
														}
													}
													
													sfx_play_proximity(snd_henchie_notice);
													
													add_trait(TRAIT_SPOT);
												}
											}
										
											if(_curstate == STATE_IDLE || _curstate == STATE_FOLLOW || _curstate == STATE_ATTACK){
												_behaviortype = "move";
												_curstate = STATE_WALK;
											}
											_movespd[? SPD_WALK] = max(12,19-(_hn_rounds*3));
											_interest = 0;
											_fastwalk = 4;
										
											//one hit kill
											if(_hn_ring_ground && _hn_wait >= 12){
												_hn_ring_fake_snd ++;
												if(_hn_ring_fake_snd >= random_range(30,120)){
													sfx_play_proximity(snd_henchie_notice);
													sfx_pitch(snd_henchie_notice,random_range(1.6,2));
													_hn_ring_fake_snd = 0;
												}
												
												//after image effect
												_hn_ring_afttimer ++;
												if(_hn_ring_afttimer >= 8){
													if(_displayobj != noone && instance_exists(_displayobj)){
														var im = instance_create_depth(x,y,_displayobj.depth+24,obj_enm_afterIM);
														im.image_blend = c_black;
														im.sprite_index = _displayobj.sprite_index;
														im.image_index = _displayobj.image_index;
														im._xspd = random_range(3,5)*choose(-1,1);
														im._yspd = random_range(3,5)*choose(-1,1);
													}
													_hn_ring_afttimer = 0;
												}
												
												if(!_hn_prepkill){
													if(_hurttimer > 0 || _falling || _fall_ko || _shockwave > 0){
														_hn_prepkill = true;
														_hn_prepkill_timer = _hn_num*2;
													}
												} else {
													_hn_prepkill_timer --;
													if(global._ringmaster > 1){
														if(_hn_prepkill_timer <= 0){
															spawn_fakevanish();
															
															sfx_play_proximity(snd_ghost);
											
															global._ringmaster --;
											
															killself();
														}
													}
												}
											} else {
												if(!_falling && !_fall_ko && _height <= _groundlevel){
													add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED]);
													_hn_ring_ground = true;
												}
											}
										} else {
											_movespd[? SPD_WALK] = 7;
										}
									break;
								
									case HENCHIE_ATK_ALT1:
										//ringmaster attack behavior
										if(has_trait(TRAIT_HURT)){
											remove_trait(TRAIT_HURT);
										}
										if(has_trait(TRAIT_GRAB)){
											remove_trait(TRAIT_GRAB);
										}
										if(has_trait(TRAIT_MASHED)){
											remove_trait(TRAIT_MASHED);
										}
										
										_grabout = false;
									
										//hp
										_displayhp = _displayhp + (_hp - _displayhp) * 0.12;
									
										//spawn fake henchies
										_hn_ring_time ++;
										if(_displayobj.image_index >= 5 && _hn_ring_time >= 32){
											_hn_atkstate = HENCHIE_ATK_NONE;
											_hn_ring_fake = true;
											_hn_ring_fake_snd = 60;
											_jump = true;
											_vspd = 12;
											_height = _groundlevel+1;
											_fall_ko = true;
											_standup = true;
											_dodge = true;
										
											global._ringmaster = 1;
										
											spawn_fakevanish();
										
											sfx_play_proximity(snd_ringmaster_spawn);
										
											for(var i = 0; i < 2; i++){
												_hn_prepkill = false;
												_hn_prepkill_timer = 0;
												_hn_num = 0;
												_hn_ring_ground = false;
												_hn_wait = 0;
												
												var enm = instance_create_depth(x, y-16, depth+16, obj_st2_enm1_mask);
												var spd = [-1, 1];
												enm._battlezone = true;
												enm._inactive = false;
												
												enm._hn_ring_fake = true;
												enm._hn_num = i+1;
												enm._enmtype = 0;
												enm._forceai = _ailevel;
												enm._didspot = true;
												enm._init_fallxspd = 10*spd[i];
												enm._jump = true;
												enm._fall_ko = true;
												enm._standup = true;
												enm._height = _groundlevel+4;
												enm._vspd = 16;
												enm._fixwall = true;
												enm._nocrouchatk = true;
												enm._hn_rounds = _hn_rounds;
												enm._hp = max(4, _hp);
												enm._displayhp = enm._hp;
												enm._althp = false;
												enm._maxhp = _maxhp;
												remove_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED], enm);
											
												global._ringmaster ++;
											}
										} else {
											_jump = false;
											_vspd = 0;
											_height = _groundlevel;
											_fall_ko = false;
											_falling = false;
											_standup = false;
										}
									
										clearpath();
										_curspd = [0,0];
										x = _hn_atk_storepos[0];
										y = _hn_atk_storepos[1];
									
										if(_death){
											_hn_atkstate = HENCHIE_ATK_NONE;
										}
									break;
								}
			
								scr_enemyscript_animation("step");
					
								//henchie sfx
								if(_displayobj != noone && instance_exists(_displayobj)){
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
												case "blockko_idle":
													_anim = "tr_blockko_idle";
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
														if(_hn_ring_fake){
															if(_curspd[0] <> 0 || _curspd[1] <> 0){
																_anim = "follow";
															}
														}
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
														if(_blockko_timer <= 0){
															_anim_prev = _anim;
															_anim = "melee_idle"+string(_curatk);
														} else {
															_anim_prev = _anim;
															_anim = "blockko";
														}
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
												_hn_idle3_timer = 30;
												
												_didko_timer ++;
												clearpath();
												
												if(_blockko_timer <= 0){
													_anim_prev = _anim;
													_anim = "melee_idle3";
												}
												
												if(_didko_timer >= 3 && _displayobj.image_index >= _displayobj.image_number-1){
													_did_ko = 0;
												}
												if(_hurttimer > 0){
													_did_ko = 0;
												}
											}
											
											if(_hn_idle3_timer > 0){
												_hn_idle3_timer --;
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
													if(!_hn_hopsnd){
														sfx_play_proximity(snd_grasshopper);
														_hn_hopsnd = true;
													}
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
									
											if(_hn_atkstate == HENCHIE_ATK_ALT1){
												_anim_prev = _anim;
												_anim = "ringmaster";
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
										if(compare_anim("blockko", "idle")){
											_displayobj.image_index = 0;
											_anim_tr_anim = "blockko_idle";
											_anim_tr_init = false;
											_anim_transition = true;
										}
					
										_anim_prev = _anim;
									}
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
		}
	} else {
		clearpath();
		with(_displayobj){
			image_speed = 0;
		}
	}
}