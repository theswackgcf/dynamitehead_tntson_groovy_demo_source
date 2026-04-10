{
	if(!global._debug){
		visible = false;
	} else {
		visible = global._showHitbox;
	}
	
	scr_sequence_pause();
	
	if(_combohit > 2){
		_combohit = 2;
	}
	
	//yell fix
	if(global._pause){
		if(audio_is_playing(snd_lanky_screamspin)){
			_ll_yelltime = audio_sound_get_track_position(snd_lanky_screamspin);
			audio_stop_sound(snd_lanky_screamspin);
			_ll_yellfix = true;
		}
		
		if(audio_is_playing(snd_lanky_dizzy)){
			_ll_dizzytime = audio_sound_get_track_position(snd_lanky_dizzy);
			audio_stop_sound(snd_lanky_dizzy);
			_ll_dizzyfix = true;
		}
	} else {
		if(_ll_yellfix){
			if(_ll_yelltime < audio_sound_length(snd_lanky_screamspin)){
				voice_play_proximity(snd_lanky_screamspin, global._bossvoices);
				if(_allsounds != undefined && _allsounds != -1 && ds_map_exists(_allsounds, snd_lanky_screamspin)){
					audio_sound_set_track_position(_allsounds[? snd_lanky_screamspin], _ll_yelltime);
				}
			}
			_ll_yellfix = false;
		}
		
		if(_ll_dizzyfix){
			if(_ll_dizzytime < audio_sound_length(snd_lanky_dizzy)){
				voice_play_proximity(snd_lanky_dizzy, global._bossvoices, 0.55);
				if(_allsounds != undefined && _allsounds != -1 && ds_map_exists(_allsounds, snd_lanky_dizzy)){
					audio_sound_set_track_position(_allsounds[? snd_lanky_dizzy], _ll_dizzytime);
				}
			}
			_ll_dizzyfix = false;
		}
		
		//phase loop
		if(global._cursong != -1 && audio_get_name(global._cursong) == "mus_boss2"){
			if(_phase < 2){
				//before phase 3
				if(audio_sound_get_track_position(global._cursong) >= _ll_looppoint){
					if(ds_map_exists(global._loops, audio_get_name(global._cursong))){
						audio_sound_set_track_position(global._cursong, global._loops[? audio_get_name(global._cursong)]);
					}
				}
			} else {
				//during phase 3
				if(!_ll_phaseloopset){
					if(ds_map_exists(global._loops, audio_get_name(global._cursong))){
						global._loops[? "mus_boss2"] = _ll_looppoint;
						audio_sound_set_track_position(global._cursong, global._loops[? audio_get_name(global._cursong)]);
						sfx_play(snd_dead);
					}
					global._looped = 0;
					_ll_phaseloopset = true;
				}
			}
		}
	}
	
	if(!global._pause){
		if(global._bossmusic){
			_ll_storepos = audio_sound_get_track_position(global._cursong);
			if(!_flyout && global._finalhit <= 0 && !audio_is_playing(mus_boss2)){
				mus_play(mus_boss2, global._bossgains[global._location]);
				audio_sound_set_track_position(global._cursong, _ll_storepos);
			}
		}
		
		scr_enemyscript_colors();
		
		if(!_init){
			for(var i = 0; i < instance_number(obj_boss2_spawn); i++){
				var curspawn = instance_find(obj_boss2_spawn,i);
				if(instance_exists(curspawn)){
					if(curspawn._dir == DIR_L){
						_ll_spawnleft = [curspawn.x,curspawn.y];
					} else if(curspawn._dir == DIR_R){
						_ll_spawnright = [curspawn.x,curspawn.y];
					}
				}
			}
			
			//save phase progress
			if(!global._bossstart){
				_phase = global._bossphase_save;
				with(obj_boss2_bg){
					_phase = global._bossphase_save+1;
				}
				if(_phase > 0){
					_hp = _phasehp[_phase-1];
					_hplastframe = _hp;
				}
			}
			
			if(!global._bossintro && !global._bossstart){
				mus_fade(0, 1000, true);
		
				global._bossstart = true;
			}
			
			if(_battlezone){
				_spawndir = "r";
				_sequence_finished = false;
				_sequence_id = seq_boss2;
			}
			_startTimer = 0;
			var bg = instance_nearest(x,y,obj_boss2_bg);
			if(instance_exists(bg)){
				if(bg._intro){
					if(global._delayspawn > 0){
						_startTimer = global._delayspawntime;
					}
				}
			}
			
			scr_enemyscript_init("step");
		} else {
			//light spot
			var bossbg = instance_find(obj_boss2_bg,0);
			if(!_finalko){
				if(instance_exists(bossbg) && bossbg._showlight > 0){
					_lighttimer = 0;
					_light_alpha = 0;
					_showlight = 0;
				} else {
					_showlight = 4;
				}
			} else {
				_showlight = 0;
			}
			if(instance_number(obj_boss_finalko) > 0){
				_finalko = true;
			}
			if(_showlight <= 0){
				_light_scalex = 1.4;
				if(instance_exists(_lightsource)){
					instance_destroy(_lightsource.id);
					_lightsource = noone;
				}
			} else {
				if(_lighttimer >= 4){
					if(_lightsource == noone){
						_lightsource = instance_create_depth(x-WIDTH*2,y+32,0,obj_lightsource);
						if(x > global._cameraX+(WIDTH/2)){
							_lightoffset[0] = 600;
						} else {
							_lightoffset[0] = -600;
						}
					} else {
						if(instance_exists(_lightsource)){
							_lightsource.x = x+_lightoffset[0];
							_lightsource.y = y+32+_lightoffset[1];
							_lightsource.image_xscale = _light_scalex;
							_lightsource.image_alpha = _light_alpha;
						}
					}
				}
			}
			
			if(_showlight > 0){
				_lighttimer ++;
				
				_light_alpha += 0.2;
				if(_light_alpha > 1){
					_light_alpha = 1;
				}
				
				if(!_sequence_finished){
					_lightoffset[0] = lerp(_lightoffset[0], 0, 0.03);
				} else {
					_lightoffset[0] = 0;
				}
				
				_showlight --;
			}
			
			_startTimer --;
			if(!_idiot && _startTimer <= 0){
				if(_ll_killskull){
					with(obj_enemyskull){
						var p = instance_create_depth(x,y,depth-1,obj_particle);
						p._type = "vanish";
						instance_destroy();
					}
					with(obj_enemybone){
						var p = instance_create_depth(x,y,depth-1,obj_particle);
						p._type = "bone";
						instance_destroy();
					}
					
					_ll_killskull = false;
				}
				
				if(!_sequence_finished){
					_ll_atk_timer = 9999;
					
					_stuntimer = 0;
					
					if(_start_setdir){
						scr_enemyscript_startsequence();
					}
				} else {
					_start_setdir = false;
					
					_begin = true;
					
					_do_walk_hop = true;
					
					//hench spawn object
					if(place_meeting(x,y,obj_boss2_henchspawn)){
						_ll_henchspawn = instance_place(x,y,obj_boss2_henchspawn);
					}
					
					//ai level
					
					//you kinda suck
					if(_ease_kd >= 3){
						_boss_easeout_prev = _boss_easeout;
						_boss_easeout = 1;
					}
					//you suck
					if(_ease_kd >= 6){
						_boss_easeout_prev = _boss_easeout;
						_boss_easeout = 2;
					}
					//you REALLY suck
					if(_ease_kd >= 9){
						_boss_easeout_prev = _boss_easeout;
						_boss_easeout = 3;
					}
					
					if(_boss_easeout_prev <> _boss_easeout){
						_boss_easeout_prev = _boss_easeout;
						_boss_easeout_timer = 2400;
					}
					if(_boss_easeout_timer > 0){
						_boss_easeout_timer --;
					} else {
						_boss_easeout = 0;
					}
					
					switch(_boss_easeout){
						case 0:
							_stunlock_hits_max = 1.8;
							_ailevel = 7;
						break;
						case 1:
							_stunlock_hits_max = 2.8;
							_ailevel = 5.2;
						break;
						case 2:
							_stunlock_hits_max = 4;
							_ailevel = 3.8;
						break;
						case 3:
							_stunlock_hits_max = 5;
							_ailevel = 2.7;
						break;
					}
			
					switch(_phase){
						case 0:
							_dmgmultiplier = 1.3;
						break;
						case 1:
							_dmgmultiplier = 1;
						break;
						case 2:
							_dmgmultiplier = 0.45;
						break;
					}
					
					if(_anim == "idle"){
						_behaviortype = "move";
						_curstate = STATE_FOLLOW;
						_dh = instance_nearest(x,y,obj_dh_mask);
					}
					
					//set breakpower here
					_breakpower = 0.32;
					if(_ll_atk5_act == 2){
						_breakpower = 0.1;
					}
					
					_movespd[? SPD_FALL] = 14+_addfallspd;
					if(_addfallspd > 0){
						_addfallspd -= 0.6;
					} else if(_addfallspd < 0){
						_addfallspd = 0;
					}
					
					if(_aftermash > 0){
						_mashed = false;
						_mashedobj = noone;
						_curdir = _mashdir;
						_addfallspd = _mashfling_spd;
						_vspd = 24;
						_height = _groundlevel+4;
						_falling = true;
					}
			
					var dh = instance_nearest(x,y,obj_dh_mask);
					if(instance_exists(dh)){
						_attackdist = clamp(32, distance_to_object(dh), 320);
					}
					
					if(_boss_active){
						global._curboss = self;
					
						if(_taunt <= 0){
							//show boss hp bar
							with(obj_gui){
								global._ui_stuff_alpha[3] = 1;
								ui_fade("boss", 1);
							}
						} else {
							//hide during taunt
							with(obj_gui){
								ui_fade("boss", 0);
							}
						}
					}
				
					if(_specialatk <= 0){
						scr_enemyscript_behavior("");
					}
	
					if(_ll_atk1_shake > 0){
						_curspd = [0,0];
						clearpath();
						_ll_atk1_shake --;
					}
	
					if(_freeze <= 0){
						_movetimer ++;
					
						scr_enemyscript_spd();
					
						if(!_death){
							//phase ending
						
							if(_phaseend_act == 0 && _hp <= _phasehp[_phase]){
								if(_grabbed){
									if(_slam){
										_slam = false;
										if(_phase >= 2){
											_phasehit_slam = true;
											_grabDrawX = x;
											_grabDrawY = y;
											_graboffset = [0,0];
											_height = _groundlevel;
										}
									}
									var dh = instance_nearest(x,y,obj_dh_mask);
									with(dh){
										force_throw_enemy();
									}
								}
								
								if(_mashedobj != noone && instance_exists(_mashedobj)){
									if(_mashedobj._mashact > 0 && _mashed){
										_mashedobj._attack = false;
										_mashedobj._attacktype = "";
										_mashedobj._mashtime = 0;
										_mashedobj._mashattack = 0;
										_mashedobj._mashact = 0;
										_mashedobj._mashobj = noone;
										_mashedobj._mashko = false;
										_mashedobj._mashsuccess = false;
										_mashedobj._mashpress = false;
										
										with(_mashedobj){
											//reset sounds/particles
											for(var s = 0; s < array_length(_mashsounds); s++){
												_mashsounds[s][2] = false;
											}
											for(var m = 0; m < array_length(_mashparticle); m++){
												_mashparticle[m][3] = false;
											}
										}
										
										_mashedobj = noone;
										_mashed = false;
									}
								}
								
								_grabout = false;
								
								_hp = _phasehp[_phase];
								_hurtanim = irandom_range(1,_hurtanims);
							
								_jump = true;
								_vspd = 18;
								
								with(obj_dh_mask){
									if(_state != "win"){
										if(_mashobj != noone){
											_attack = true;
											_attacktype = "idle";
										}
										_mashtime = 0;
										_mashattack = 0;
										_mashact = 0;
										_mashko = false;
										_mashfreeze = false;
										_mashobj = noone;
										_mashpress = false;
										_mashsuccess = false;
									
										_displayobj.image_index = 2;
									}
									
									//reset sounds/particles
									for(var s = 0; s < array_length(_mashsounds); s++){
										_mashsounds[s][2] = false;
									}
									for(var m = 0; m < array_length(_mashparticle); m++){
										_mashparticle[m][3] = false;
									}
								}
								
								with(obj_music){
									global.music_bus.effects[0] = global._storeMashed;
								}
							
								global._hitinst = self;
								
								voice_play_choose_proximity([snd_lanky_phasehit1,snd_lanky_phasehit2,snd_lanky_phasehit3,snd_lanky_phasehit4], global._bossvoices);
								
								if(_phase < 2){
									//play mid phase cutscene
									global._finalhit_phase = true;
									global._finalhit = 45;

									var p = instance_create_depth(x,y,depth, obj_particle);
									p._type = "hit_final";

									//show appropriate dh animation
									if(_dh_atk_inst != noone && instance_exists(_dh_atk_inst)){
										if(_dh_atk > 0){
											_dh_atk_inst._phasehit = 3;
											_dh_atk_inst._phasehit_frame = 0;
											if(_dh_atk_inst._height <= _dh_atk_inst._groundlevel){
												_dh_atk_inst._phasehit_anim = "melee_idle3";
											} else {
												_dh_atk_inst._phasehit_anim = "melee_jump";
												_dh_atk_inst._phasehit_frame = 3;
											}
										}
									}
									
									_slideoffspd = 45;
									_phaseend_bounceval = 20;
									var bzone = instance_place(x,y,obj_battlezone);
									if(instance_exists(bzone)){
										if(x < bzone.x){
											_curdir = DIR_R;
										} else {
											_curdir = DIR_L;
										}
									}
									_freedir = _curdir;
									_phaseend_act = 1;
									if(!_ll_stuckfix){
										if(place_meeting(x,y+16,obj_collidedown)){
											y -= 16;
										}
										if(place_meeting(x,y-16,obj_collideup)){
											y += 16;
										}
										_ll_stuckfix = true;
									}
								} else {
									//play ending cutscene
									
									_finalhit = true;
									
									var dh = instance_nearest(x,y,obj_dh_mask);
									if(instance_exists(dh) && distance_to_object(dh) <= 160){
										var frame = irandom_range(0, sprite_get_info(spr_boss2_kickass).num_subimages-1);
										dh._phasehit = 2;
										dh._phasehit_anim = "kickass_boss2";
										dh._phasehit_frame = frame;
										dh._height = _height;
										dh._kickass_obj = _displayobj;
										_phasehit = 2;
										_phasehit_anim = "kickass";
										_phasehit_frame = frame;
									}
									
									_boss_active = false;
									
									global._lightstop = true;
									global._finalhit_phase = false;
									global._finalhit = 90;
								}
							}
						
							if(_phaseend_act > 0){
								if(global._finalhit <= 0){
									if(!_phaseend_voice){
										voice_play_proximity(snd_lanky_screamspin, global._bossvoices);
										_phaseend_voice = true;
									}
								}
								
								_phaseend_voice_gain -= 0.0045;
								if(_phaseend_voice_gain <= 0){
									_phaseend_voice_gain = 0;
								}
								
								//gain sound
								var point_x = global._cameraX+(WIDTH/2);
								var point_y = global._cameraY+(HEIGHT/2);
								var offset = [global._proximityoffset[0], global._proximityoffset[1]];
								var disttopoint = [1-(clamp(diff_abs(x, point_x)/(WIDTH+offset[0]), 0, 1)),1-(clamp(diff_abs(y, point_y)/(HEIGHT+offset[1]), 0, 1))];
								var newgain = clamp(sqrt_value(disttopoint[0],disttopoint[1]), 0, 1);
								var pan = clamp(diff_abs(x, point_x)/(WIDTH+offset[0]), 0, 1);

								audio_sound_gain(snd_lanky_screamspin, newgain*_phaseend_voice_gain);
								
								_attack = false;
								_ll_atknum = 0;
								_ll_atktimer = 0;
							
								_block = false;
								_blockcount = 0;
							
								if(global._finalhit <= 0 && _height <= _groundlevel && _phaseend_bounceval > 1){
									_height = _groundlevel+4;
									_jump = true;
									_vspd = _phaseend_bounceval;
									_phaseend_bounceval *= 0.5;
								}
							
								if(has_trait(TRAIT_HURT)){
									remove_trait(TRAIT_HURT);
								}
								if(has_trait(TRAIT_GRAB)){
									remove_trait(TRAIT_GRAB);
								}
								
								_falling = false;
								_fall_ko = false;
								_standup = false;
								
								_curspd = [0,0];
								_curstate = STATE_OTHER;
							
								clearpath();
							}
						
							if(_phaseend_act == 1){
								_storex = x;
							}
							if(_phaseend_act >= 2){
								x = _storex;
								_curspd = [0,0];
								clearpath();
								
								_slideoffspd = 0;
								_freespd = false;
								_fallxspd = 0;
							}
						
							switch(_phaseend_act){
								case 1:
									_boss_active = false;
								
									if(!_dialogue){
										scr_startdialogue("dg_boss2", "u", 120, false, _phase);
										_dialogue = true;
									}
								
									_falling = false;
									_fall_ko = false;
									_standup = false;
									_freespd = true;
									_fallxspd = _slideoffspd*_freedir;
									_fallyspd = 0;
							
									_slideoffspd -= 0.18;
									if(_slideoffspd <= 0){
										_slideoffspd = 0;
									}
									
									if(_boundwall.left > 0 || _boundwall.right > 0){
										if(_slideoffspd <= 5){
											_slideoffspd = 5;
										}
										if(_boundwall.left > 0){
											_curdir = DIR_R;
										} else if(_boundwall.right > 0){
											_curdir = DIR_L;
										}
										_freedir = _curdir;
									}
								
									if(_slideoffspd <= 3.8 && _anim == "phaseend1_1" && floor(_displayobj.image_index) == 4){
										//jump out
										_displayobj.image_index = 0;
									
										_phaseend_time = 0;
										_phaseend_act = 2;
									}
								break;
								case 2:
									_dialogue = false;
								
									_phaseend_time ++;
									if(_phaseend_time >= 45){
										voice_play_choose_proximity([snd_lanky_grunt1,snd_lanky_grunt2,snd_lanky_grunt3,snd_lanky_grunt4,snd_lanky_grunt5], global._bossvoices, 0.5);
										
										_displayobj.image_index = 0;
									
										_ll_phaseend_offset = 0;
										_phaseend_time = 0;
										_phaseend_act = 3;
									}
								break;
								case 3:
									_light_scalex -= 0.1;
									if(_light_scalex < 0){
										_light_scalex = 0;
									}
								
									//fly up
									_freespd = false;
									_fallxspd = 0;
							
									_ll_phaseend_offset -= 60;
									_dispoffset[1] = _ll_phaseend_offset;
								
									if(!global._dialogue && _ll_phaseend_offset <= -1800){
										var bzone = instance_place(x,y, obj_battlezone);
										if(instance_exists(bzone)){
											bzone._curwave = global._bosswave_save;
											
											//hop into background
											with(obj_boss2_bg){
												_phase = other._phase+1;
												_act = 3;
											}
											
											//delay normal enemies spawning so player has more time to pick up stuff
											global._delayspawn = 10;
											global._delayspawntime = 120;
										
											//delete previous tnt boxes and items
											with(obj_tnt){
												var p = instance_create_depth(x,y-72,depth-6, obj_particle);
												p._type = "vanish";
												instance_destroy();
											}
											
											with(obj_itembox){
												var p = instance_create_depth(x,y-72,depth-6, obj_particle);
												p._type = "vanish";
												instance_destroy();
											}
											
											with(obj_item){
												var p = instance_create_depth(x,y-96,depth-6, obj_particle);
												p._type = "vanish";
												instance_destroy();
											}
										
											//spawn tnt box
											var tnt = instance_create_depth(bzone.x-240,bzone.y+100,0,obj_tnt);
											tnt._boxonly = true;
											tnt._flyhigh = true;
											tnt._collidewith = "noone";
											switch(_phase){
												case 0:
													tnt._itemarray = [ITEM_TOMATO,ITEM_CORN];
												break;
												case 1:
													tnt._itemarray = [ITEM_CORN,ITEM_CHOCO];
												break;
											}
										}
									
										_phaseend_act = 4;
									}
								break;
								case 4:
									if(instance_number_array(global._enemyArray) > 1 || instance_number(obj_enmspawn) > 0){
										global._delayspawn = 0;
										global._delayspawntime = 0;
									}
								
									//away from the battle during enemy encounters
									_displayobj.visible = false;
									_boss_active = false;
									_ll_stuckfix = false;
									if(place_meeting(x, y, obj_battlezone)){
										var bzone = instance_place(x,y, obj_battlezone);
										if(instance_exists(bzone)){
											x = bzone.bbox_left;
											y = bzone.bbox_top;
										
											if(instance_number_array(global._enemyArray) == 1 && instance_number(obj_enmspawn) == 0){
												bzone._curwave ++;
												global._enmorder = 0;
												if(is_array(bzone._enemies[bzone._curwave][0])){
													bzone._waveinit = false;
												} else {
													_ll_killskull = true;
													
													global._bosswave_save = bzone._curwave;
													
													//get back into battle
													if(_ll_spawndir == DIR_L){
														x = _ll_spawnleft[0];
														y = _ll_spawnleft[1];
														_spawnpos = [x,y];
														_offscreenpos = [x-170,y];
														_spawndir = "l";
													} else if(_ll_spawndir == DIR_R){
														x = _ll_spawnright[0];
														y = _ll_spawnright[1];
														_spawnpos = [x,y];
														_offscreenpos = [x+170,y];
														_spawndir = "r";
													}
													
													_start_setdir = true;
													
													_falling = false;
													_fall_ko = false;
													_standup = false;
													
													_stunlock_hits = 0;
													_boss_easeout_prev = 0;
													_boss_easeout = 0;
													_boss_easeout_timer = 0;
													
													_phaseend_voice_gain = 1;
													_phaseend_voice = false;
													
													_phase ++;
													global._bossphase_save = _phase;
													_phaseend_act = 0;
													_displayobj.visible = true;
													_curstate = STATE_IDLE;
													_dispoffset = [0,0];
												
													if(!has_trait(TRAIT_HURT)){
														add_trait(TRAIT_HURT);
													}
													if(!has_trait(TRAIT_GRAB)){
														add_trait(TRAIT_GRAB);
													}
													
													with(obj_boss2_bg){
														_spawndir = choose(DIR_R,DIR_L);
														_larryact_tr = 12;
														_acttimer = 0;
														_act = 0.5;
														_mine_phaseind_cur ++;
														
														voice_play_choose_proximity([snd_lanky_seethe1,snd_lanky_seethe2],global._bossvoices, 0.6);
														
														if(_mine_phaseind_cur > 1){
															_mine_phaseind_cur = 1;
														}
													}
													_startTimer = 160;
													
													scr_enemyscript_sequenceinit();
												}
											}
										}
									}
								break;
							}
							
							if(_phaseend_act < 3){
								//phase 1 atk 1
								if(_ll_atk1_atkact > 0 && (_curstate != STATE_JUMP && _stunlock_after <= 0 && (_falling || _ll_atk || _grabbed || _fall_ko || _successparry > 0))){
									_ll_atkactive = false;
								
									_ll_atk1_atkact = 0;
									_ll_atk1_timer = 0;
									_ll_atk1_attack = false;
									_ll_atk1_hop = false;
									_ll_atk1_jumpamnt = 0;
						
									_ll_atknum = 0;
								}
					
								if(!_attack && _ll_atk1_hop && _prev_hop_arc < _hop_arc){
									_displayobj.image_index = 0;
									_attacktype = "air";
									_attack = true;
									sfx_play_choose_proximity(global._swishsounds[2]);
								}
						
								if(_specialatk <= 0 && _attack && _attacktype == "air" && _displayobj.image_index >= 1){
									_afterim_active = 3;
									if(!_attackhb){
										_attackhb = true;
										var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
										atk._parentobj = self.id;
										atk._scale = [4.4, 4.7];
										atk._offset = [50,-86];
										atk._diffabs[1] = 145;
										atk._timer = 320;
										atk._damage = ATK_KO;
										atk._ptype = "enm";
										atk._type = "air_enm";
										atk._persist = true;
									}
								}
						
								/*if(_attack && _attacktype == "crouch" && _displayobj.image_index >= 3 && !_ll_crouchhit){
									//create ko attack
									var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
									atk._parentobj = self.id;
									atk._ptype = "enm";
									atk._scale = [8, 6];
									atk._offset = [160,0];
									atk._timer = 6;
									atk._height = 20;
									atk._bothdir = true;
									atk._damage = ATK_KO;
									atk._type = "crouch_enm";
							
									_ll_crouchhit = true;
								}
								if(!_attack){
									_ll_crouchhit = false;
								}*/
					
								//hop values
								if(_ll_atk1_hop){
									_hop_archeight = 1430;
									_hop_spd = 0.03;
								} else {
									_hop_archeight = _hop_archeight_def;
									_hop_spd = _hop_spd_def;
								}
					
								if(_ll_atk1_hop){
									if(_behaviortype == "hopping"){
										_afterim_active = 3;
									}
								}
					
								if(_ll_atk2_spawn > 0){
									_ll_atk2_spawn --;
								}
					
								if(_ll_atk1_attack){
									_curspd = [0,0];
									clearpath();
							
									switch(_ll_atk1_atkact){
										case 0:
											if(_displayobj.image_index >= _displayobj.image_number-1){
												_ll_atk1_atkact = 1;
											}
										break;
										case 1:
											scr_hopspot(HOP_RANDOM_DH);
								
											if(scr_enemyscript_calculatejump(0)){
												sfx_play_proximity(snd_jump);
									
												_ll_atk1_timer = 0;
												_ll_atk1_attack = false;
												_ll_atk1_atkact = 0;
												_ll_atk1_hop = true;
												_dohop = true;
											}
										break;
									}
								}
					
								if(_ll_atk1_hopstart && _behaviortype != "hopping"){
									_ll_atk1_shake = 6;
							
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
							
									_ll_atk1_hopstart = false;
								}
								if(_falling || _fall_ko){
									_ll_atk1_shake = 0;
								}
						
								//phase 1 atk 2
								if(_behaviortype == "hopping" && _phaseend_act == 0 && _hop_arcstart && _ll_atk2_attack){
									_grabout = false;
									_grabfall = false;
									_falling = false;
								
									_ll_atk2_timer ++;
									var spawnmine = false;
									if(diff_abs(x,xprevious) >= 8 || diff_abs(y,yprevious) >= 8){
										spawnmine = true;
									} else {
										if(x-global._cameraX <= 256){
											spawnmine = true;
										} else if(x-global._cameraX >= WIDTH-256){
											spawnmine = true;
										}
									}
									if(spawnmine){
										if(_ll_atk2_timer >= 8 && _ll_atk2_spawn <= 0){
											//spawn mine
											var mine = instance_create_depth(_displayobj.x, _displayobj.y, depth, obj_boss2_mine);
											mine._groundlevel = _groundlevel;
											mine._height = -_hop_arc;
											mine._xspd = _ll_atk2_xspd+random_range(-2.5,2.5);
											mine._yspd = random_range(-2.5,2.5);
											mine._fromlank = true;
											_ll_atk2_xspd += _ll_atk2_xspd_modify;
											_ll_atk2_timer = 0;
										}
									}
								}
						
								if(_afterhop > 0 && _ll_atk2_attack){
									if(instance_number(obj_boss2_mine) > 0 && _ll_atk2_spawn <= 0){
										_ll_atk2_spawn = 180;
									}
									_ll_atkactive = false;
									_ll_atk2_attack = false;
								}
							
								if(_ll_atk3_act > 0){
									_ll_atk_timer = 9999;
									_fall_ko = false;
									_standup = false;
								
									_specialatk = 5;
									_do_walk_hop = false;
								}
							
								if(_ll_atk3_after > 0){
									if(_attack && _attacktype == "blockko"){
										_attack = false;
										_attacktype = "";
									}
									if(_curstate == STATE_BLOCK){
										_block = false;
										_blocktimer = 0;
										_curstate = STATE_WALK;
									}
									_ll_atk3_after --;
								}
					
								//phase 2 atks
								if(_phase == 1 && _ll_atknum == 0 && _ll_atk3_act == 0){
									if(!has_trait(TRAIT_HURT)){
										add_trait(TRAIT_HURT);
									}
									if(!has_trait(TRAIT_BLOCKKO)){
										add_trait(TRAIT_BLOCKKO);
									}
									if(!has_trait(TRAIT_GRAB)){
										add_trait(TRAIT_GRAB);
									}
								}
						
								if(_phase == 1 && _ll_atknum == 0 && _ll_atk3_act > 0){
									if(has_trait(TRAIT_HURT)){
										remove_trait(TRAIT_HURT);
									}
									if(has_trait(TRAIT_BLOCKKO)){
										remove_trait(TRAIT_BLOCKKO);
									}
									if(has_trait(TRAIT_GRAB)){
										remove_trait(TRAIT_GRAB);
									}
								}
								
								//phase 2 atk 1
								if(_ll_atk3_act > 0){
									if(has_trait(TRAIT_MASHED)){
										remove_trait(TRAIT_MASHED);
									}
								} else {
									if(!has_trait(TRAIT_MASHED)){
										add_trait(TRAIT_MASHED);
									}
								}
								switch(_ll_atk3_act){
									case 1:
										if(!_shockwave && !_falling){
											_fall_ko = false;
											_standup = false;
											_height = _groundlevel;
											_vspd = 0;
											var clappos = instance_find(obj_boss2_clappos, irandom_range(0, instance_number(obj_boss2_clappos)-1));
											if(instance_exists(clappos) && diff_abs(x, clappos.x) > 96){
												_ll_atk3_curpos = [x,y];
												_ll_atk3_clappos = [clappos.x,clappos.y];
												_ll_atk3_offscreen = false;
												if(_ll_atk3_curclaps == 0){
													_ll_atk3_gotopos = [clappos.x,clappos.y];
												} else {
													_ll_atk3_offscreen = true;
													var dir = 1;
													if(x < global._cameraX+floor(WIDTH/2)){
														dir = -1;
													}
													_ll_atk3_gotopos = [x + (512*dir),y];
												}
												
												_ll_atk3_claptimer = 0;
										
												_ll_atk3_act = 2;
											}
										}
									break;
									case 2:
										if(!_shockwave && !_falling){
											_ll_atk3_quickflash = true;
								
											if(_behaviortype == "hopping"){
												_behaviortype = "move";
												_curstate = STATE_OTHER
											}
											_hop_arc = 0;
														
											_ll_atk3_clap = false;
											_block = true;
											_blocktimer = 2;
													
											var spd = 42;
									
											if(x < _ll_atk3_gotopos[0]){
												x += spd;
											} else if(x > _ll_atk3_gotopos[0]){
												x -= spd;
											}
											if(y < _ll_atk3_gotopos[1]){
												y += spd;
											} else if(y > _ll_atk3_gotopos[1]){
												y-= spd;
											}
							
											if(diff_abs(x, _ll_atk3_gotopos[0]) <= spd+16 && diff_abs(y, _ll_atk3_gotopos[1]) <= spd+16){
												x = _ll_atk3_gotopos[0];
												y = _ll_atk3_gotopos[1];
									
												_ll_atk3_quickflash = false;
									
												if(!_ll_atk3_offscreen){
													_displayobj.image_index = 0;
															
													_curstate = STATE_IDLE;
													_ll_atk3_act = 3;
												} else {
													_ll_atk3_offscreen = false;
										
													var dir = 1;
													if(x < global._cameraX+floor(WIDTH/2)){
														dir = -1;
													}
										
													x = _ll_atk3_clappos[0]-(512*dir);
													y = _ll_atk3_clappos[1];
													_ll_atk3_gotopos = [_ll_atk3_clappos[0],_ll_atk3_clappos[1]];
												}
											} else {
												_curstate = STATE_OTHER;
											}
														
											clearpath();
											_curspd = [0,0];
										}
									break;
									case 3:
										if(!_shockwave){
											if(place_meeting(x, y, obj_battlezone)){
												var bzone = instance_place(x,y, obj_battlezone);
												if(instance_exists(bzone)){
													if(x < bzone.x){
														_curdir = DIR_R;
													} else {
														_curdir = DIR_L;
													}
												}
											}
									
											_ll_atk3_quickflash = false;
									
											_attack = true;
											_attacktype = "vinyl";
										}
									break;
								}
								
								if(_ll_atk4_lightdelay > 0){
									_ll_atk4_lightdelay --
								} else {
									if(_ll_atk4_lighttype == 0){
										//off
										var dh = instance_nearest(x,y,obj_dh_mask);
										if(_ll_atk4_poses > 1 && _ll_atk4_poses <= _ll_atk4_maxposes-4 && _ll_lightgag == 0 && distance_to_object(dh) < (WIDTH-256)){
											_ll_lightgag = 1;
											_ll_lightgagsfx = [false,false];
											_anim = "lightgag";
											_displayobj.image_index = 0;
												
											sfx_play_choose_proximity([snd_taunt1,snd_taunt2,snd_taunt3,snd_taunt4,snd_taunt5]);
										}
										if(_ll_lightgag <> 1){
											if(_ll_atk4_poses >= _ll_atk4_maxposes-3){
												voice_play_choose_proximity([snd_lanky_lights2,snd_lanky_lights3],global._bossvoices);
												sfx_pitch(snd_lanky_lights2, random_range(0.97,1.07));
												sfx_pitch(snd_lanky_lights3, random_range(0.97,1.07));
											} else {
												voice_play_choose_proximity([snd_lanky_lights1,snd_lanky_lights4,snd_lanky_lights5],global._bossvoices);
											}
										}
										_displayobj.visible = true;
										if(global._lightsout){
											sfx_play(snd_light_on);
											global._lightsout = false;
											scr_lightsout_affect();
										}
										_ll_atk4_lighttype = -1;
									}
								}
						
								if(_ll_atk4_act > 0){
									_hop_arc = 0;
									_blockcount = 0;
									if(_hurttimer > 0 || _falling || _taunt > 0 || _shockwave){
										_ll_atkactive = false;
									
										_ll_atknum = 0;
										_ll_atk4_act = 0;
										_ll_atk4_afterattack = true;
										_ll_atk4_dopose = false;
										if(!has_trait(TRAIT_GRAB)){
											add_trait(TRAIT_GRAB);
										}
									}
									if(_phaseend_act == 0){
										_curstate = STATE_OTHER;
										_curspd = [0,0];
										clearpath();
									}
								}
							
								if(_ll_atk5_act > 0){
									if(_hurttimer > 0 || _falling || _grabbed){
										_ll_atk5_act = 0;
										_ll_atk5_spinamp = 0;
										_ll_atk5_spintimer = 0;
										_ll_atk5_endspin = 0;
									}
									_jumptopos = [x,y];
								}
						
								//phase 2 atk 2
						
								switch(_ll_atk4_act){
									case 1:
										if(!_shockwave && !_falling){
											if(abs(_slidespd) < 3){
												_fall_ko = false;
												_standup = false;
												_height = _groundlevel;
												_vspd = 0;
								
												_displayobj.visible = false;
												if(!global._lightsout){
													sfx_play(snd_light_off);
													global._lightsout = true;
													scr_lightsout_affect();
												}
												_ll_atk4_dopose = false;
												_ll_atk4_timer ++;
								
												if(has_trait(TRAIT_HURT)){
													remove_trait(TRAIT_HURT);
												}
												if(has_trait(TRAIT_GRAB)){
													remove_trait(TRAIT_GRAB);
												}
								
												if(_ll_atk4_timer >= 40){
													//jump to random pos
													var bzone = instance_place(x,y,obj_battlezone);
													if(instance_exists(bzone)){
														_jumptopos = [random_range(bzone.bbox_left+_ll_atk4_offset,bzone.bbox_right-_ll_atk4_offset), random_range(bzone.bbox_top+_ll_atk4_offset,bzone.bbox_bottom-_ll_atk4_offset)];
														if(scr_enemyscript_calculatejump(0)){
															x = _jumptopos[0];
															y = _jumptopos[1];
															
															_ll_atk4_lighttype = 0;
															_ll_atk4_lightdelay = 2;
															
															_ll_atk4_posetype = irandom_range(1, _ll_atk4_maxframes);
															_ll_atk4_act = 2;
															_ll_atk4_timer = 0;
														}
													} else {
														_ll_atkactive = false;
											
														_ll_atk4_poses = 0;
														_ll_atk4_afterattack = true;
														_ll_atknum = 0;
														_ll_atk4_act = 0;
														if(!has_trait(TRAIT_GRAB)){
															add_trait(TRAIT_GRAB);
														}
													}
												}
											} else {
												_ll_atkactive = false;
											
												_ll_atk4_dopose = false;
												_ll_atk4_poses = 0;
												_ll_atk4_afterattack = true;
												_ll_atknum = 0;
												_ll_atk4_act = 0;
										
												if(!has_trait(TRAIT_HURT)){
													add_trait(TRAIT_HURT);
												}
												if(!has_trait(TRAIT_GRAB)){
													add_trait(TRAIT_GRAB);
												}
											}
										}
									break;
									case 2:
										if(!_shockwave && !_falling){
											_ll_atk4_dopose = true;
								
											if(!has_trait(TRAIT_HURT)){
												add_trait(TRAIT_HURT);
											}
								
											_ll_atk4_timer ++;
								
											var maxvalue2 = clamp(10, 250-((_ll_atk4_poses-1)*76), 75);
								
											if(_ll_atk4_timer >= maxvalue2){
												if(_ll_atk4_poses > 0){
													_ll_atk4_poses --;
													_ll_atk4_act = 1;
													_ll_atk4_timer = 0;	
												} else {
													_ll_atkactive = false;
											
													_ll_atk4_dopose = false;
													_ll_atk4_poses = 0;
													_ll_atk4_afterattack = true;
													_ll_atknum = 0;
													_ll_atk4_act = 0;
													if(!has_trait(TRAIT_GRAB)){
														add_trait(TRAIT_GRAB);
													}
												}
											}
										}
									break;
								}
						
								if(_ll_atk4_afterattack){
									_displayobj.visible = true;
									if(global._lightsout){
										sfx_play(snd_light_on);
										global._lightsout = false;
										scr_lightsout_affect();
									}
								
									_ll_atk4_afterattack = false;
								}
						
								//phase 3 atks
								if((_phase == 2 && _ll_atknum == 1 && _ll_atk5_act == 0) || (_phase == 2 && _ll_atknum == 2 && _ll_atk6_act == 0)){
									if(!has_trait(TRAIT_HURT)){
										add_trait(TRAIT_HURT);
									}
									if(!has_trait(TRAIT_GRAB)){
										add_trait(TRAIT_GRAB);
									}
									if(!has_trait(TRAIT_BLOCKKO)){
										add_trait(TRAIT_BLOCKKO);
									}
								}
						
								if((_phase == 2 && _ll_atknum == 1 && _ll_atk5_act >= 2) || (_phase == 2 && _ll_atknum == 2 && _ll_atk6_act > 0)){
									if(has_trait(TRAIT_HURT)){
										remove_trait(TRAIT_HURT);
									}
									if(has_trait(TRAIT_GRAB)){
										remove_trait(TRAIT_GRAB);
									}
									if(has_trait(TRAIT_BLOCKKO)){
										remove_trait(TRAIT_BLOCKKO);
									}
								}
						
								if(_ll_atk5_act > 0){
									_behaviortype = "spinning";
								}
						
								switch(_ll_atk5_act){
									case 1:
										if(!has_trait(TRAIT_HURT)){
											add_trait(TRAIT_HURT);
										}
									
										if(_falling || _fall_ko){
											_falling = false;
											_fall_ko = false;
										}
								
										_specialatk = 5;
										_attack = false;
									
										_block = false;
										_blocktimer = 0;
										_hurttimer = 0;
										_stuntimer = 0;
								
										_spin = true;
								
										//pre attack spinning
										_curspd = [0,0];
										clearpath();
									
										_ll_atk5_spintimer ++;
										_ll_atk5_spinamp += 0.36;
										_dispoffset[0] = sin(_ll_atk5_spintimer/2)*_ll_atk5_spinamp;
										_dispoffset[1] = cos(_ll_atk5_spintimer/2)*(_ll_atk5_spinamp/2);
										if(_ll_atk5_spinamp >= 46){
											_freedir = choose(DIR_L,DIR_R);
											_freedir_v = choose(DIR_U, DIR_D);
											
											_spin = true;
											_spinhits = 0;
											_falldecay = 1;
											
											var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
											atk._parentobj = self.id;
											atk._ptype = "all";
											atk._scale = [5.5, 4];
											atk._offset = [0,-48];
											atk._timer = 999;
											atk._height = 0;
											atk._delay = 24;
											atk._type = "spin_enm";
											atk._damage = ATK_KO;
											atk._persist = true;
											atk._canparry = false;
									
											_ll_atk5_act = 2;
										} else {
											_freespd = false;
											_fallxspd = 0;
											_fallyspd = 0;
											_slidespd = 0;
										}
									break;
									case 2:
										if(_falling || _fall_ko){
											_falling = false;
											_fall_ko = false;
										}
								
										_specialatk = 0;
								
										//spinning around
										_curstate = STATE_OTHER;
										_curspd = [0,0];
										clearpath();
										
										_attack = false;
										_afterhop = 0;
								
										_slidespd = 0;
									
										var spd = 14;
									
										_freespd = true;
									
										_block = false;
										_blocktimer = 0;
										_blockcount = 0;
									
										_walltouch = 0;
										_walltouch_y = 0;
										_fixwall = false;
									
										_afterim_active = 3;
									
										var maxbonk = 16;
									
										//set speed which depends on direction
										_fallxspd = (spd+(_wallbonks*0.35))*_freedir;
										_fallyspd = ((spd/2)+(_wallbonks*0.35))*_freedir_v;
									
										//ending
										if(_wallbonks >= maxbonk || abs(_fallxspd) < 4){
											_ll_atk_timer = 0;
											_ll_atk5_endspin ++;
											if(_ll_atk5_endspin >= 30){
												_displayobj.image_index = 0;
											
												_hurttimer = 0;
											
												voice_play_proximity(snd_lanky_dizzy, global._bossvoices, 0.55);
												sfx_pitch(snd_lanky_dizzy, random_range(0.85,1.12));
											
												_stuntimer = 320;
												_spin = false;
										
												_freespd = false;
												_fallyspd = 0;
											
												_ll_atkactive = false;
											
												_wallbonks = 0;
												_behaviortype = "idle";
											
												_ll_atk_timer = 0;
											
												_ll_atk5_act = 0;
												_ll_atk5_spinamp = 0;
												_ll_atk5_spintimer = 0;
												_ll_atk5_endspin = 0;
												_specialatk = 0;
											
												_ll_atknum = 0;
											}
										}
									break;
								}
						
								if(_ll_atk6_act > 0){
									_curstate = STATE_OTHER;
									_curspd = [0,0];
									clearpath();
								}
							
								if(_hurttimer > 0 || _falling || _grabbed || _shockwave){
									voice_stop(snd_lanky_dizzy);
								}
						
								if(!_standup && (_falling || _fall_ko || _grabbed) && _ll_atk6_act > 0){
									_ll_atkactive = false;
									_ll_atk6_act = 0;
									_ll_atknum = 0;
								}
						
								switch(_ll_atk6_act){
									case 1:
										//crouch down
										_attack = false;
										_ll_atk6_timer ++;
										if(_ll_henchspawn != noone && instance_exists(_ll_henchspawn)){
											if(_ll_henchspawn._collideborder <= 0){
												if(instance_number_array(global._enemyArray) <= 2){
													if(_ll_atk6_timer >= 48){
														_specialatk = 0;
													
														//jump up and spawn henchies
														for(var i = 0; i < 2; i++){
															var enm = instance_create_depth(x, y-16, depth+16, obj_st2_enm1_mask);
															var spd = [-1, 1];
															enm._forceai = _ailevel;
															enm._didspot = true;
															enm._init_fallxspd = 10*spd[i];
															enm._jump = true;
															enm._fall_ko = true;
															enm._nocked ++;
															enm._standup = true;
															enm._height = _groundlevel+4;
															enm._vspd = 16;
															enm._fixwall = true;
															enm._nocrouchatk = true;
															enm._maxhp = 4;
															enm._hp = enm._maxhp;
														}
										
														sfx_play_proximity(snd_lank_hench);
										
														_height = _groundlevel+2;
														_vspd = 14;
														_jump = true;
														_standup = true;
														_ll_atk6_act = 2;
													} else {
														_specialatk = 5;
													}
												} else {
													//too many enemies. dont spawn anymore
													_ll_atkactive = false;
													_ll_atknum = 1;
													_ll_atk6_timer = 0;
													_ll_atk6_act = 0;
												}
											} else {
												//hench spawn collides with battle border
												_ll_atkactive = false;
												_ll_atknum = 1;
												_ll_atk6_timer = 0;
												_ll_atk6_act = 0;
											}
										} else {
											//no hench spawn object
											_ll_atkactive = false;
											_ll_atknum = 1;
											_ll_atk6_timer = 0;
											_ll_atk6_act = 0;
										}
									break;
									case 2:
										if(_height <= _groundlevel){
											_specialatk = 0;
											_standup = false;
											_ll_atkactive = false;
											_ll_atk6_act = 0;
											_ll_atk6_timer = 0;
											_ll_atknum = 0;
										}
									break;
								}
						
								if(_stuntimer > 0 && (_falling || _fall_ko || _blocktimer > 0)){
									_stun = false;
									_stunact = 0;
									_stuntimer = 0;
								}
							}
						}
					
						if(_phaseend_act < 3){
							if(_ll_atknum == 0){
								_ll_atk_timer = 0;
								_ll_atknum = irandom_range(1,2);
								if(_phase == 0){
									_ll_atknum = 2;
								}
								if(_phase == 1){
									if(_hp <= _phasehp[_phase]+20){
										_ll_atknum = 2;
									} else {
										_ll_atknum = 1;
									}
								}
							}
						
							//immediate attack after stunlock dodging is done
							if(_height <= _groundlevel && _stunlock_after > 0 && _ll_atknum > 0 && _ll_atk_timer < 9999){
								_ll_atk_timer = 9999;
								_behaviortype = "move";
							}
						
							var dhcrouchdist = 320;
						
							//dodge dh's crouch and slide attacks
							if(_behaviortype == "move" && _specialatk <= 0 && _height <= _groundlevel && !_ll_atkactive && !_attack){
								if(!_falling && !_fall_ko && !_standup){
									_dh = instance_nearest(x,y,obj_dh_mask);
									if(_dh != noone && instance_exists(_dh)){
										if(distance_to_object(_dh) <= dhcrouchdist && (_dh._crouch || _dh._slide || _dh._shield)){
											_ll_atk_timer = 9999;
										}
									}
								}
							}
							if(_phase == 0 && _behaviortype == "hopping" && _hop_arcstart && !_ll_atk2_attack){
								_dh = instance_nearest(x,y,obj_dh_mask);
								if(_dh != noone && instance_exists(_dh)){
									if(distance_to_object(_dh) <= dhcrouchdist && (_dh._crouch || _dh._slide || _dh._shield)){
										_ll_atk2_attack = true;
									}
								}
							}
							
							//IDIOT
							if(_anim == "idle1" || _anim == "idle2" || _anim == "idle3"){
								_ll_dogshit ++;
							} else {
								_ll_dogshit --;
								if(_ll_dogshit <= 0){
									_ll_dogshit = 0;
								}
							}
							
							if(_ll_dogshit >= 24){
								_ll_atk_timer = 9999;
							}
							
							if(_hurttimer == 0){
								switch(_behaviortype){
									case "move":
										if(_specialatk <= 0){
											if(_curstate == STATE_WALK){
												scr_enemyscript_behavior("walk");
											} else {
												_randoffset = [random_range(-_walkdist[0],_walkdist[0]),random_range(-_walkdist[1],_walkdist[1])];
												_multdist = 1;
											}
											if(_curstate == STATE_FOLLOW){
												var dh = instance_nearest(x,y,obj_dh_mask);
												if(instance_number_array(global._enemyArray) == 1 || (instance_exists(dh) && distance_to_object(dh) < _attackdist)){
													scr_enemyscript_behavior("follow");
												} else {
													_curstate = STATE_WALK;
												}
											}
										}
								
										//ATTACKS
								
										_ll_atk_addtimer = true;
										if(_hurttimer > 0 || _attack || _blocktimer > 0 || _falling || _grabbed){
											_ll_atk_addtimer = false;
										}
								
										var maxvalue = scr_ailevel(170,random_range(260,480));
								
										switch(_phase){
											case 0:
												switch(_ll_atknum){
													case 1:
														//phase 1 attack 1 - henchlike jump
														if(!_ll_atk1_attack && !_ll_atk1_hop){
															var dh = instance_nearest(x, y, obj_dh_mask);
															if(distance_to_object(dh) >= HEIGHT*0.22 && distance_to_object(dh) < WIDTH*0.9){
																if(_ll_atk_addtimer){
																	_ll_atk_timer ++;
																}
															} else {
																_ll_atk1_addtimer = false;
															}
														}
									
														if(_ll_atk1_jumpcd > 0){
															_ll_atk1_jumpcd --;
														}
									
														if(_panictimer > 0){
															_ll_atkactive = false;
														
															_ll_atk_timer = 0;
															_ll_atk1_attack = false;
															_ll_atk1_atkact = 0;
															_ll_atk1_hop = false;
													
															_ll_atknum = 0;
														}
									
									
														if(_ll_atk1_shake <= 0){
															if(_ll_atk1_multjump){
																_ll_atk_timer = 9999;
																if(_curstate != STATE_JUMP && _ll_atk1_jumpcd <= 0 && _taunt <= 0){
																	_ll_atk1_jumpcd = scr_ailevel(4,random_range(15,40));
																	_dh = instance_nearest(x,y,obj_dh_mask);
																	if(_dh._mashact == 0 && _ll_atk1_jumpamnt < _ll_atk1_maxjump){
																		_ll_atkactive = true;
																	
																		_ll_atk1_jumpamnt ++;
																		_displayobj.image_index = 0;
																		_ll_atk1_hop = false;
																		_ll_atk1_attack = true;
																		_ll_atk1_atkact = 0;
																		if(_ll_atk1_jumpamnt > 0){
																			_ll_atk1_atkact = 1;
																		}
																		_ll_atk_timer = 0;
																	} else {
																		_ll_atkactive = false;
																	
																		_ll_atknum = 0;
																
																		_attack = false;
																		_ll_atk1_multjump = false;
																		_ll_atk_timer = 0;
																		_ll_atk1_hop = false;
																		_ll_atk1_attack = false;
																		_ll_atk1_hopstart = false;
																		_ll_atk1_shake = 0;
																	}
																}
															}
															if(!_ll_atk1_attack && !_ll_atk1_hop && _ll_atk_timer >= maxvalue){
																if(!_ll_atk1_multjump){
																	_ll_atk1_jumpamnt = 0;
																	_ll_atk1_multjump = true;
																}
															}
														} else {
															_freeze = 5;
															_jumpingtimer = 0;
															_stuntimer = 0;
														}
													break;
													case 2:
														//phase 1 attack 2 - jump and throw mines
														if(!_ll_atk2_attack){
															var dh = instance_nearest(x, y, obj_dh_mask);
															if(diff_abs(y, dh.y) <= 260 && distance_to_object(dh) >= WIDTH*0.3 && distance_to_object(dh) < WIDTH*0.9){
																if(_ll_atk_addtimer){
																	_ll_atk_timer ++;
																}
															} else {
																_ll_atk1_addtimer = false;
															}
													
															if(_curstate != STATE_JUMP && _taunt <= 0){
																if(_ll_atk_timer >= maxvalue*0.2){
																	var dh = instance_nearest(x,y,obj_dh_mask);
																	if(instance_exists(dh)){
																		var hopto = [x,y];
																		if(dh.x < x){
																			hopto[0] = dh.x-320;
																		} else {
																			hopto[0] = dh.x+320;
																		}
																		if(dh.y < y){
																			hopto[1] = dh.y-diff_abs(y,dh.y);
																		} else {
																			hopto[1] = dh.y+diff_abs(y,dh.y);
																		}
																	
																		_grabout = false;
																		_grabfall = false;
																		_falling = false;			
																	
																		_jumptopos = [hopto[0],hopto[1]];
																		if(scr_enemyscript_calculatejump(0)){
																			_ll_atkactive = true;
																		
																			_ll_atk_timer = 0;
																			_ll_atk2_timer = 0;
																			_ll_atk2_xspd = _ll_atk2_xspd_init;
																			_ll_atk2_attack = true;
																			_dohop = true;
																		}
																	}
																}
															}
														}
													break;
												}
											break;
											case 1:
												switch(_ll_atknum){
													case 1:
														//phase 2 attack 1 - dust projectiles
														if(_ll_atk3_act == 0){
															if(!_shockwave){
																if(_ll_atk_addtimer){
																	if(!_falling && !_fall_ko && _hurttimer <= 0){
																		_ll_atk_timer ++;
																	}
																}
													
																if(!_falling && !_fall_ko && !_standup && _ll_atk_timer >= maxvalue*0.7){
																	_ll_atkactive = true;
															
																	_ll_atk3_curclaps = 0;
																	_ll_atk3_claps = 8;
																	_ll_atk3_act = 1;
																}
															}
														}
													break;
													case 2:
														//phase 2 attack 2 - lights off
														if(_ll_atk4_act == 0){
															if(!_shockwave && !_falling){
																if(_ll_atk_addtimer){
																	_ll_atk_timer ++;
																}
													
																if(_ll_atk_timer >= maxvalue*0.45){
																	//jump to random pos
																	var bzone = instance_place(x,y,obj_battlezone);
																	if(instance_exists(bzone)){
																		_jumptopos = [random_range(bzone.bbox_left+_ll_atk4_offset,bzone.bbox_right-_ll_atk4_offset), random_range(bzone.bbox_top+_ll_atk4_offset,bzone.bbox_bottom-_ll_atk4_offset)];
																		if(scr_enemyscript_calculatejump(0)){
																			x = _jumptopos[0];
																			y = _jumptopos[1];
																			
																			_ll_atkactive = true;
															
																			_ll_atk4_posetype = irandom_range(1, _ll_atk4_maxframes);
																			_ll_atk4_poses = _ll_atk4_maxposes;
																			_ll_atk4_timer = 0;
																			_ll_atk4_act = 1;
																		}
																	} else {
																		_ll_atkactive = false;
																
																		_ll_atk4_poses = 0;
																		_ll_atk4_afterattack = true;
																		_ll_atknum = 0;
																		_ll_atk4_act = 0;
																		if(!has_trait(TRAIT_GRAB)){
																			add_trait(TRAIT_GRAB);
																		}
																	}
																}
															}
														}
													break;
												}
											break;
											case 2:
												switch(_ll_atknum){
													case 1:
														//phase 3 attack 1 - spin around
														if(_ll_atk5_act == 0){
															if(_inview && instance_number(obj_st2_enm1_mask) == 0){
																if(_ll_atk6_act > 0){
																	_ll_atk_timer = 0;
																}
																if(_ll_atk_addtimer){
																	_ll_atk_timer ++;
																}
													
																if(_ll_atk_timer >= maxvalue){
																	_ll_atkactive = true;
															
																	/*if(_anim != "spin1"){
																		_anim = "spin1";
																		_displayobj.image_index = 0;
																	}*/
																	_ll_atk5_spinamp = 0;
																	_ll_atk_timer = 0;
																	_ll_atk5_act = 1;
																}
															} else {
																_ll_atk_timer = 0;
															}
														}
													break;
													case 2:
														//phase 3 attack 2 - spawn henchies
														if(_ll_atk6_act == 0){
															if(_ll_atk5_act > 0){
																_ll_atk_timer = 0;
															}
															if(_ll_atk_addtimer){
																_ll_atk_timer ++;
															}
													
															if(_ll_atk_timer >= maxvalue*0.92){
																_ll_atkactive = true;
															
																/*if(_anim != "hench1"){
																	_anim = "hench1";
																	_displayobj.image_index = 0;
																}*/
																_ll_atk_timer = 0;
																_ll_atk6_timer = 0;
																_ll_atk6_act = 1;
															}
														}
													break;
												}
											break;
										}
									break;
									case "attack":
										scr_enemyscript_behavior("attack");
									break;
								}
							}
				
							if(_ll_atk5_act > 0){
								_anim_prev = _anim;
								_anim_transition = false;
								_ll_atk6_act = 0;
								_ll_atk6_timer = 0;
							}
							if(_ll_atk6_act > 0){
								_anim_prev = _anim;
								_anim_transition = false;
								_ll_atk5_act = 0;
								_ll_atk5_spinamp = 0;
								_ll_atk5_spintimer = 0;
								_ll_atk5_endspin = 0;
							}
				
							if(!_death){
								if(_attack){
									if(_hurttimer > 0 || _falling || _behaviortype == "hopping"){
										if(_attacktype == "idle"){
											_ll_atk = false;
											_ll_atk_prepare = 0;
										}
										_attack = false;
										_attacktype = "";
									}
									switch(_attacktype){
										case "idle":
											if(_ll_atk_prepare > 0){
												_ll_atktimer = 5;
												_curspd = [0,0];
												clearpath();
											
												_ll_atk_prepare --;
											} else {
												if(!_ll_atk){
													_curstate = STATE_SLIDE;
													_fixwall = true;
													_slide = true;
													_slideact = 1;
													_slidespd = 32*_curdir;
													_slidedir = _curdir;
													_slidedecel = 0.01;
										
													sfx_play_proximity(snd_lanky_attack);
										
													var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
													atk._parentobj = self.id;
													atk._ptype = "enm";
													atk._scale = [4.3, 4];
													atk._offset = [0,0];
													atk._timer = 120;
													atk._type = "run_enm";
													atk._damage = ATK_NORM;
													atk._combo = true;
													atk._persist = true;
										
													_ll_atktimer = 99;
													_ll_atk = true;
												} else {
													var dh = instance_nearest(x,y,obj_dh_mask);
													if(y < dh.y){
														if(!place_meeting_array(x,y+8,_collide_other)){
															y += 8;
														}
													} else if(y > dh.y){
														if(!place_meeting_array(x,y-8,_collide_other)){
															y -= 8;
														}
													}
													if(abs(_slidespd) <= 1){
														_attack = false;
													}
												}	
											}
										break;
										case "blockko":
											if(_anim == "blockko" && _displayobj.image_index >= _displayobj.image_number-1){
												_attack = false;
												_attacktype = "";
											}
										break;
									}
								} else {
									_ll_atk_dusttimer = 0;
									_ll_atk_prepare = 40/clamp(1,_phase+1,3);
									_ll_atk = false;
									_ll_atktimer = 0;
								}
							
								if(_attacktype == "vinyl"){
									if(!_shockwave){
										_ll_atk3_claptimer ++;
										if(_displayobj.image_index >= 4 && !_ll_atk3_clap){
											var vinyl = instance_create_depth(x+(100*_curdir), y+random_range(32,64), _displayobj.depth, obj_boss2_vinyl_projectile);
											vinyl._damage = ATK_NORM;
											vinyl._curdir = _curdir;
											vinyl._startheight = random_range(0,96);
										
											sfx_play_proximity(snd_lanky_vinyl);
										
											_ll_atk3_clap = true;
										}
										var maxframe = 7;
										if(_displayobj.image_index >= maxframe){
											_displayobj.image_index = maxframe;
										}
										if(_ll_atk3_claptimer >= 3 && _displayobj.image_index >= maxframe){
											_displayobj.image_index = 0;
											if(_ll_atk3_claps > 0){
												_ll_atk3_claptimer = 0;
												_ll_atk3_curclaps ++;
												_ll_atk3_claps --;
												_ll_atk_timer = 999;
												_ll_atk3_act = 1;
											} else {
												_ll_atkactive = false;
													
												_curstate = STATE_WALK;
										
												_attack = false;
												_attacktype = "";
										
												_ll_atk3_after = 45;
										
												_ll_atknum = 0;
												_ll_atktimer = 0;
												_ll_atk3_act = 0;
												_ll_atk3_curclaps = 0;
												_ll_atk3_claps = 0;
												_ll_atk3_offscreen = false;
												_ll_atk3_curpos = [x,y];
												_ll_atk3_clappos = [x,y];
												_ll_atk3_gotopos = [x,y];
												_ll_atk3_quickflash = false;
											}
										}
									}
								}
						
								//dodge mashing
								/*if(_mashed || (_mashedobj != noone && instance_exists(_mashedobj))){
									_ll_mashtimer ++;
									if(_ll_mashtimer >= 30){
										_ll_mashblock = 30;
									}
								} else {
									_ll_mashtimer = 0;
								}
								if(_ll_mashblock > 0){
									_mashed = false;
									_mashedobj = noone;
							
									_hurttimer = 0;
									_block = true;
									_blocktimer = 6;
							
									_ll_mashblock --;
								}
								if(abs(_curspd[0]) > 1 || abs(_curspd[1]) > 1){
									_ll_mashblock = 0;
								}*/
								if(_successparry <= 0 && _anim == "mashhurt"){
									_anim = "idle"+string(_phase+1);
								}

								//the lights off gag code
								if(_hurttimer > 0 || _grabbed || _falling || _fall_ko){
									if(_ll_lightgag == 1){
										_ll_lightgag = 2;
									}
								}
							
								if(_ll_lightgagdone && global._lightsout){
									if(_ll_lightgag == 1){
										_ll_lightgag = 2;
									}
								}
							
								if(_ll_lightgag == 1 && !global._lightsout){
									if(!_ll_lightgagsfx[0] && _displayobj.image_index >= 6){
										sfx_play_proximity(snd_lanknotice);
										_ll_lightgagsfx[0] = true;
									}
									if(!_ll_lightgagsfx[1] && _displayobj.image_index >= 11){
										sfx_play_proximity(snd_lankscream);
										_ll_lightgagdone = true;
										_ll_lightgagsfx[1] = true;
									}
								}
						
								if(_taunt > 0 || _phaseend_act > 0 || _anim == "shockwave" || _shockwave || _mashed || _falling || _fall_ko){
									if(global._lightsout){
										with(_displayobj){
											visible = true;
										}
										sfx_play(snd_light_on);
										global._lightsout = false;
										scr_lightsout_affect();
									}
									if(_phaseend_act == 0){
										speed = 0;
										_curspd = [0,0];
										_jumptopos = [x,y];
										clearpath();
									
										_freespd = false;
										_spin = false;
										_fallxspd = 0;
										_fallyspd = 0;
									}
								
									//_fall_ko = false;
									//_standup = false;
									_curstate = STATE_OTHER;
									_behaviortype = "move";
									_hop_arc = 0;
								
									_attack = false;
									_attacktype = "";
									_ll_atk = false;
									_ll_atktimer = 0;
								
									if(_phaseend_act == 0){
										_slidespd = 0;
									}
								
									_ll_atkactive = false;
								
									_ll_atknum = 0;
									_ll_atk1_attack = false;
									_ll_atk1_atkact = 0;
							
									_ll_atk2_attack = false;
							
									_ll_atk3_act = 0;
									_ll_atk3_curclaps = 0;
									_ll_atk3_claps = 0;
									_ll_atk3_offscreen = false;
									_ll_atk3_curpos = [x,y];
									_ll_atk3_clappos = [x,y];
									_ll_atk3_gotopos = [x,y];
									_ll_atk3_quickflash = false;
									if(_ll_atk4_act > 0){
										if(!has_trait(TRAIT_GRAB)){
											add_trait(TRAIT_GRAB);
										}
									}
								
									_specialatk = 0;
								
									_ll_atk4_act = 0;
									_ll_atk4_afterattack = true;
									_ll_atk4_dopose = false;
									
									_ll_atk5_act = 0;
									_ll_atk5_spinamp = 0;
									_ll_atk5_spintimer = 0;
									_ll_atk5_endspin = 0;
									_ll_atk6_act = 0;
								}
							
								//taunts
								if(_taunt > 0){
									if(!_falling){
										if(!_ll_taunt){
											var spot = instance_create_depth(_displayobj.x,_displayobj.y,-9000,obj_st2_spotlight);
											spot._timer = _taunttime;
								
											_ll_tauntamp = 32;
											_ll_taunt = true;
								
											voice_play_choose_proximity([snd_lanky_spotlight1,snd_lanky_spotlight2,snd_lanky_spotlight3,snd_lanky_spotlight4,snd_lanky_spotlight5], global._bossvoices);
											sfx_play_proximity(snd_lankytaunt);
										}
										with(_displayobj){
											_forcedepth = -9010;
										}
									}
								} else {
									with(_displayobj){
										_forcedepth = 0;
									}
							
									_ll_tauntamp = 0;
									_ll_taunt = false;
								}
						
								if(_ll_tauntamp > 0){
									_ll_tauntamp -= 0.5;
									_dispoffset[0] = sin(random(480))*_ll_tauntamp;
								}
						
								scr_enemyscript_behavior("battlezone");
								scr_enemyscript_behavior("grab");
							}	
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
						} else if(_anim == "walk1" || _anim == "walk2" || _anim == "walk3"){
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
					
						//make transition
						if(_anim_prev != _anim){
							if(compare_anim("standup", "idle"+string(_phase+1)) || compare_anim("standup", "walk"+string(_phase+1))){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
							if(compare_anim("blockko", "idle"+string(_phase+1)) || compare_anim("blockko", "walk"+string(_phase+1)) || compare_anim("blockko", "skid")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
							if(compare_anim("runskid", "idle"+string(_phase+1)) || compare_anim("runskid", "walk"+string(_phase+1))){
								_displayobj.image_index = 0;
								_anim_tr_anim = "runskid_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
					
							_anim_prev = _anim;
						}
			
						if(!_death && _specialatk <= 0){
							var dh = instance_nearest(x,y,obj_dh_mask);
							if(instance_number_array(global._enemyArray) == 1 || (instance_exists(dh) && distance_to_object(dh) < _attackdist)){
								scr_enemyscript_detect();
							}
						}
			
						scr_enemyscript_other();
					} else {
						_curstate = STATE_OTHER;
						clearpath();
					}
				
					if(_block){
						_stunlock_timer = _stunlock_formula;
					}
				
					scr_enemyscript_death();
				
					if(_phaseend_act == 0 && _freeze <= 0){
						if(_mashed){
							_scrclear_happened = true;
						}
						if(_scrclear_happened && _falling && !_ll_tntvoice){
							voice_play_choose_proximity([snd_lanky_tnthit1,snd_lanky_tnthit2,snd_lanky_tnthit3,snd_lanky_tnthit4], global._bossvoices);
							_ll_tntvoice = true;
						}
						if(_scrclear_happened && !_mashed && global._blowup_kill == 0){
							_ll_tntvoice = false;
							_scrclear_happened = false;
						}
					}
					if(global._finalhit <= 0 && _freeze <= 0 && _phasehit > 0){
						_phasehit --;
					}
					
					if(_phaseend_act > 0 || _block || _blocktimer > 0 || _taunt > 0){
						_behaviortype = "move";
						_atktimer = 0;
						_hurttimer = 0;
						_freeze = 0;
						_specialatk = 0;
					}
					
					//looping sounds
					if(_allsounds != -1){
						var spinsnd = false;
						var prepsnd = false;
						if(_anim == "quickflash" && _phaseend_act == 0){
							spinsnd = true;
						}
						if(_anim == "spin1"){
							spinsnd = true;
						}
						if(_anim == "runprepare"){
							prepsnd = true;
						}
						
						if(_death){
							spinsnd = false;
						}
					
						if((!_attack && _attacktype != "idle") || _anim != "runattack"){
							if(sfx_isplaying(snd_lanky_attack)){
								sfx_stop(snd_lanky_attack);
							}
						}
					
						if(spinsnd){
							if(!sfx_isplaying(snd_spin)){
								sfx_play_proximity(snd_spin, 0.65);
							}
						} else {
							if(sfx_isplaying(snd_spin)){
								sfx_stop(snd_spin);
							}
						}
						if(prepsnd){
							if(!sfx_isplaying(snd_lanky_prep)){
								sfx_play_proximity(snd_lanky_prep);
							}
						} else {
							if(sfx_isplaying(snd_lanky_prep)){
								sfx_stop(snd_lanky_prep);
							}
						}
					}
				
					scr_enemyscript_dir();
					
					scr_enemyscript_bottomscript();
				
					if(_finalhit){
						_falling = false;
						_fallxspd = 0;
						_fallyspd = 0;
					}
				
					//quick fix
					if(_phase == 1){
						if(_falling || _fall_ko || _standup){
							_ll_atk3_act = 0;
							_ll_atk3_curclaps = 0;
							_ll_atk3_claps = 0;
							_ll_atk3_claptimer = 0;
							_ll_atk3_offscreen = false;
							_ll_atk3_curpos = [x,y];
							_ll_atk3_clappos = [x,y];
							_ll_atk3_gotopos = [x,y];
							_ll_atk3_quickflash = false;
							_ll_atk3_after = 0;
							
							_ll_atk4_act = 0;
							_ll_atk4_timer = 0;
							_ll_atk4_poses = 0;
							_ll_atk4_maxposes = 7;
							_ll_atk4_dopose = false;
							_ll_atk4_posetype = 1;
							_ll_atk4_maxframes = 3;
							_ll_atk4_afterattack = false;
							_ll_atk4_offset = 256;
						}
					}
				
					//flying out
					if(_death){
						with(_displayobj){
							visible = false;
							if(ds_map_exists(global._gameshadows, _occupy_id)){
								ds_map_delete(global._gameshadows, _occupy_id);
							}
						}
						remove_trait([TRAIT_HURT,TRAIT_GRAB]);
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
	
	if(global._finalhit > 0){
		_ll_atk5_act = 0;
		_ll_atk5_spinamp = 0;
		_ll_atk5_spintimer = 0;
		_ll_atk5_endspin = 0;
	}
}