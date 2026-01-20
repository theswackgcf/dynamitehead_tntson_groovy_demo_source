{
	depth = 4000;
	
	visible = !global._lightsout;
	if(global._finalhit > 0 && !global._finalhit_phase){
		visible = false;
	}
	
	if(!global._pause){
		if(_freeze > 0){
			_freeze -= 1;
		} else {
			if(global._bossmusic){
				//volume fix
				if(global._cursong != -1){
					audio_sound_gain(global._cursong, global._bossgains[global._location]);
				}
			}
			
			if(instance_number(obj_boss2_mask) > 0){
				//light spot
				if(_showlight <= 0){
					if(instance_exists(_lightsource)){
						instance_destroy(_lightsource.id);
						_lightsource = noone;
					}
				} else {
					if(_light_scalex < 1.4){
						_light_scalex += 0.1;
					} else {
						_light_scalex = 1.4;
					}
					if(_lightsource == noone){
						_lightsource = instance_create_depth(x,y,0,obj_lightsource);
					} else {
						if(instance_exists(_lightsource)){
							_lightsource.x = x+_lightoffset[0];
							_lightsource.y = y+_lightoffset[1];
							_lightsource.image_xscale = _light_scalex;
							_lightsource.image_alpha = _light_alpha;
						}
					}
					
					_showlight --;
				}
				
				//throwing mines
				if(!_minethrow){
					_minethrow_timer = 0;
				} else {
					_minethrow_timer ++;
					if(_spawnmine && _minethrow_timer >= 14){
						if(_minestothrow > 0){
							_curmine_show = true;
							_curminepos = [x,y];
							_curminespd = [random_range(-7,7),-20];
							_spawnmine = false;
							
							_minestothrow --;
						} else {
							_curmine ++;
							_minethrow = false;
						}
						_minethrow_timer = 0;
					}
				}
				
				if(_curmine_show){
					_curminepos[0] += _curminespd[0];
					_curminepos[1] += _curminespd[1];
					if(_curminepos[1] <= global._cameraY-120 && !_spawnmine){
						var bzone = instance_place(x,y,obj_battlezone);
						if(bzone != noone && instance_exists(bzone)){
							var mine = instance_create_depth(random_range(bzone.bbox_left+160,bzone.bbox_right-160), random_range(bzone.bbox_top+120,bzone.bbox_bottom-140), depth, obj_boss2_mine);
							mine._groundlevel = 0;
							mine._popofftimer = 100;
							mine._height = HEIGHT;
							mine._xspd = random_range(-4.5,4.5);
							mine._yspd = 0;
						}
						_spawnmine = true;
					}
				}
				
				//leaving and entering
				_acttimer ++;
				if(_easteregg_startdialogue){
					if(_easteregg_timer > 0){
						_intro = true;
						_act = 0;
						_acttimer = 0;
					}
				}
				if(_intro){
					_showlight = 4;
					global._delayspawn = 2;
					global._delayspawntime = 320;
				
					switch(_act){
						case 0:
							if(!_delete_offscreen_obj){
								with(obj_st2_face){
									instance_destroy();
								}
								with(obj_st2_hands){
									instance_destroy();
								}
								with(obj_st2_redlake){
									instance_destroy();
								}
								with(obj_lightsource){
									if(sprite_index == spr_st2_streetlight){
										instance_destroy();
									}
								}
								with(obj_st2_graves){
									instance_destroy();
								}
								with(obj_st2_glass){
									if(x <= global._cameraX-WIDTH){
										instance_destroy();
									}
								}
								with(obj_st2_glass_shatter){
									if(x <= global._cameraX-WIDTH){
										instance_destroy();
									}
								}
								
								_delete_offscreen_obj = true;
							}
						
							_state = "intro";
							
							//fixing shit speedrun awesome cool easter egg nice
							if(!global._bossintro && global._easteregg_lank){
								_easteregg_active = true;
							}
							if(_easteregg_active){
								if(global._debug && keyboard_check_pressed(vk_enter)){
									with(obj_dialogue){
										if(_show){
											//end dialogue
											image_index = 0;
											_curpg = array_length(_textarray);
											_diagstate = 3;
											_timer = 0;
											_diagend = true;
											sfx_play(snd_noise);
											_noise = 12;
				
											other._destroy = true;
										}
									}
									
									sfx_stop(snd_speakerslide);
									_easteregg_speakers = true;
									_easteregg_startdialogue = false;
									_easteregg_timer = 0;
								}
								
								if(_easteregg_timer > 0){
									if(!_easteregg_startdialogue_init){
										_easteregg_startdialogue = true;
										_easteregg_startdialogue_init = true;
									}
									
									_acttimer = 0;
									
									if(!_easteregg_speakers){
										_easteregg_soundtimer ++;
										_easteregg_voicetimer ++;
										if(_easteregg_soundtimer >= random_range(45, 125)){
											with(obj_camera){
												_ampY = random_range(24, 40);
											}
											sfx_play_choose([snd_lankfix1,snd_lankfix2,snd_lankfix3,snd_lankfix4,snd_lankfix5,snd_lankfix6,snd_slambong5,snd_slambong6,snd_slambong7,snd_wallslam,snd_punchfail1,snd_punchfail2,snd_punchfail3]);
											_easteregg_soundtimer = 0;
										}
										if(_easteregg_voicetimer >= random_range(240, 700)){
											voice_play_choose([snd_lanky_tnthit1,snd_lanky_tnthit2,snd_lanky_tnthit3,snd_lanky_tnthit4], global._bossvoices);
											_easteregg_voicetimer = 0;
										}
									
										_easteregg_acttimer ++;
										if(_easteregg_acttimer >= 2000){
											if(_easteregg_act <= 5){
												scr_startdialogue("dg_speedrun", "u", 0, false, _easteregg_act);
												_easteregg_act ++;
												_easteregg_stop = true;
												_easteregg_acttimer = 0;
											}
										}
										if(_easteregg_stop){
											_easteregg_stoptimer ++;
										}
										if(_easteregg_stoptimer >= 450){
											with(obj_dialogue){
												if(_show){
													//end dialogue
													image_index = 0;
													_curpg = array_length(_textarray);
													_diagstate = 3;
													_timer = 0;
													_diagend = true;
													sfx_play(snd_noise);
													_noise = 12;
				
													other._destroy = true;
												}
											}
										
											_easteregg_stop = 0;
											_easteregg_stoptimer = 0;
										}
									} else {
										if(!_easteregg_speakers_snd){
											sfx_play(snd_dead);
											sfx_play(snd_speakerslide, 0.56);
											_easteregg_speakers_snd = true;
										} else {
											if(sfx_isplaying(snd_speakerslide)){
												with(obj_camera){
													_ampY = 4;
												}
											} else {
												_easteregg_speakers = false;
											}
										}
									}
									
									mus_stop();
									
									_acttimer = 0;
									
									_easteregg_timer --;
								}
							}
							
							if(global._bossintro){
								_intro = false;
								_acttimer = 0;
								_act = 1;
								
								global._speedruntimer = 99999;
								
								mus_play(mus_boss2, global._bossgains[global._location]);
								global._bossmusic = true;
								
								visible = true;
								
								sfx_play(snd_light_on);
								global._lightsout = false;
								scr_lightsout_affect();
							}
							
							if(_acttimer >= 70){
								global._speedruntimer = 99999;
								
								mus_play(mus_boss2, global._bossgains[global._location]);
								global._bossmusic = true;
							
								visible = true;
							
								sfx_play(snd_light_on);
								global._lightsout = false;
								scr_lightsout_affect();
								_acttimer = 0;
								_act = 1;
							}
						break;
						case 1:
							if(_easteregg_startdialogue){
								_acttimer = 0;
								if(!global._dialogue){
									_easteregg_startdialogue_timer ++;
									if(_easteregg_startdialogue_timer >= 80){
										scr_startdialogue("dg_speedrun", "d", 0, false, 6);
										_easteregg_startdialogue = false;
									}
								}
							}
							if(global._dialogue){
								_acttimer = 0;
							}
						
							//lights on, do intro animation
							if(_acttimer >= 20){
								_switchoffset[1] = ease_in(_switchoffset[1],-500,70);
							}
							
							if(_acttimer >= 79 && !_makeobj){
								_bossintro = instance_create_depth(x-96, y-150, depth, obj_boss_intro);
								_bossintro._codename = _codename;
								_makeobj = true;
							}
							if(_acttimer >= 80){
								_state = "";
								_acttimer = 0;
								_act = 2
							}
						break;
						case 2:
							//intro over
							if(instance_number(obj_boss_intro) == 0){
								_state = "default";
								_intro = false;
								_acttimer = 0;
								_act = 1;
							}
						break;
					}
				} else {
					with(obj_dh_mask){
						_candospecial = true;
					}
					
					switch(_act){
						case 0:
							if(_larry){
								_showlight = 4;
								
								//mine code
								if(instance_number_array(global._enemyArray) > 1 || instance_number(obj_enmspawn) > 0){
									if(!_minethrow){
										_minetimer ++;
									
										if(ds_map_exists(_mineds, _curmine)){
											if(_phase == _mineds[? _curmine][0] && _minetimer >= _mineds[? _curmine][1]){
												_minestothrow = _mineds[? _curmine][2];
												_minethrow = true;
											}
										}
									}
								}
							} else {
								_showlight = 0;
								_light_alpha = 1;
								
								_minetimer = 0;
								_curmine = _mine_phaseind[_mine_phaseind_cur];
							}
							_lightoffset[0] = 0;
							_state = "default";
							_lank_offsetx = 0;
							_lank_offsety = 0;
							
							_setlankpos = false;
						break;
						case 0.5:
							_showlight = 4;
							_state = "seethe";
							_seethe = true;
							if(_acttimer >= 55){
								_acttimer = 0;
								_act = 1;
							}
						break;
						case 1:
							_showlight = 4;
							_lightoffset[0] = _lank_offsetx;
							_lank_offsetx -= 1.5*_spawndir;
				
							if(_acttimer >= 35){
								sfx_play_proximity(snd_lanky_zip, 0.65);
								_seethe = false;
								_acttimer = 0;
								_act = 2;
							}
						break;
						case 2:
							_state = "leave";
							_lank_offsetx = 0;
							
							_lightoffset[0] += 160*_spawndir;
				
							if(!_setlankpos){
								with(obj_boss2_mask){
									_ll_spawndir = other._spawndir;
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
									_boss_active = true;
								}
								
								_setlankpos = true;
							}
				
							if(_acttimer >= 8){
								_showlight = 0;
								_larry = false;
								_acttimer = 0;
								_act = 0;
							} else {
								_showlight = 4;
							}
						break;
						case 3:
							_showlight = 4;
							_state = "enter";
							_lank_offsety = -600;
							_acttimer = 0;
							_act = 4;
						break;
						case 4:
							_showlight = 4;
							_larry = true;
							if(!global._dialogue){
								_lank_offsety += 30;
								if(_lank_offsety >= 0){
									_offsety.speakerL = -2;
									_offsety.set = -2;
									_offsety.speakerR = -2;
			
									_vely.speakerL = -17;
									_vely.set = -10;
									_vely.speakerR = -14;
								
									_lank_offsety = 0;
								
									_state = "spin";
									_acttimer = 0;
									_act = 5;
								}
							}
						break;
						case 5:
							_showlight = 4;
							if(_acttimer >= 70){
								_acttimer = 0;
								_act = 0;
							}
						break;
					}
				}
			
				if(_larryact_tr > 0){
					_larryact_tr --;
				}
			
				//larry animations
				if(_larry && _state == "default" && _lank_offsetx == 0){
					_larryact_timer ++;
					if(_larryact_timer >= random_range(90,180)/_phase){
						_larryact_prev = _larryact;
						_larryact = irandom_range(1,5);
						if(_phase == 2){
							_larryact = irandom_range(6,9); //lmao
						}
						_larryact_timer = 0;
					}
					
					if(_larryact_prev <> _larryact){
						_larryact_prev = _larryact;
						_larryact_tr = 12;
					}
				} else {
					_larryact_timer = 0;
					_larryact = 1;
					if(_phase == 2){
						_larryact = 6;
					}
				}
		
				var lankspd = 4;
				var speakspd = 4;
		
				_timer ++;
				if(_timer % lankspd == 0){
					_lankframe ++;
				}
		
				if(_beat){
					_speakertimer ++;
					if(_speakertimer % speakspd == 0){
						_speakerframe ++;
						if(_speakerframe >= 3){
							_speakerframe = 0;
							_beat = false;
						}
					}
					
					if(_timer % lankspd == 0){
						_lankframe_onbeat ++;
						if(_lankframe_onbeat >= 2){
							_lankframe_onbeat = 2;
						}
					}
				} else {
					_lankframe_onbeat = 0;
				}
		
				//gravity stuff
				_offsety.speakerL += _vely.speakerL;
				_offsety.set += _vely.set;
				_offsety.speakerR += _vely.speakerR;
		
				var grav = 0.62;
				_vely.speakerL += grav;
				_vely.set += grav;
				_vely.speakerR += grav;
			
				if(_offsety.speakerL >= 0){
					_vely.speakerL = 0;
					_offsety.speakerL = 0;
				}
				if(_offsety.set >= 0){
					_vely.set = 0;
					_offsety.set = 0;
				}
				if(_offsety.speakerR >= 0){
					_vely.speakerR = 0;
					_offsety.speakerR = 0;
				}
		
				/*if(keyboard_check_pressed(ord("W"))){
					_offsety.speakerL = -2;
					_offsety.set = -2;
					_offsety.speakerR = -2;
			
					_vely.speakerL = -17;
					_vely.set = -10;
					_vely.speakerR = -14;
				}*/
		
				//speakers on beat
				var failsafe = false;
				if(global._cursong != -1){
					_songplaying = audio_is_playing(global._cursong);
					if(_songplaying){
						if( (audio_sound_get_track_position(global._cursong))%(60/_bpm) <= 0.05 ){
							_speakertimer = 0;
							_speakerframe = 0;
							_beat = true;
						}
					} else {
						failsafe = true;
					}
				} else {
					failsafe = true;
				}
				if(failsafe){
					//failsafe
					_failsafe_timer += 1;
					if( _failsafe_timer >= 30 ){
						_failsafe_timer = 0;
						_speakertimer = 0;
						_speakerframe = 0;
						_beat = true;
					}
				}
			}
		}
	}
}