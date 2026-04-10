function scr_enemyscript_hurtbox(type){
	if(type == "create"){
		visible = false;
	
		_allsounds = ds_map_create();
		_offset = [0,0];
		
		_curdir = DIR_R;
		
		_scales = [
			[1,1],
			[2.1,0.85],
			[1.6,1.3],
		];
		_curscale = 0;
		
		_dofreeze = false;
	}
	if(type == "clean"){
		if(_allsounds != undefined && _allsounds != -1){
			ds_map_destroy(_allsounds);
			_allsounds = -1;
		}
	}
	if(type == "step"){
		_parentobj._stunlock_formula = scr_ailevel(20, 140, _parentobj);
		
		_offset = [0,46];
		if(_parentobj._parachute){
			_offset = [0,315];
		}
		
		_curscale = 0;
		if(_parentobj._falling || _parentobj._fall_ko){
			_curscale = 1;
			if(_parentobj._fall_ko){
				_offset = [0,132];
			}
		}
		if(_parentobj._parachute){
			_curscale = 0;
		}
		if(_parentobj._spin){
			_curscale = 2;
		}
		
		image_xscale = _scales[_curscale][0];
		image_yscale = _scales[_curscale][1];
		
		if(!global._debug){
			visible = false;
		} else {
			visible = global._showHitbox;
		}
	
		function ui_hp_stuff(obj){
			if(instance_exists(obj)){
				if(!obj._boss){
					if(array_length(global._curenemy) < 3){
						var exists = false;
						for(var i = 0; i < array_length(global._curenemy); i++){
							if(instance_exists(global._curenemy[i])){
								if(global._curenemy[i].id == obj.id){
									exists = true;
								}
							}
						}
						if(!exists){
							//push into array only if enemy isnt already in it
							array_push(global._curenemy, obj);
						}
					}
					//cycle
					if(array_length(global._curenemy) == 2){
						if(instance_exists(global._curenemy[0]) && instance_exists(global._curenemy[1])){
							if(global._curenemy[0].id != obj.id){
								global._curenemy[1] = global._curenemy[0];
								global._curenemy[0] = obj;
							}
						}
					}
					if(array_length(global._curenemy) == 3){
						var exists = false;
						for(var i = 0; i < array_length(global._curenemy); i++){
							if(instance_exists(global._curenemy[i])){
								if(global._curenemy[i].id == obj.id){
									exists = true;
								}
							}
						}
						if(instance_exists(global._curenemy[0]) && instance_exists(global._curenemy[1]) && instance_exists(global._curenemy[2])){
							if(exists){
								if(global._curenemy[0].id != obj.id){
									if(global._curenemy[2].id == obj.id){
										//last element will be the first
										global._curenemy[2] = global._curenemy[1];
										global._curenemy[1] = global._curenemy[0];
										global._curenemy[0] = obj;
									} else if(global._curenemy[1].id == obj.id){
										//middle element will be the first
										global._curenemy[1] = global._curenemy[0];
										global._curenemy[0] = obj;
									}
								}
							} else {
								//cycle and add to array
								global._curenemy[2] = global._curenemy[1];
								global._curenemy[1] = global._curenemy[0];
								global._curenemy[0] = obj;
							}
						}
					}
				}
				
				if(!obj._boss){
					//show enemy hp bar
					with(obj_gui){
						global._ui_stuff_alpha[2] = 1;
						ui_fade("enemy", 1);
					}
				}
			}
		}
	
		if(!global._pause){
			//getting ko'd by other ko'd enemies
			if(_parentobj._startTimer <= 0 && !_parentobj._death && _parentobj._sequence_finished && _parentobj._phaseend_act == 0 && !_parentobj._stunlock_dodge && _parentobj._stunlock_after <= 0){
				if(has_trait(TRAIT_HURT, _parentobj) && _parentobj._immunetimer <= 0 && !_parentobj._fall_ko && !_parentobj._falling && place_meeting_array(x, y, _parentobj._collide_hurtbox)){
					if(_parentobj._curstate == STATE_JUMP) return;
				
					//get objects
					var num = place_meeting_num(x, y, _parentobj._collide_hurtbox);
					var obj = instance_place(x, y, _parentobj._collide_hurtbox[num]);
					var objmask = obj._parentobj;
			
					//objects exist
					if(instance_exists(obj) && instance_exists(objmask)){
						//states align
						if(!objmask._grabdodge && objmask._grabfall && !objmask._death && !objmask._fall_ko && abs(_parentobj._height-objmask._height) < 280 && abs(_parentobj.y-objmask.y) < 96){
							if(_parentobj._curstate == STATE_JUMP && !_parentobj._hop_walk) return;
							
							//ko
							_parentobj._stuntimer = 0;
							_parentobj._stunpunch = 0;
							_parentobj._successparry = 0;
							
							_parentobj._hurttimer = 0;
							_parentobj._hp -= 3*_parentobj._dmgmultiplier*_parentobj._combohit;
							
							with(_parentobj){
								combohit();
							}
					
							_parentobj._height = _parentobj._groundlevel+1;
							_parentobj._vspd = 10;
							_parentobj._jump = true;
							
							_parentobj._curdir = objmask._curdir;
							_parentobj._falls = 0;
							_parentobj._falling = true;
							_parentobj._fixwall = true;
			
							_parentobj._dmgcoold = 0;
			
							sfx_stop_array(global._kdsounds);
							sfx_play_choose(global._kdsounds);
					
							_parentobj._freeze = 10*global._freezevals[global._freezeval];
							objmask._freeze = 10*global._freezevals[global._freezeval];
							if(has_trait(TRAIT_HP, _parentobj)){
								ui_hp_stuff(_parentobj);
							}
							if(has_trait(TRAIT_HP, objmask)){
								ui_hp_stuff(objmask);
							}
						}
					}
				}
			}
		
			if(_parentobj != noone && instance_exists(_parentobj)){
				x = _parentobj.x + _offset[0];
				y = (_parentobj.y + _offset[1]) - _parentobj._height;
				_curdir = _parentobj._curdir;
			
				var dodge = false;
			
				//receiving damage
				var blockko = false;
				var idleko = false;
				if(_parentobj._attack && _parentobj._attacktype == "blockko"){
					blockko = true;
				}
				if(_parentobj._attack && _parentobj._attacktype == "idle" && abs(_parentobj._slidespd) > 0){
					idleko = true;
				}
				if(_parentobj._startTimer <= 0 && !_parentobj._death && _parentobj._sequence_finished && _parentobj._phaseend_act == 0 && !_parentobj._stunlock_dodge && _parentobj._stunlock_after <= 0){
					if(has_trait(TRAIT_HURT, _parentobj) && _parentobj._immunetimer <= 0 && !blockko && !idleko && !_parentobj._dmgfall && _parentobj._dodgetimer == 0 && _parentobj._hurttimer == 0 && !_parentobj._grabbed){
						if(place_meeting(x, y, obj_punchhitbox)){
							var atk_obj = instance_place(x, y, obj_punchhitbox);
							var atk_parent = atk_obj._parentobj;
							
							if(atk_obj._delay > 0) return;
							
							if(instance_exists(atk_parent)){
								if((_parentobj._curstate == STATE_JUMP && !_parentobj._hop_walk) && !array_contains(_parentobj._jumphit, atk_parent._attacktype)) return;
							}
							
							if(atk_parent._successparry <= 0 && _parentobj._successparry > 0){
								_parentobj._successparry = 0;
							}
							
							//prevent blocking from special attacks
							if(instance_exists(atk_obj)){
								if((atk_obj._ptype == "pl" || atk_obj._ptype == "all") && atk_obj._damage == ATK_MASH || atk_obj._damage == ATK_MASHKO || atk_obj._slam){
									if(!has_trait(TRAIT_BLOCK_MASH, _parentobj)){
										_parentobj._mashblock = 10;
									}
								}
							}
							
							if(_parentobj._mashblock > 0){
								_parentobj._curstate = STATE_OTHER;
								_parentobj._blockcount = false;
								_parentobj._blocktimer = 0;
								_parentobj._block = false;
							}
							
							if((atk_obj._ptype == "pl" || atk_obj._ptype == "all") && atk_obj._damage != ATK_MASH && atk_obj._damage != ATK_MASHKO){ //prevent dodging from special attacks
								if(has_trait(TRAIT_DODGE, _parentobj)){
									if(instance_exists(atk_obj) && instance_exists(atk_parent)){
										if(!has_trait(TRAIT_STUN, _parentobj) || (has_trait(TRAIT_STUN, _parentobj) && _parentobj._stuntimer == 0)){
											//dodge attacks
											_parentobj._dh_atk = 10;
											_parentobj._dh_atk_inst = atk_parent;
											_parentobj._dh_atk_dir = atk_obj._curdir;
											
											if(atk_parent._attacktype == "air"){
												if(array_contains(_parentobj._dodgezones, atk_parent._attacktype)){
													if(!_parentobj._falling && _parentobj._curstate != STATE_JUMP){
														with(_parentobj){
															if(!_dohop){
																scr_hopspot(HOP_BACK);
								
																if(scr_enemyscript_calculatejump(0)){
																	_dohop = true;
																}
															}
														}
														dodge = true;
													} else {
														dodge = false;
													}
												}
											} else if(atk_parent._attacktype == "crouch"){
												if(array_contains(_parentobj._dodgezones, atk_parent._attacktype)){
													if(!_parentobj._falling){
														if(atk_parent.x < _parentobj.x){
															_parentobj._curdir = DIR_R;
														} else {
															_parentobj._curdir = DIR_L;
														}
														with(_parentobj){
															if(!_fall_ko || !_standup){
																_displayobj.image_index = 0;
															}
															_fall_ko = true;
															_jump = true;
															_standup = true;
															_height = _groundlevel + 1;
															_vspd = random_range(12,17);
															_dodge = true;
															_curspd = [0,0];
															clearpath();
														}
														dodge = true;
													}
												}
											} else if(atk_parent._attacktype == "idle" || atk_parent._attacktype == "upper"){
												if(array_contains(_parentobj._dodgezones, atk_parent._attacktype)){
													if(_parentobj._dodgetimer == 0){
														if(atk_obj._damage != ATK_MASH && !_parentobj._falling){
															if(!_parentobj._falling){
																_parentobj._curdir = -atk_obj._curdir;
															}
														
															//push back
															with(_parentobj){
																_displayobj.image_index = 0;
									
																if(_curdir == DIR_R){
																	if(!place_meeting_array(x-8, y, _collide_solid) && !place_meeting_array(x-8, y, _collide_other)){
																		x -= 8;
																	}
																} else if(_curdir == DIR_L){
																	if(!place_meeting_array(x+8, y, _collide_solid) && !place_meeting_array(x+8, y, _collide_other)){
																		x += 8;
																	}
																}
															}
												
															_parentobj._dodgetimer = 14;
															_parentobj._dodges ++;
															
															_parentobj._stuntimer = 0;
															_parentobj._stun = false;
															_parentobj._stunact = 0;
														
															dodge = true;
														}
													}
												}
											}
									
											if(!_parentobj._blockroll && atk_obj._type == "roll"){
												dodge = false;
											}
											
											if(_parentobj._panictimer > 0){
												dodge = false;
											}
									
											if(atk_obj._slam){
												dodge = false;
											}
										}
									}
									
									if(_parentobj._mashblock > 0){
										dodge = false;
									}
								}
							} else {
								dodge = false;
							}

							if(!dodge && instance_exists(atk_obj) && instance_exists(atk_parent)){
								if(_parentobj._block){
									for(var i = 0; i < array_length(_parentobj._block_endzones); i++){
										if(atk_parent._attacktype == _parentobj._block_endzones[i]){
											//do not block
											_parentobj._blocktimer = 0;
											_parentobj._block = false;
										}
									}
								}
								if(_parentobj._block && _parentobj._blockfailcooldown <= 0 && atk_parent._attacktype != "crouch" && atk_parent._attacktype != "slide"){
									if(!_parentobj._falling){
										//block attacks
										if(!atk_obj._persist){
											var p = instance_create_depth(_parentobj.x, _parentobj.y, 0, obj_particle);
											if(atk_obj._type != "air"){
												p._type = "fx"+string(choose(1,2));
											} else {
												p._type = "fx"+string(choose(3,4));
											}
											p._damage = atk_obj._damage;
											p._curdir = atk_obj._curdir;
															
											sfx_play_choose([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
											
											_parentobj._blockfailcooldown = 8;
										}
										
										if(!_parentobj._falling){
											_parentobj._curdir = -atk_obj._curdir;
										}
										
										_parentobj._hurttimer = 0;
										
										if(instance_exists(atk_parent) && instance_exists(atk_obj)){
											if(atk_obj._damage == ATK_NORM){ //this is necessary ok
												if(atk_parent._mashact == 0){
													with(atk_obj){
														if(_damage == ATK_NORM){
															instance_destroy();
														}
													}
												}
											}
										}
									}
								} else {
									if(instance_exists(atk_obj) && instance_exists(atk_parent)){
										//check blind zone
										var checkx = 64;
										var checky = 90;
										var yoffset = 12;
										var downattack = 0;
										if(variable_instance_exists(atk_parent,"_downattack")){
											if(atk_parent._downattack > 0){
												downattack = atk_parent._downattack;
											}
										}
										if(atk_parent._attacktype == "crouch"){
											checky = 120;
										}
										if(atk_obj._damage == ATK_MASH){
											checky = 150;
										}
										
										if(downattack > 0 || (atk_obj._damage == ATK_KO || (atk_obj._damage != ATK_KO && (atk_obj._curdir == DIR_L && _parentobj.x <= atk_parent.x-checkx) || (atk_obj._curdir == DIR_R && _parentobj.x >= atk_parent.x+checkx)))){
											//check other conditions
											var checkheight = [210,70];
											if(_parentobj._codename == "fridge" && (atk_parent._attacktype == "upper" || atk_parent._attacktype == "doublekick")){
												checkheight = [210,280];
											}
											
											if((atk_obj._ptype == "pl" || atk_obj._ptype == "all") && atk_parent.id != _parentobj.id && (downattack > 0 || (diff_abs(atk_parent.y, _parentobj.y+yoffset) <= checky && diff_abs(atk_parent._height, _parentobj._height) <= checkheight[0] && diff_abs(atk_obj._height, _parentobj._height) <= checkheight[1]))){
												var doblock = false;
												
												//enemy blocking
												if(has_trait(TRAIT_BLOCK, _parentobj) && !_parentobj._falling && !_parentobj._fall_ko){
													doblock = true;
													if(_parentobj._blockcd <= 0){
														_parentobj._blockcount ++;
														_parentobj._blockcd = 6;
													}
													if(_parentobj._blockcount >= _parentobj._maxblockcount){
														for(var i = 0; i < array_length(_parentobj._block_endzones); i++){
															if(atk_parent._attacktype == _parentobj._block_endzones[i]){
																//do not block
																doblock = false;
															}
														}
														
														if(!_parentobj._blockroll && atk_obj._type == "roll"){
															doblock = false;
														}
														
														if(doblock){
															if(!_parentobj._block){
																if(atk_obj._persist){
																	var p = instance_create_depth(_parentobj.x, _parentobj.y, 0, obj_particle);
																	if(atk_obj._type != "air"){
																		p._type = "fx"+string(choose(1,2));
																	} else {
																		p._type = "fx"+string(choose(3,4));
																	}
																	p._damage = atk_obj._damage;
																	p._curdir = atk_obj._curdir;
															
																	sfx_play_choose([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
																}
															}
															
															if(_parentobj._mashblock <= 0 && _parentobj._attacktype != "blockko"){
																_parentobj._curstate = STATE_BLOCK;
																_parentobj._blocktimer = scr_ailevel(26,50, _parentobj);
																
																if(!_parentobj._block && _parentobj._anim != "blockko"){
																	(_parentobj._displayobj).image_index = 0;
																}
																
																_parentobj._block = true;
															}
														}
													} else {
														doblock = false;
													}
													
													if(_parentobj._mashblock > 0){
														doblock = false;
													}
												}
												
												if(!doblock){
													if(_parentobj._show_hits){
														//show hurt animation
														if(instance_exists(atk_obj)){
															_parentobj._successparry = 0;
															
															_parentobj._dh_atk = 10;
															_parentobj._dh_atk_inst = atk_parent;
															_parentobj._dh_atk_dir = atk_obj._curdir;
								
															_parentobj._dh_atk_taunt = 380;
															_parentobj._dh_atk_taunt_inst = atk_parent;
								
															_parentobj._walkto = [_parentobj.x,_parentobj.y];
															if(!_parentobj._falling && (atk_obj._damage == ATK_NORM || atk_obj._damage == ATK_MASH)){
																if(_parentobj._panictimer <= 0){
																	_parentobj._curdir = -atk_obj._curdir;
																}
															}
										
															if(atk_obj._damage != ATK_MASH && atk_obj._damage != ATK_MASHKO){
																_parentobj._apply_hits = true;
															}
															
															_parentobj._hurtanim ++;
															if(_parentobj._hurtanim > _parentobj._hurtanims){
																_parentobj._hurtanim = 1;
															}
															var htimer = 12;
															_parentobj._hurttimer = htimer;
															atk_parent._atk_timer = 10;
															atk_parent._hits ++;
															atk_parent._hittimer = htimer;
															
															with(_parentobj){
																combohit();
															}
										
															//push back
															if(!_parentobj._falling){
																with(_parentobj){
																	if(_curdir == DIR_R){
																		if(!place_meeting_array(x-8, y, _collide_solid) && !place_meeting_array(x-8, y, _collide_other)){
																			x -= 8;
																		}
																	} else if(_curdir == DIR_L){
																		if(!place_meeting_array(x+8, y, _collide_solid) && !place_meeting_array(x+8, y, _collide_other)){
																			x += 8;
																		}
																	}
																}
															} else {
																if(atk_parent._attacktype == "idle"){
																	if(_parentobj._boundwall.left > 0 || _parentobj._boundwall.right > 0){
																		if(_parentobj._boundwall.left > 0){
																			_parentobj._curdir = DIR_R;
																			_parentobj._falldir = _parentobj._curdir;
																		} else if(_parentobj._boundwall.right > 0){
																			_parentobj._curdir = DIR_L;
																			_parentobj._falldir = _parentobj._curdir;
																		}
																		_parentobj._vspd = -4;
																	} else {
																		_parentobj._vspd = 3;
																	}
																	
																	var dmgnums = instance_create_depth(x+_parentobj._dmgoffset[0], y-((_parentobj.sprite_height * 2))+_parentobj._dmgoffset[1], 0, obj_nums);
																    dmgnums._num = max(1,floor(_parentobj._hplastframe - _parentobj._hp));
																	_parentobj._hplastframe = _parentobj._hp;
																}
															}
															
															if(atk_parent._attacktype == "idle"){
																_parentobj._stunlock_timer = _parentobj._stunlock_formula;
																if(!_parentobj._falling){
																	_parentobj._stunlock_hits += 0.16;
																} else {
																	_parentobj._stunlock_hits += 0.4;
																}
															}
											
															//ui
															if(instance_exists(_parentobj)){
																if(has_trait(TRAIT_HP, _parentobj)){
																	ui_hp_stuff(_parentobj);
																}
															}
											
															//show hits
															if(_parentobj._apply_hits){
																scr_showhits();
															}
											
															//particle
															var p = instance_create_depth(_parentobj.x, _parentobj.y, 0, obj_particle);
															if(atk_obj._type != "air"){
																p._type = "fx"+string(choose(1,2));
															} else {
																p._type = "fx"+string(choose(3,4));
															}
															p._damage = atk_obj._damage;
															p._curdir = atk_obj._curdir;
											
															sfx_play_choose(global._punchsounds[0]);
											
															if(instance_exists(atk_parent) && instance_exists(atk_obj)){
																if(atk_obj._damage == ATK_NORM){
																	if(atk_parent._mashact == 0){
																		with(atk_obj){
																			if(_damage == ATK_NORM){
																				instance_destroy();
																			}
																		}
																	}
																}
															}
														}
											
														_parentobj._show_hits = false;
													}
										
													if(_parentobj._ko_cooldown > 0){
														_parentobj._show_hits = false;
													}
													
													//block cancel
													if(_parentobj._blocktimer > 0){
														if(atk_obj._curdir == _parentobj._curdir){
															_parentobj._curstate = STATE_OTHER;
															_parentobj._blocktimer = 0;
															_parentobj._block = false;
														}
													}
													
													//actual damaging
												
													if(instance_exists(atk_obj)){
														switch(atk_obj._damage){
															case ATK_NORM:
																//exceptions
																if(array_length(_parentobj._typeallowed) > 0){
																	if(!array_contains(_parentobj._typeallowed, atk_parent._attacktype)) return;
																}
																if(!array_contains(_parentobj._atkallowed,ATK_NORM)) return;
																if(_parentobj._slide) return;
																if(_parentobj._parachute) return;
																if(variable_instance_exists(atk_parent, "_lowkick_dive")){
																	if(atk_parent._lowkick_dive && !atk_parent._attack) return;
																}
																
																if(_parentobj._spin){
																	//block non air punches when spinning
																	var p = instance_create_depth(_parentobj.x, _parentobj.y, 0, obj_particle);
																	if(atk_obj._type != "air"){
																		p._type = "fx"+string(choose(1,2));
																	} else {
																		p._type = "fx"+string(choose(3,4));
																	}
																	p._damage = atk_obj._damage;
																	p._curdir = atk_obj._curdir;
															
																	sfx_play_choose([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
																	
																	if(instance_exists(atk_obj)){
																		instance_destroy(atk_obj.id);
																	}
																	
																	return;
																}
																
																//juggling with idle attack
																if(_parentobj._falling && _parentobj._fall_ko && (atk_parent._attacktype != "idle" || _parentobj._height <= _parentobj._groundlevel+72 || _parentobj._height >= _parentobj._groundlevel+256)){
																	_parentobj._show_hits = false;
																	return;
																}
																
																//down attack
																if(variable_instance_exists(atk_parent, "_downattack")){
																	if(_parentobj._fall_ko && !_parentobj._standup && atk_parent._downattack <= 0){
																		_parentobj._show_hits = false;
																		return;
																	}
																}
																
																if(variable_instance_exists(atk_parent, "_downattack")){
																	if(atk_parent._downattack > 0){
																		_parentobj._stunlock_timer = _parentobj._stunlock_formula;
																		_parentobj._stunlock_hits += 0.2;
																		_parentobj._downhurt = 10;
																	}
																}
																
																if(_parentobj._hurts < atk_parent._totalhits){
																	with(obj_camera){
																		_ampX = 12;
																		_ampY = 12;
																	}
																		
																	global._pad_vibrate = 2;
													
																	//combo
																	var timer = 42;
											
																	if(_parentobj._fall_ko) _parentobj._kotimer = 0;
											
																	_parentobj._hurt_combotime = timer;
																	_parentobj._hurts ++;
											
																	_parentobj._hitadd += 0.4;
																	_parentobj._hitadd_timer = timer;
											
																	_parentobj._hp -= (1+atk_obj._add_damage)*_parentobj._dmgmultiplier*_parentobj._combohit;
																	_parentobj._curatk = 0;
													
																	atk_parent._freeze = global._freezeFrames.vshort_freeze;
																	_parentobj._freeze = global._freezeFrames.vshort_freeze;
													
																	if(_parentobj._stuntimer > 0){
																		//reset stun
																		if(_parentobj._stuntimer >= 30){
																			_parentobj._stun = true;
																			_parentobj._stunact = 0;
																			_parentobj._stuntimer = 120-(_parentobj._stunpunch*23);
																			_parentobj._stunpunch ++;
																		} else {
																			_parentobj._stun = false;
																			_parentobj._stunact = 0;
																			_parentobj._stuntimer = 0;
																			_parentobj._stunpunch = 0;
																		}
																	}
													
																	//death
																	if(_parentobj._hp <= 2 && !_dofreeze){
																		_parentobj._hp = 0;
																		if(atk_obj._ptype == "pl"){
																			with(atk_parent){
																				if(!_slam){
																					_displayobj.image_index = 0;
																					_attack = true;
																					_attacktype = "idle";
																					if(_downattack > 0) _attacktype = "down";
																					_finalcombo = true;
																				}
																			}
																			if(atk_parent._downattack > 0){
																				(_parentobj._displayobj)._forcedepth = (atk_parent._displayobj).depth-32;
																			}
																		}
																		if(variable_instance_exists(atk_parent, "_downattack")){
																			if(atk_parent._downattack > 0) _parentobj._downkill = true;
																		}
																		atk_parent._freeze = global._freezeFrames.long_freeze;
																		_parentobj._freeze = global._freezeFrames.long_freeze;
																		_dofreeze = true;
																		with(_parentobj){
																			clearpath();
																			do_ko();
																		}
																	}
													
																	_parentobj._show_hits = true;
																} else {
																	//ko
																	with(obj_camera){
																		_ampX = 20;
																		_ampY = 20;
																	}
																		
																	global._pad_vibrate = 4;
																		
																	if(_parentobj._fatalko){
																		_parentobj._hp = 0;
														
																		if(atk_obj._ptype == "pl"){
																			with(atk_parent){
																				if(!_slam){
																					_displayobj.image_index = 0;
																					_attack = true;
																					_attacktype = "idle";
																					if(variable_instance_exists(self.id, "_downattack")){
																						if(_downattack > 0) _attacktype = "down";
																					}
																					_finalcombo = true;
																				}
																			}
																			if(atk_parent._downattack > 0){
																				(_parentobj._displayobj)._forcedepth = (atk_parent._displayobj).depth-32;
																			}
																		}
																		if(variable_instance_exists(atk_parent, "_downattack")){
																			if(atk_parent._downattack > 0) _parentobj._downkill = true;
																		}
																		atk_parent._freeze = global._freezeFrames.long_freeze;
																		_parentobj._freeze = global._freezeFrames.long_freeze;
																	} else {
																		if(atk_obj._ptype == "pl"){
																			with(atk_parent){
																				if(!_slam){
																					_displayobj.image_index = 0;
																					_attack = true;
																					_attacktype = "idle";
																					if(variable_instance_exists(self.id, "_downattack")){
																						if(_downattack > 0) _attacktype = "down";
																					}
																					_finalcombo = true;
																				}
																			}
																			if(atk_parent._downattack > 0){
																				(_parentobj._displayobj)._forcedepth = (atk_parent._displayobj).depth-32;
																			}
																		}
																		atk_parent._freeze = global._freezeFrames.long_freeze;
																		_parentobj._freeze = global._freezeFrames.long_freeze;
																	
																		with(_parentobj){
																			clearpath();
																			do_ko();
																			combohit();
																		}
											
																		_parentobj._hurttimer = 0;
																		_parentobj._hp -= (3+floor(_parentobj._hitadd)+atk_obj._add_damage)*_parentobj._dmgmultiplier*_parentobj._combohit;
																		_parentobj._hitadd = 0;
																	}
														
																	_parentobj._show_hits = true;
																		
																	_parentobj._dmgcoold = 0;
																		
																	sfx_stop_array(global._punchsounds[0]);
																	sfx_stop_array(global._kdsounds);
																	sfx_play_choose(global._kdsounds);
																}
																
																atk_parent._success_hit = 4;
															break;
															case ATK_KO:
																if(_parentobj._ko_cooldown <= 0){
																	//exceptions
																	if(array_length(_parentobj._typeallowed) > 0){
																		if(!array_contains(_parentobj._typeallowed, atk_parent._attacktype)) return;
																	}
																	if(!array_contains(_parentobj._atkallowed,ATK_KO)) return;
																	if(variable_instance_exists(atk_parent, "_lowkick_dive")){
																		if(atk_parent._lowkick_dive && !atk_parent._attack) return;
																	}
																	if(atk_parent._attacktype == "air" && !_parentobj._falling && _parentobj._fall_ko) return;
																	if(atk_parent._attacktype == "air" && _parentobj._falling && atk_parent < _parentobj._height) return;
																	if((atk_parent._attacktype == "crouch" || atk_parent._attacktype == "slide") && (_parentobj._falling && !_parentobj._fall_ko && _parentobj._height < _parentobj._groundlevel+48) || (_parentobj._falling && _parentobj._height >= _parentobj._groundlevel+48)) return;
																	if(atk_parent._attacktype == "upper" && !_parentobj._falling && _parentobj._fall_ko) return;
													
																	if(atk_parent._attacktype == "upper" && _parentobj._falling && _parentobj._height < atk_parent._height+40) return;
																	if(atk_parent._attacktype == "upper" && _parentobj._slide) return;
																	if(atk_parent._attacktype == "crouch" && _parentobj._slide) return;
																	if((atk_parent._attacktype == "crouch" || atk_parent._attacktype == "slide") && _parentobj._height > atk_parent._height+48) return;
																	if((atk_parent._attacktype == "crouch" || atk_parent._attacktype == "slide") && (_parentobj._standup || _parentobj._falling || _parentobj._grabout || _parentobj._grabfall || _parentobj._grabdodge)) return;
																	if(atk_parent._attacktype == "slide" && _parentobj._falls == 1) return;
																	if(variable_instance_exists(atk_parent, "_runroll")){
																		if(atk_parent._attacktype != "air"){
																			if((atk_parent._runroll || atk_parent._runroll_dive) && atk_parent._height <= atk_parent._groundlevel+8 && _parentobj._standup) return;
																		}
																	}
																	if(atk_parent._attacktype != "air" && _parentobj._spin){
																		//block non air punches when spinning
																		var p = instance_create_depth(_parentobj.x, _parentobj.y, 0, obj_particle);
																		if(atk_obj._type != "air"){
																			p._type = "fx"+string(choose(1,2));
																		} else {
																			p._type = "fx"+string(choose(3,4));
																		}
																		p._damage = atk_obj._damage;
																		p._curdir = atk_obj._curdir;
															
																		sfx_play_choose([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
																		
																		if(instance_exists(atk_obj)){
																			instance_destroy(atk_obj.id);
																		}
																		
																		return;
																	}
													
																	if(_parentobj._fallfloat) return;
																	
																	if(_parentobj._spin){
																		_parentobj._ko_cooldown = 30;
																		
																		if(_parentobj._spinatk != noone && instance_exists(_parentobj._spinatk)){
																			(_parentobj._spinatk)._delay = 90;
																		}
																		
																		with(obj_camera){
																			_ampX = 16;
																			_ampY = 16;
																		}
																		
																		global._pad_vibrate = 4;
														
																		atk_parent._freeze = global._freezeFrames.long_freeze;
																		_parentobj._freeze = global._freezeFrames.long_freeze;
																		
																		if(!_parentobj._boss){
																			_parentobj._hp -= (5+floor(_parentobj._hitadd)+atk_obj._add_damage)*_parentobj._dmgmultiplier*_parentobj._combohit;
																		} else {
																			_parentobj._hp -= 3;
																		}
																		
																		_parentobj._hitadd = 0;
																			
																		_parentobj._spinhits ++;
																			
																		//ui
																		if(instance_exists(_parentobj)){
																			if(has_trait(TRAIT_HP, _parentobj)){
																				ui_hp_stuff(_parentobj);
																			}
																		}
																			
																		sfx_stop_array(global._kdsounds);
																		sfx_play_choose(global._kdsounds);
																			
																		var dmgnums = instance_create_depth(x+_parentobj._dmgoffset[0], y-((_parentobj.sprite_height * 2)+150)+_parentobj._dmgoffset[1], 0, obj_nums);
																        dmgnums._num = max(1,floor(_parentobj._hplastframe - _parentobj._hp));
																		_parentobj._hplastframe = _parentobj._hp;	
																		
																		return;
																	}
													
																	var hench_stuck_in_ground = false;
																	var maxslamdown = 2;
																	if(_parentobj._codename == "st2_enm1"){
																		if(variable_instance_exists(_parentobj.id,"_hn_shake")){
																			if(atk_parent._attacktype == "air" && _parentobj._hn_shake > 0){
																				hench_stuck_in_ground = true;
																			}
																		}
																	}
																	
																	if(!hench_stuck_in_ground){
																		if(variable_instance_exists(atk_parent, "_downattack")){
																			if(atk_parent._downattack > 0){
																				_parentobj._downhurt = 10;
																			}
																		}
																		
																		if(_parentobj._falling || _parentobj._fall_ko){
																			_parentobj._stunlock_timer = _parentobj._stunlock_formula;
																			_parentobj._stunlock_hits += 0.7;
																		} else {
																			if(atk_parent._attacktype == "upper"){
																				_parentobj._stunlock_timer = _parentobj._stunlock_formula;
																				_parentobj._stunlock_hits += 0.7;
																			}
																		}
																		
																		_parentobj._dh_atk = 10;
																		_parentobj._dh_atk_inst = atk_parent;
																		_parentobj._dh_atk_dir = atk_obj._curdir;
													
																		_parentobj._dh_atk_taunt = 380;
																		_parentobj._dh_atk_taunt_inst = atk_parent;
																		
																		//uppercut jump block
																		if(_parentobj._curstate == STATE_JUMP){
																			_parentobj._attack = false;
																			_parentobj._curstate = STATE_OTHER;
																			_parentobj._hopslide = false;
																			_parentobj._height = _parentobj._groundlevel + 64;
																			_parentobj._hop_arc = 0;
																		}
																		
																		if(atk_parent._attacktype == "air"){
																			_parentobj._stunlock_timer = _parentobj._stunlock_formula;
																			_parentobj._stunlock_hits += 1;
																		
																			atk_parent._state = "jump";
																			atk_parent._runroll_dive = false;
																			atk_parent._runroll = false;
																			atk_parent._jump_enmhit = true;
																		}
																	}
													
																	//air ko attack
																	if(!hench_stuck_in_ground && atk_parent._attacktype == "air" && ((_parentobj._falling && !_parentobj._ko_fall && atk_parent._height >= _parentobj._height) || _parentobj._fallfloat)){
																		//if(_parentobj._vspd >= 4) return;
													
																		_parentobj._hurts = 0;
																		
																		if(atk_obj._ptype == "pl"){
																			with(atk_parent){
																				_finalcombo = false;
																				_did_ko = 0;
																			}
																		}
															
																		//instant fall from air ko
																		with(obj_camera){
																			_ampX = 22;
																			_ampY = 22;
																		}
																		
																		global._pad_vibrate = 4;
													
																		_parentobj._hp -= (2+floor(_parentobj._hitadd)+atk_obj._add_damage)*_parentobj._dmgmultiplier*_parentobj._combohit;
													
																		var p = instance_create_depth(x+(64*_curdir),y+48,depth, obj_particle);
																		p._type = "fx4";
													
																		_parentobj._hurttimer = 0;
														
																		_parentobj._kotimer = 0;
																		_parentobj._standup = false;
														
																		_parentobj._fallcd = 0;
																		_parentobj._height = _parentobj._groundlevel+8;
																		_parentobj._vspd = -2;
																		_parentobj._falls = 0;
													
																		with(_parentobj){
																			combohit();
																		}
													
																		if(!atk_obj._slam){
																			atk_parent._force_freeze = global._freezeFrames.long_freeze-3;
																			_parentobj._force_freeze = global._freezeFrames.long_freeze-3;
																			_parentobj._smackdown = true;
																		}
													
																		_parentobj._ko_cooldown = 20;
																		_parentobj._ko_fall = true;
																		_parentobj._fixwall = true;
													
																		sfx_stop_array(global._punchsounds[0]);
																		sfx_stop_array(global._kdsounds);
																		sfx_play_choose(global._kdsounds);
																		
																		_parentobj._dmgcoold = 0;
																		
																		_parentobj._show_hits = true;
																	} else {
																		if(!hench_stuck_in_ground){
																			_parentobj._hurttimer = 0;
																		}
																		
																		if(_parentobj._hurttimer <= 0){
																			if(!hench_stuck_in_ground){
																				_parentobj._hurts = 0;
																				if(atk_obj._ptype == "pl"){
																					with(atk_parent){
																						_finalcombo = false;
																						_did_ko = 0;
																					}
																				}
																			}
															
																			with(obj_camera){
																				_ampX = 16;
																				_ampY = 16;
																			}
																		
																			global._pad_vibrate = 4;
														
																			if(!atk_obj._slam){
																				atk_parent._freeze = global._freezeFrames.long_freeze;
																				_parentobj._freeze = global._freezeFrames.long_freeze;
																		
																				if(atk_obj._ptype == "pl" && atk_parent._runroll){
																					atk_parent._freeze = 4*global._freezevals[global._freezeval];
																					_parentobj._freeze = 4*global._freezevals[global._freezeval];
																				}
																			}
																			
																			if(_parentobj._fatalko){
																				_parentobj._hp = 0;
																			} else {
																				_parentobj._hp -= (2+floor(_parentobj._hitadd)+atk_obj._add_damage)*_parentobj._dmgmultiplier*_parentobj._combohit;
																			}
																			_parentobj._hitadd = 0;
																		}
														
																		if(hench_stuck_in_ground){
																			//henchie
																			if(variable_instance_exists(_parentobj.id,"_hn_shake")){
																				var partc = instance_create_depth(_parentobj.x, _parentobj.y-96, 0, obj_particle);
																				partc._type = "fx6";
																				
																				if(_parentobj._hurttimer <= 0 && _parentobj._hn_shake > 0){
																					if(_parentobj._hn_slamdown <= maxslamdown-1){
																						_parentobj._hn_slamdown ++;
																						_parentobj._hn_shake = 150;
																						_parentobj._hn_slamdown_timer = 24;
																						_parentobj._hn_slamdownsnd = false;
																					} else {
																						_parentobj._hn_shake = 2;
																					}
																				}
																			}
																		}
																		
																		if(!hench_stuck_in_ground){
																			with(_parentobj){
																				clearpath();
																				do_ko();
																			}
																				
																			_parentobj._dmgcoold = 0;
													
																			_parentobj._ko_cooldown = 20;
																		}
																		
																		if(!hench_stuck_in_ground){
																			_parentobj._show_hits = true;
																		} else {
																			if(_parentobj._hurttimer <= 0){
																				//ui
																				if(instance_exists(_parentobj)){
																					if(has_trait(TRAIT_HP, _parentobj)){
																						ui_hp_stuff(_parentobj);
																					}
																				}
																				
																				with(_parentobj){
																					combohit();
																				}
											
																				scr_showhits();
																			}
																		}
																		
																		if(_parentobj._hurttimer <= 0){
																			sfx_stop_array(global._punchsounds[0]);
																			sfx_stop_array(global._kdsounds);
																			sfx_play_choose(global._kdsounds);
																		}
																		
																		if(hench_stuck_in_ground){
																			_parentobj._hurttimer = 24;
																		}
																	}
																	
																	if(atk_obj._slam){
																		_parentobj._nocked = 0;
																	}
																} else {
																	_parentobj._show_hits = false;
																}
															break;
															case ATK_MASH:
																//exceptions
																if(!has_trait(TRAIT_MASHED, _parentobj)) return;
																if(_parentobj._falling || _parentobj._fall_ko) return;
																if(_parentobj._parachute) return;
																if(atk_parent._mashobj != noone && atk_parent._mashobj.id != _parentobj.id) return;
														
																if(_parentobj._slide){
																	_parentobj._slidespd = 0;
																	_parentobj._curstate = STATE_IDLE;
																	_parentobj._slide = false;
																}
																
																_parentobj._anim_transition = false;
														
																_parentobj._stunlock_hits = 0;
																_parentobj._stunlock_timer = 0;
														
																_parentobj._show_hits = true;
																_parentobj._apply_hits = false;
																atk_parent._mashsuccess = true;
												
																with(obj_camera){
																	_ampX = 9;
																	_ampY = 9;
																}
																
																if(_parentobj._hp % 2 == 0){
																	global._pad_vibrate = 2;
																}
																
																global._mashZoom = true;
																global._mashZoomTimer = 16;
																global._mashinst = atk_parent._displayobj;
									
																_parentobj._combohit = 1;
									
																_parentobj._hurts = 0;
																_parentobj._hurttimer = 8;
																_parentobj._hp -= (1+atk_obj._add_damage)*_parentobj._dmgmultiplier*_parentobj._combohit;

																if(array_length(_parentobj._mashhurt_pool) == 0){
																	for(var m = 0; m < _parentobj._mashhurt_max; m++){
																		_parentobj._mashhurt_pool[m] = m;
																	}
																}
																
																var curhurt = irandom_range(0, array_length(_parentobj._mashhurt_pool)-1);
																if(array_length(_parentobj._mashhurt_pool) > 0){
																	_parentobj._mashhurt = _parentobj._mashhurt_pool[curhurt];
																	array_delete(_parentobj._mashhurt_pool, curhurt, 1);
																}
												
																_parentobj._mashed = true;
																_parentobj._mashedobj = atk_parent;
																atk_parent._mashenemy = 16;
																if(atk_parent._mashobj == noone){
																	atk_parent._mashobj = _parentobj;
																}
										
																sfx_play_choose(global._punchsounds[1]);
															break;
															case ATK_MASHKO:
																if(_parentobj._falling || _parentobj._fall_ko) return;
																if(!_parentobj._mashed) return;
																if(atk_parent._mashobj != noone && atk_parent._mashobj.id != _parentobj.id) return;
											
																_parentobj._show_hits = true;
																_parentobj._apply_hits = false;
												
																with(_parentobj){
																	clearpath();
																	do_ko();
																	
																	_mashdir = _curdir;
																	_aftermash = 3;
																	_combohit = 1;
																}
												
																if(!_parentobj._boss){
																	_parentobj._hurttimer = 0;
																	_parentobj._hp = 0;
																} else {
																	_parentobj._hurttimer = 0;
																	_parentobj._hp -= _parentobj._mashlosehp*_parentobj._dmgmultiplier*_parentobj._combohit;
																}
															break;
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		
			//damage numbers
			if(!global._tutorial && _parentobj._showDmg && has_trait(TRAIT_HURT, _parentobj) && _parentobj._immunetimer <= 0){
				if(global._finalhit <= 0 && !_parentobj._grabfall && _parentobj._hp < _parentobj._hplastframe && (_parentobj._height <= _parentobj._groundlevel || _parentobj._falling || _parentobj._slam) && _parentobj._dmgcoold <= 0){
					var dmgnums = instance_create_depth(x+_parentobj._dmgoffset[0], y-((_parentobj.sprite_height * 2)+150)+_parentobj._dmgoffset[1], 0, obj_nums);
			        dmgnums._num = max(1,floor(_parentobj._hplastframe - _parentobj._hp));
					_parentobj._hplastframe = _parentobj._hp;
					_parentobj._dmgcoold = 2;
				}
			}
		}
	}
}