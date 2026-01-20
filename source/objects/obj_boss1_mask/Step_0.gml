{
	if(!global._pause){
		with(_displayobj){
			image_speed = 1;
		}
		
		if(_hp <= 5 && !_finalhit){
			//kill all other enemies
			for(var i = 0; i < array_length(global._enemyArray); i++){
				with(global._enemyArray[i]){
					_freeze = 60;
					_spd = [0,0];
					_vspd = 16;
					_jump = true;
					_falldir = choose("l","r");
					_falling = true;
					if(!_boss){
						_hp = 0;
					}
				}
			}
			
			_hp = 0;
			global._hitinst = self;
			global._finalhit = 60;
			_finalhit = true;
		}
		
		if(_dodeath == 1){
			_height += 4;
			_vspd = 16;
			_jump = true;
			if(_dir == "r"){
				_spd[0] = _maxspd[0]*_curdir; 
			} else {
				_spd[0] = -_maxspd[0]; 
			}
			_spd[1] = 0;
			_falldir = _dir;
			_falls = 0;
			_falling = true;
			
			_dodeath = 2;
		}
		if(_dodeath == 2 && !_falling){
			_dead = true;
		}
		
		if(!global._bossstart){
			mus_fade(0, 500, true);
		
			global._bossstart = true;
		}
	
		if(_startTimer > 0){
			_startTimer --;
		}
	
		if(_startTimer <= 0){
			if(!_init){
				_collidesolid = global._solidArray;
				_collideenemy = global._enemyArray;
				_collidehurtbox = global._hurtboxArray;
		
				_init = true;
			} else {
				if(!_flyout){
					scr_enemy_move();
			
					_plobj = instance_nearest(x, y, obj_dh_mask);
			
					if(!_grabfall){
						if(!_begin){
							//canGrab = false;
							if(_beginact == 0){
								global._bossvalue = 1;
								_dir = "r";
								_beginoffset = -1200+global._cameraY;
								_beginact = 1;
								sfx_play(snd_whistle);
						
								global._bossmusic = true;
							}
							if(_beginact == 1){
								_beginoffset += 50;
								if(_beginoffset >= y){
									_beginoffset = y;
									_displayobj.image_index = 0;
									_beginact = 2;
									_begintime = 0;
									with(obj_camera){
										_ampY = 40;
									}
									with(obj_dh_mask){
										if(_height == _groundlevel){
											_vspd = 16;
											_height += 4;
											_jump = true;
											_state = "shockwave";
											_shockwave = 50;
										}
									}
									sfx_stop(snd_whistle);
									sfx_play(snd_slam);
								}
							}
							if(_beginact == 2){
								_begintime ++;
								if(_begintime >= 4 && _displayobj.image_index >= _displayobj.image_number-1){
									_displayobj.image_index = 0;
									_begintime = 0;
									_beginact = 3;
								}
							}
							if(_beginact == 3){
								if(_displayobj.image_index >= 11 && !_growl){
									voice_play(snd_boss1_growl, global._bossvoices);
									_growl = true;
								}
								_begintime ++;
								if(_begintime >= 10 && _displayobj.image_index >= _displayobj.image_number-1){
									_displayobj.image_index = 0;
									if(!_trigger){
										with(obj_game){
											global._vsscreen = 1;
										}
										_trigger = true;
									}
								}
							}
						}
					} else {
						_fixwall = true;
						_begin = true;
					}
			
					if(_begin){
						if(_defense <= 0){
							//canGrab = true;
						} else {
							//canGrab = false;
						}
						if(_attacknum == 0){
							with(_hitobj){
								_damaging = true;
							}
						} else {
							with(_hitobj){
								_damaging = false;
							}
						}
				
						global._curboss = self;
					}
			
					if(!_begin){
						//animation
						if(_anim_transition){
							if(_displayobj.image_index >= _displayobj.image_number-1){
								_anim_tr_anim = "";
								_anim_prev = _anim;
								_anim_transition = false;
							}
						}
					
						if(_beginact < 2){
							_anim = "appear1";
						}
						if(_beginact == 2){
							_anim = "appear2";
						}
						if(_beginact == 3){
							_anim = "intro";
						}
						if(_trigger){
							_anim = "idle";
						}
					} else {
						//animation
						if(_anim_transition){
							//transitions
							switch(_anim_tr_anim){
								case "standup_idle":
									_anim = "tr_standup_idle";
								break;
								case "attack1_idle":
									_anim = "tr_attack1_idle";
								break;
							}
							if(_displayobj.image_index >= _displayobj.image_number-1){
								_anim_tr_anim = "";
								_anim_prev = _anim;
								_anim_transition = false;
							}
						} else {
							if(_hurtTimer == 0){
								if(!_pathwalking){
									if(_spd[0] == 0 && _spd[1] == 0){
										_anim_prev = _anim;
										_anim = "idle";
									} else {
										_anim_prev = _anim;
										_anim = "walk";
									}
								}
								if(!_falling && !_dead && _state == "follow"){
									if(_pathwalking && (_pathwalkspd[0] <> 0 || _pathwalkspd[1] <> 0)){
										_anim_prev = _anim;
										_anim = "walk";
									}
									if(_pathwalking && _pathwalkspd[0] < 0){
										_dir = "l";
									} else if(_pathwalking && _pathwalkspd[0] > 0){
										_dir = "r";
									}
								} else {
									if(!_pathwalking){
										if(_spd[0] == 0 && _spd[1] == 0){
											_anim_prev = _anim;
											_anim = "idle";
										} else {
											if(_spdXsmooth < 1){
												_dir = "l";
											} else if(_spdXsmooth > 1){
												_dir = "r";
											}
											_anim_prev = _anim;
											_anim = "walk";
										}
									}
								}
							} else {
								_anim_prev = _anim;
								_anim = "hurt"+string(_randhurt);
							}
				
							if(_block == 1){
								_anim_prev = _anim;
								_anim = "block";
							}
				
							if(_attack){
								switch(_attacktype){
									case "idle":
										if(!_knockout){
											if(_attackvar % 2 == 0){
												_anim_prev = _anim;
												_anim = "melee1";
											} else if(_attackvar % 2 == 1){
												_anim_prev = _anim;
												_anim = "melee2";
											}
										} else {
											_anim_prev = _anim;
											_anim = "melee3";
										}
									break;
								}
							}
				
							switch(_attacknum){
								case 1:
									_anim_prev = _anim;
									_anim = "attack1";
								break;
								case 2:
									if(_land){
										_anim_prev = _anim;
										_anim = "attack2_ground";
									} else {
										_anim_prev = _anim;
										_anim = "attack2_jump";
									}
								break;
							}
				
							if(_falling){
								_anim_prev = _anim;
								_anim = "fall";
							}
							if(_dead){
								_anim_prev = _anim;
								_anim = "dead";
								if(_jumpback){
									_anim_prev = _anim;
									_anim = "standup";
								}
							}
						
							//make transition
							if(_anim_prev != _anim){
								if(compare_anim("standup", "idle") || compare_anim("standup", "walk")){
									_anim_tr_anim = "standup_idle";
									_anim_tr_init = false;
									_anim_transition = true;
								}
								if(compare_anim("attack1", "idle") || compare_anim("attack1", "walk")){
									_anim_tr_anim = "attack1_idle";
									_anim_tr_init = false;
									_anim_transition = true;
								}
					
								_anim_prev = _anim;
							}
						}
				
						if(_hurtTimer == 0 && !_falling && !_dead){
							/*if(!_attack){
								_punch = false;
							} else {
								//huge punch
								if(_attacktype == "idle" && !_punch){
									if(_displayobj.image_index >= 7){
										var atk = instance_create_depth(x, y, -1, obj_en_punchhitbox);
										atk._parentobj = self.id;
										atk._scale = [4.2, 3];
										atk._offset = [180,-66];
										if(_defense > 0){
											atk._scale = [4.2, 4.4];
											atk._offset = [180,0];
										}
										atk._timer = 9;
										atk._damage = ATK_KO;
										_stateTimer = 0;
							
										sfx_play_choose([snd_swish1,snd_swish2,snd_swish3,snd_swish4]);
										_punch = true;
									}
								}
							}*/
				
							scr_enemy_behavior();
							scr_enemy_detecting();
						}
					}
					scr_enemy_animation();
			
					if(_hurtTimer > 0){
						_shakeX = 6;
						_shakeY = 6;
					}
					if(_shakeX > 0){
						_shakeX --;
					} else if(_shakeX < 0){
						_shakeX = 0;
					}
					if(_shakeY > 0){
						_shakeY --;
					} else if(_shakeY < 0){
						_shakeY = 0;
					}
			
					if(_attacknum <> 1){
						_barfstarttime = 0;
					}
			
					if(_hurtTimer > 0){
						global._frankenId = self.id;
						with(obj_en_punchhitbox){
							if(self.id == global._frankenId){
								instance_destroy();
							}
						}
					}
			
					//attacking
					if(_begin){
						_attacktimer ++;
						switch(_attacknum){
							case 0:
								_barfed = false;
								if(_attacktimer >= max(random_range(440, 700)*global._bossvalue, 300)){
									var plobj = instance_find(obj_dh_mask, 0);
									if(instance_exists(plobj)){
										if(plobj.x < x){
											_barfdir = "l";
										} else {
											_barfdir = "r";
										}
									}
									if(_barfstarttime == 0){
										_displayobj.image_index = 0;
									}
									_barfs = 1;
									if(global._bossvalue <= 0.6){
										_barfs = 2;
									}
									if(global._bossvalue <= 0.3){
										_barfs = 3;
									}
									_jumps = 1;
									if(global._bossvalue <= 0.65){
										_jumps = 2;
									}
									if(global._bossvalue <= 0.45){
										_jumps = 3;
									}
								
									_jumpSpd = [random_range(-4, 4), random_range(4, 4)];
								
									_attacktimer = 0;
									_attacknum = random_range(0, 10);
									if(_attacknum < 7){
										sfx_play(snd_bubbling);
										_attacknum = 1;
									} else {
										_attacknum = 2;
									}
								}
							break;
							case 1:
								_dir = _barfdir;
								_spd = [0,0];
								_barfstarttime ++;
								if(_barfstarttime >= 6 && _displayobj.image_index >= 11){
									if(!_barfed){
										_barfs --;
										if(!_enemybarf){
											var inst = instance_create_depth(x, y+16, _displayobj.depth-8, obj_barf_mask);
											inst._newdepthtime = 12;
											inst._newdepth = _displayobj.depth-8;
											if(_dir == "r"){
												inst._startspd[0] = 7;
												inst.x += 48;
											} else {
												inst._startspd[0] = -7;
												inst.x -= 48;
											}
											var dist = 0;
											var dist1 = 0;
											var plobj = instance_find(obj_dh_mask, 0);
											if(instance_exists(plobj)){
												dist1 = diff(plobj.y, y)/60;
												if(plobj.y < y){
													dist = -dist1;
												} else {
													dist = dist1;
												}
											}
											inst._startspd[1] = median(-8, dist, 8);
											inst._jump = true;
											inst._height = 240;
										} else {
											if(instance_number_array(global._enemyArray) < 3){
												var inst = instance_create_depth(x, y+16, _displayobj.depth-8, asset_get_index("obj_enm"+string(floor(random_range(1, 3)))+"_mask"));
												inst._newdepthtime = 12;
												inst._newdepth = _displayobj.depth-8;
												if(_dir == "r"){
													inst._startspd[0] = 7;
													inst.x += 48;
												} else {
													inst._startspd[0] = -7;
													inst.x -= 48;
												}
												inst._barfedout = true;
												inst._height = 90;
												inst._vspd = 12;
												inst._fallabove = true;
												inst._jump = true;
												inst._jumpback = true;
												inst._falling = true;
											} else {
												var inst = instance_create_depth(x, y+16, _displayobj.depth-8, obj_barf_mask);
												inst._newdepthtime = 12;
												inst._newdepth = _displayobj.depth-8;
												if(_dir == "r"){
													inst._startspd[0] = 7;
													inst.x += 48;
												} else {
													inst._startspd[0] = -7;
													inst.x -= 48;
												}
												var dist = 0;
												var dist1 = 0;
												var plobj = instance_find(obj_dh_mask, 0);
												if(instance_exists(plobj)){
													dist1 = diff(plobj.y, y)/60;
													if(plobj.y < y){
														dist = -dist1;
													} else {
														dist = dist1;
													}
												}
												inst._startspd[1] = median(-8, dist, 8);
												inst._jump = true;
												inst._height = 240;
										
												_barfs = 0;
												_enemybarf = false;
												_nomorebarf = true;
											}
										}
										sfx_play(snd_barf);
										sfx_pitch(snd_barf, random_range(0.9,1.1));
									
										_displayobj.image_index = 11;
									
										_barfed = true;
									}
									if(_displayobj.image_index >= _displayobj.image_number-1){
										_barfed = false;
										if(_barfs <= 0){
											if(!_nomorebarf){
												if(global._bossvalue <= 0.7){
													if(!_enemybarf){
														_barfs = 1;
														if(global._bossvalue <= 0.45){
															_barfs = 2;
														}
														_enemybarf = true;
													} else {
														_enemybarf = false;
														_attacknum = 0;
													}
												} else {
													_enemybarf = false;
													_attacknum = 0;
												}
											} else {
												_nomorebarf = false;
												_enemybarf = false;
												_attacknum = 0;
											}
										} else {
											_displayobj.image_index = 11;
										}
									}
								}
							break;
							case 2:
								if(!_dead){
									_spd = _jumpSpd;
								} else {
									_spd = [0,0];
								}
								if(_height <= _groundlevel){
									_land = true;
									if(_anim != "attack2_ground"){
										if(_jumped){
											var inst = instance_create_depth(x, y, 0, obj_boss1_shockwave_front);
											_jumpshake = 70;
											_jumps --;
											with(obj_camera){
												_ampY = 24;
											}
											if(_jumps <= 0){
												_attacktimer = 0;
												_attacknum = 0;
											}
											sfx_play_choose([snd_heavythud1,snd_heavythud2]);
											_jumped = false;
										}
										_displayobj.image_index = 0;
									} else {
										_spd = [0,0];
										if(_jumpshake <= 0){
											_jumpSpd = [random_range(-4, 4), random_range(4, 4)];
											_jumped = true;
											_jump = true;
											_height += 8;
											_vspd = 16;
										}
									}
								} else {
									_land = false;
								}
							break;
						}
					}
				
					if(_jumpshake > 0){
						_jumpshake --;
						with(obj_camera){
							_ampY = 10;
						}
					}
				
					//blocking
					if(_block == 0 && _gotdamaged >= 5){
						_block = 1;
						_defense = 60;
					}
					if(_block == 1){
						_attack = false;
						if(_defense <= 0){
							_punch = false;
							_anim = "melee3";
							_attack = true;
							_knockout = true;
							_attacktype = "idle";
							_defense = 24;
					
							var atk = instance_create_depth(x, y, -1, obj_en_punchhitbox);
							atk._parentobj = self.id;
							atk._scale = [4.2, 3];
							atk._offset = [180,0];
							if(_defense > 0){
								atk._scale = [4.2, 5];
								atk._offset = [180,0];
							}
							atk._timer = 9;
							atk._damage = ATK_KO;
					
							sfx_play_choose([snd_swish1,snd_swish2,snd_swish3,snd_swish4]);
						
							_block = 2;
						}
					}
					if(_block == 2){
						if(_defense <= 5){
							_defense = 0;
							_attacktimer = 1000;
							_block = 0;
						}
					}
					if(_block > 0){
						_diddamage = 0;
						_gotdamaged = 0;
						_attacktimer = 0;
						_attacknum = 0;
						_spd = [0,0];
					}
					if(_anim != "block" && _anim != "melee3" && _block <> 0 && _defense < 20){
						_block = 0;
						_attacktimer = 1000;
						if(_spd[0] <> 0 && _spd[1] <> 0){
							_defense = 0;
						}
					}
				
					if(_anim != "melee3" && _defense >= 5 && _afterfallhit && _gotdamaged >= 4){
						_defense = 0;
						_gotdamaged = 0;
						_afterfallhit = false;
						_attacktimer = 1000;
						_block = 0;
					}
				
					if(_hurtTimer > 0 && _attacknum > 0){
						_hurtTimer = 0;
					}
					if(_falling){
						_attacktimer = 0;
						_attacknum = 0;
					}
			
					global._bossvalue = _hp/_maxhp;
					if(global._bossvalue <= 1 && global._bossvalue > 0.8){
						_ai = 6;
					} else if(global._bossvalue <= 0.7 && global._bossvalue > 0.6){
						_ai = 7;
					} else if(global._bossvalue <= 0.45 && global._bossvalue > 0.5){
						_ai = 8;
					}
					if(global._bossvalue <= 0.5){
						global._bossvalue = 0.5;
					}
			
					//la bug
					if(_anim == "tr_attack1_idle" && floor(_displayobj.image_index) == 0){
						_bugpreventionframechecker ++;
						if(_bugpreventionframechecker >= 8){
							_defense = 0;
							_anim = "idle";
						}
					} else {
						_bugpreventionframechecker = 0;
					}
			
					scr_enemy_other();
					scr_enemy_falling();
				}
			}
		}
	} else {
		with(_displayobj){
			image_speed = 0;
		}
	}
	
	if(global._debug){
		if(global._showHitbox){
			visible = true;
		} else {
			visible = false;
		}
	}
}