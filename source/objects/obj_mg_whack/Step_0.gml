{
	_earned = clamp(_score - _monyx, 0, 9999999);
	global._addmonyx = _earned;
	with(obj_pause){
		_curmonyx = other._score;
		_totalmonyx = other._monyx;
	}
	
	if(!global._pause && !global._gameover_stopall){
		_skyframe += 0.02;
		if(_skyframe >= 3){
			_skyframe = 0;
		}
		
		//check input type
		_inptype = WHACK_INPUT_MOUSE;
		if(!global._menumouse || global._inptype == 1){
			//mouse hidden or using gamepad
			global._forcecustorstop = 5;
			_inptype = WHACK_INPUT_KEY;
		}
		if(global._buildver == HTML){
			_inptype = WHACK_INPUT_MOUSE;
		}
		
		if(_inptype == WHACK_INPUT_MOUSE){
			_curspot = [2,1];
		}
		
		if(!_init){
			for(var yy = 0; yy < array_length(_spots); yy++){
				_flames_rows[yy] = [-1,-1,-1];
				for(var xx = 0; xx < array_length(_spots[yy]); xx++){
					if(_spots[yy][xx]){
						_spots_scale[yy][xx] = [1,1];
						_spots_particle[yy][xx] = 2;
					} else {
						_spots_scale[yy][xx] = [0,0];
						_spots_particle[yy][xx] = 0;
					}
					
					//set enemy states and animations for each spot
					_enemystate[? string(xx)+" "+string(yy)] = {
						exists: false,
						bad: false,
						item: false,
						codename: "",
						anim: "",
						spr: -1,
						img: 0,
						scale: [_enmscale,_enmscale],
						sintimer: 0,
						
						offset: [0,0],
						
						row: 0,
						spot: 0,
						
						posx: -1,
						posy: -1,
						
						width: 200,
						height: 150,
						setbbox: false,
						bbox: [0,0,0,0],
					
						timer: 0,
						act: 0,
						pose: 0,
						
						amp: 0,
						
						on: false,
						
						itemhp: 0,
						itemtnt: 0,
						refill: false,
						
						fried: false,
						
						boss: false,
						maxhp: 1,
						hp: 1,
						hpcol: c_white,
						blockpoints: 0,
						block: 0,
					}
				}
			}
		
			_init = true;
		} else {
			//music speed
			if(global._cursong != -1){
				var pitch = _mus_spd;
				if(_mus_spdup){
					pitch = _mus_spd * 1.2;
				}
				mus_pitch(clamp(pitch, 0.1, 3.5));
			}
			
			//adjust difficulty
			var diffc = 0;
			if(_bonked < 5){
				diffc = 1;
			}
			if(_bonked >= 8){
				//top spot
				_spots[0][2] = true;
				
				diffc = 2;
			}
			if(_bonked >= 18){
				//bottom spot
				_spots[2][2] = true;
				
				_bonkmultipl_start = 1;
				diffc = 17;
			}
			if(_bonked >= 27){
				//corner spots in the middle (top right and bottom left)
				_spots[0][3] = true;
				_spots[2][1] = true;
				
				diffc = 38;
			}
			if(_bonked >= 60){
				//corner spots in the middle (top left and bottom right)
				_spots[0][1] = true;
				_spots[2][3] = true;
				
				diffc = 46;
			}
			if(_bonked >= 145){
				if(_inptype == WHACK_INPUT_MOUSE){
					//middle left spot
					_spots[1][0] = true;
				}
				diffc = 52;
			}
			if(_bonked >= 150){
				if(_inptype == WHACK_INPUT_MOUSE){
					//middle right spot
					_spots[1][4] = true;
				}
				diffc = 58;
			}
			if(_bonked >= 250){
				diffc = 65;
			}
			if(_bonked >= 370){
				diffc = 100;
			}
			if(_bonked >= 500){
				diffc = 140;
			}
			if(_bonked >= 900){
				diffc = 200;
			}
			if(_bonked >= 1200){
				diffc = 270;
			}
			
			//adjust difficulty depending on input
			if(_inptype == WHACK_INPUT_KEY){
				_diffc_mode = 1;
			} else if(_inptype == WHACK_INPUT_MOUSE){
				_diffc_mode = 0.85;
			}
			
			_difficulty = diffc*_diffc_mode;
			
			if(_inptype == WHACK_INPUT_KEY){
				if(_spots[1][0]){
					_spots[1][0] = false;
					_spots_particle[1][0] = 0;
					_spots_scale[1,0] = [0,0];
					var spot = "0 1";
					if(ds_map_exists(_enemystate, spot)){
						_enemystate[? spot].exists = false;
					}
				}
				if(_spots[1][4]){
					_spots[1][4] = false;
					_spots_particle[1][4] = 0;
					_spots_scale[1,4] = [0,0];
					var spot = "4 1";
					if(ds_map_exists(_enemystate, spot)){
						_enemystate[? spot].exists = false;
					}
				}
			}
			
			var ent_value = max(16, random_range(70,120)-(_bonkmultipl*_difficulty));
			
			//spawn entities
			_enmtimer ++;
			
			if(!_howto && !_gameover && _boss_itemrefill <= 0 && _boss_itemrefill_timer <= 0){
				if(!_boss || (_boss && _boss_act == 4)){
					if(_enmtimer >= ent_value){
						if((!_spawnfirst && !_firstbonked) || _firstbonked){
							var spots = [];
							var n = 0;
							for(var yy = 0; yy < array_length(_spots); yy++){
								for(var xx = 0; xx < array_length(_spots[yy]); xx++){
									//check if spot exists
									if(_spots[yy][xx]){
										spots[n] = string(xx)+" "+string(yy);
										n ++;
									}
								}
							}
				
							var shuffle_spots = array_shuffle(spots);
							for(var i = 0; i < array_length(shuffle_spots); i++){
								var spot = shuffle_spots[i];
								if(!_spawnfirst){
									spot = "2 1";
								}
								if(!_enemystate[? spot].exists){
									var bad = true;
							
									//good entities code
									if(_bonked >= 20){
										if(irandom(6) == 2){
											bad = choose(true, false);
										}
								
										if(!_dialm){
											bad = false;
											_dialm = true;
										}
									}
							
									var isbad = bad ? "bad" : "good";
									var num = 0;
									if(bad){
										num = irandom_range(1,3);
									} else {
										num = 1;
									}
									var img = irandom_range(0,2);
									
									var smilechance = false;
									if(_boss){
										if(irandom(3) == 1){
											smilechance = choose(true, false);
										}
									}
									
									if(smilechance){
										bad = true;
									}
									
									//bonus items
									var bonuschance = false;
									if(_hp <= 20 && _enemystate[? "2 1"].codename != "boss"){
										if(irandom(15) == 1){
											bonuschance = choose(true, false);
										}
									}
									
									var bonus = irandom_range(1,2);
									if(bonuschance){
										if(_bonus_damageless > 0){
											bonus = 2;
										} else if(_bonus_scoremult > 0){
											bonus = 1;
										}
										if(_bonus_damageless > 0 && _bonus_scoremult > 0){
											bonus = 0;
										}
										smilechance = false;
										bad = false;
									}
									if(bonus == 0){
										bonuschance = false;
									}
									
									_enemystate[? spot].exists = true;
									_enemystate[? spot].bad = bad;
									_enemystate[? spot].item = false
									_enemystate[? spot].codename = isbad+string(num);
									
									_enemystate[? spot].blockpoints = 0;
									_enemystate[? spot].block = 0;
									
									if(smilechance){
										_enemystate[? spot].codename = "smile";
									}
									if(bonuschance){
										_enemystate[? spot].codename = "bonus"+string(bonus);
									}
									_enemystate[? spot].img = 0;
									_enemystate[? spot].sintimer = random(1000);
						
									_enemystate[? spot].row = real(string_char_at(spot, 3));
									_enemystate[? spot].spot = real(string_char_at(spot, 1));
						
									_enemystate[? spot].offset = [0,0];
									_enemystate[? spot].amp = 0;
						
									_enemystate[? spot].fried = false;
						
									_enemystate[? spot].timer = 0;
									_enemystate[? spot].act = WHACK_ACT_APPEAR;
						
									break;
								}
							}
				
							_spawnfirst = true;
				
							_enmtimer = 0;
						}
					}
				}
			}
			
			if(!_boss){
				if(!_gameover && _preboss_bonks >= 65+irandom_range(6,20)){
					//spawn boss
					
					_boss_shake = false;
					_bossphase = 0;
					_boss_hp = _boss_maxhp;
					_boss_timer = 0;
					_boss_act = 0;
					_boss = true;
				}
			} else {
				_preboss_bonks = 0;
				
				//boss behavior
				switch(_boss_act){
					case 0:
						//check if no entities are around before spawning the boss
						var exists = 0;
						var dskeys = ds_map_keys_to_array(_enemystate);
						for(var i = 0; i < array_length(dskeys); i++){
							if(ds_map_exists(_enemystate, dskeys[i])){
								if(_enemystate[? dskeys[i]].exists){
									exists ++;
								}
							}
						}
						if(exists == 0){
							_boss_timer = 0;
							_boss_act = 1;
						}
					break;
					case 1:
						_boss_timer ++;
						if(ds_map_size(_flames) == 0 && _boss_timer >= 24){
							var spot = _boss_spot;
							_enemystate[? spot].exists = true;
							_enemystate[? spot].bad = true;
							_enemystate[? spot].item = false
							_enemystate[? spot].codename = "lanky";
							_enemystate[? spot].img = 0;
							_enemystate[? spot].sintimer = random(1000);
						
							_enemystate[? spot].row = real(string_char_at(spot, 3));
							_enemystate[? spot].spot = real(string_char_at(spot, 1));
						
							_enemystate[? spot].offset = [0,0];
							_enemystate[? spot].amp = 0;
						
							_enemystate[? spot].fried = false;
							
							_enemystate[? spot].boss = true;
							_enemystate[? spot].hp = _boss_hp;
							_enemystate[? spot].maxhp = _boss_maxhp;
							_enemystate[? spot].hpcol = make_color_rgb(248, 204, 31);
							switch(_bossphase){
								case 0:
									_enemystate[? spot].blockpoints = 4;
								break;
								case 1:
									_enemystate[? spot].blockpoints = 7;
								break;
								case 2:
									_enemystate[? spot].blockpoints = 15;
								break;
								case 3:
									_enemystate[? spot].blockpoints = 22;
								break;
								case 4:
									_enemystate[? spot].blockpoints = 30;
								break;
							}
							_enemystate[? spot].block = 0;
						
							_enemystate[? spot].timer = 0;
							_enemystate[? spot].act = WHACK_ACT_APPEAR_BOSS;
							if(_boss_shake){
								_enemystate[? spot].act = WHACK_ACT_APPEAR;
								sfx_play(snd_whack_lanky_appear2);
							} else {
								sfx_play(snd_whack_boss_fitin);
							}
							_enemystate[? spot].anim = "boss_appear";
							
							_boss_bombtimer = 60;
							
							_boss_timer = 0;
							_boss_act = 2;
						}
					break;
					case 2:
						if(!_enemystate[? _boss_spot].exists){
							//boss is not found, respawn
							_boss_timer = 0;
							_boss_act = 1;
						}
					break;
					case 3:
						//wait a bit
						_boss_timer ++;
						if(_boss_timer >= 32){
							_boss_timer = 0;
							_boss_act = 4;
						}
					break;
					case 4:
						//boss is out, spawn enemies
					break;
				}
			}
			
			//spawn smile bombs
			if(!_gameover){
				if(_enemystate[? _boss_spot].exists && _enemystate[? _boss_spot].codename == "lanky" && _enemystate[? _boss_spot].act == WHACK_ACT_PRESENT){
					_boss_bombtimer ++;
					if(_boss_bombtimer >= max(30, random_range(45, 110)/((_bossphase+1)*0.6))){
						var spots = [];
						var n = 0;
						for(var yy = 0; yy < array_length(_spots); yy++){
							for(var xx = 0; xx < array_length(_spots[yy]); xx++){
								//check if spot exists
								var dontspawn = false;
								if(yy == 0 && xx == 2){
									dontspawn = true;
								}
								if(_spots[yy][xx] && !dontspawn){
									spots[n] = string(xx)+" "+string(yy);
									n ++;
								}
							}
						}
				
						var shuffle_spots = array_shuffle(spots);
						for(var i = 0; i < array_length(shuffle_spots); i++){
							var spot = shuffle_spots[i];
							if(!_enemystate[? spot].exists){
								_enemystate[? spot].exists = true;
								_enemystate[? spot].bad = true;
								_enemystate[? spot].item = false;
								_enemystate[? spot].codename = "smile";
							
								_enemystate[? spot].blockpoints = 0;
								_enemystate[? spot].block = 0;
							
								_enemystate[? spot].img = 0;
								_enemystate[? spot].sintimer = random(1000);
						
								_enemystate[? spot].row = real(string_char_at(spot, 3));
								_enemystate[? spot].spot = real(string_char_at(spot, 1));
						
								_enemystate[? spot].offset = [0,0];
								_enemystate[? spot].amp = 0;
						
								_enemystate[? spot].fried = false;
						
								_enemystate[? spot].timer = 0;
								_enemystate[? spot].act = WHACK_ACT_APPEAR;
							
								break;
							}
						}
						
						_boss_bombtimer = 0;
					}
				}
			}
			
			//update spots and entities
			for(var yy = 0; yy < array_length(_spots); yy++){
				for(var xx = 0; xx < array_length(_spots[yy]); xx++){
					if(_spots[yy][xx]){
						if(_spots_particle[yy][xx] == 0){
							_spots_particle[yy][xx] = 1;
						}
						_spots_scale[yy][xx][0] = lerp(_spots_scale[yy][xx][0], 1, 0.08);
						_spots_scale[yy][xx][1] = lerp(_spots_scale[yy][xx][1], 1, 0.16);
					}
					
					var curent = string(xx)+" "+string(yy);
					if(_enemystate[? curent].exists){
						if(_inptype == WHACK_INPUT_MOUSE){
							if(scr_mousehover(_enemystate[? curent].bbox[0],_enemystate[? curent].bbox[1],_enemystate[? curent].bbox[2],_enemystate[? curent].bbox[3])){
								_enemystate[? curent].on = true;
							} else {
								_enemystate[? curent].on = false;
							}
						} else if(_inptype == WHACK_INPUT_KEY){
							if(_curspot[0] == _enemystate[? curent].spot && _curspot[1] == _enemystate[? curent].row){
								_enemystate[? curent].on = true;
							} else {
								_enemystate[? curent].on = false;
							}
						}
						
						//behavior
						_enemystate[? curent].timer ++;
						
						switch(_enemystate[? curent].act){
							case WHACK_ACT_APPEAR_BOSS:
								//appearing (boss)
								_enemystate[? curent].anim = "boss_appear";
								_enemystate[? curent].img += 0.3;
								
								if(_enemystate[? curent].timer >= 60){
									_thunder_alp = 1.35;
									sfx_play(snd_whack_thunder);
									sfx_play(snd_whack_lanky_appear1);
									
									_mus_spdup = true;
									
									_enemystate[? curent].img = 0;
									_enemystate[? curent].timer = 0;
									_enemystate[? curent].act = WHACK_ACT_APPEAR;
								}
							break;
							case WHACK_ACT_APPEAR:
								//appearing in the spot
								if(_boss_rememberblock != -1){
									_enemystate[? curent].blockpoints = _boss_rememberblock;
									_boss_rememberblock = -1;
								}
								_enemystate[? curent].anim = "appear";
								_enemystate[? curent].img += 0.35;
								
								_enemystate[? curent].scale = [_enmscale,_enmscale];
								
								if(_enemystate[? curent].img >= 3){
									if(_enemystate[? curent].boss && !_boss_shake){
										_tnt_amp = 40;
										_boss_shake = true;
									}
									
									if(_enemystate[? curent].codename == "smile"){
										sfx_play(snd_whack_mine);
									}
									
									_enemystate[? curent].pose = irandom_range(0,2);
									_enemystate[? curent].timer = 0;
									_enemystate[? curent].act = WHACK_ACT_PRESENT;
								}
							break;
							case WHACK_ACT_PRESENT:
								if(!_firstbonked){
									_enmtimer = 0;
								}
							
								//ready to be whacked
								_enemystate[? curent].anim = "idle";
								_enemystate[? curent].img = _enemystate[? curent].pose;
								
								if(_enemystate[? curent].block > 0){
									_enemystate[? curent].anim = "block";
								}
								
								_enemystate[? curent].sintimer ++;
								_enemystate[? curent].scale[0] = _enmscale+(sin(_enemystate[? curent].sintimer/7)*0.04);
								_enemystate[? curent].scale[1] = _enmscale+(cos(_enemystate[? curent].sintimer/7)*0.04);
							
								var enm_value = max(32, random_range(195, 225)-(_bonkmultipl*(_difficulty*1.3)));
								
								if(_enemystate[? curent].item){
									enm_value = 240;
									if(_enemystate[? curent].refill){
										_enemystate[? curent].timer = 0;
									}
								}
								if(_enemystate[? curent].codename == "smile"){
									enm_value = 100;
								}
								if(string_starts_with(_enemystate[? curent].codename,"bonus")){
									enm_value = 76;
								}
							
								if(!_gameover && !_enemystate[? curent].boss){
									if(_firstbonked && _enemystate[? curent].timer >= enm_value){
										//got away
										var snd = -1;
										if(_enemystate[? curent].bad){
											switch(_enemystate[? curent].codename){
												case "bad1":
													snd = snd_mg_henchie;
												break;
												case "bad2":
													snd = snd_mg_yolobones;
												break;
												case "bad3":
													snd = snd_mg_gostlik;
												break;
											}
										
											if(_bonus_damageless <= 0){
												_hp -= 5;
										
												_hurt_alp = 0.25;
												_hp_ui_amp[1] = 12;
										
												sfx_play_choose([snd_whack_punch1,snd_whack_punch2,snd_whack_punch3]);
										
												if(_hp < 0){
													_hp = 0;
												}
												
												_score -= _score_sub.enm_miss;
											}
										}
										if(snd != -1){
											sfx_play(snd);
											sfx_pitch(snd, random_range(1,1.25));
										}
									
										if(_enemystate[? curent].codename == "smile"){
											//smile bomb exploded
											if(_bonus_damageless <= 0){
												_hp -= 5;
												_hurt_alp = 0.35;
												_hp_ui_amp[1] = 20;
											
												if(_hp < 0){
													_hp = 0;
												}
											
												_score -= _score_sub.bomb_miss;
											}
											
											sfx_play(snd_whack_bomb);
											_tnt_amp = 10;
										}
									
										_enemystate[? curent].img = 4;
										_enemystate[? curent].timer = 0;
										_enemystate[? curent].act = WHACK_ACT_OUT;
									}
								}
								
								if(!_enemystate[? curent].item && !string_starts_with(_enemystate[? curent].codename, "bonus")){
									//tnt attack
									if(_tnt_active && !_enemystate[? curent].boss && _enemystate[? curent].bad && !_enemystate[? curent].fried){
										if(_enemystate[? curent].posx != -1 && _enemystate[? curent].posy != -1){
											_flames[? ds_map_size(_flames)] = {
												posx: _enemystate[? curent].posx,
												posy: _enemystate[? curent].posy,
												row: _enemystate[? curent].row,
												scalex: 0,
												scaley: 0,
												timer: 0,
												tnt: true,
											}
											
											_enemystate[? curent].fried = true;
										}
									}
									
									//fried
									if(ds_map_size(_flames) > 0){
										var dskeys = ds_map_keys_to_array(_flames);
										for(var i = 0; i < array_length(dskeys); i++){
											if(ds_map_exists(_flames, dskeys[i])){
												var curflame = _flames[? dskeys[i]];
												if(curflame.row == _enemystate[? curent].row){
													_enemystate[? curent].fried = true;
													if(_enemystate[? curent].boss){
														//boss dodges flame
														if(!_tnt_active){
															_boss_rememberblock = _enemystate[? curent].blockpoints;
															_enemystate[? curent].img = 4;
															_enemystate[? curent].timer = 0;
															_enemystate[? curent].act = WHACK_ACT_OUT;
														}
													} else {
														if(_enemystate[? curent].bad){
															//badhead gets fried
															_enemystate[? curent].img = 0;
															_enemystate[? curent].timer = 0;
									
															_enemystate[? curent].offset = [0,0];
															_enemystate[? curent].amp = 30;
									
															_enemystate[? curent].act = WHACK_ACT_BONKED;
															if(_boss){
																_boss_bonks ++;
															}
														
															_score += _score_add.fry*_score_multiplier;
														
															global._pad_vibrate = 3;
														
															sfx_play(snd_mg_flame);
														} else {
															//dial-m dodges the flame
															_enemystate[? curent].img = 4;
															_enemystate[? curent].timer = 0;
															_enemystate[? curent].act = WHACK_ACT_OUT;
														}
													}
												}
											}
										}
									}
								}
							break;
							case WHACK_ACT_BONKED:
								if(_enemystate[? curent].boss){
									_boss_rememberblock = -1;
								}
								_enemystate[? curent].block = 0;
								_enemystate[? curent].anim = "whack";
								if(_enemystate[? curent].fried){
									_enemystate[? curent].anim = "fried";
								} else {
									_enemystate[? curent].img = 0;
								}
							
								if(_enemystate[? curent].item || _enemystate[? curent].codename == "smile" || string_starts_with(_enemystate[? curent].codename, "bonus")){
									_enemystate[? curent].spr = -1;
								}
								
								if(_enemystate[? curent].bad && _enemystate[? curent].fried){
									var finframe = 8;
									
									if(_enemystate[? curent].img < finframe){
										if(_enemystate[? curent].amp < 0){
											_enemystate[? curent].amp = 0;
										}
									}
									
									if(_enemystate[? curent].timer >= 35){
										if(_enemystate[? curent].img >= finframe){
											_enemystate[? curent].img = finframe;
										} else {
											_enemystate[? curent].img += 0.26;
										}
									}
								}
								
								//boss defeated
								if(_enemystate[? curent].boss && _boss_hp <= 0){
									_tnt_amp = 7;
									if(floor(_enemystate[? curent].amp)%10 == 0){
										for(var i = 0; i < 2; i++){
											var p = instance_create_depth(_enemystate[? curent].posx-72,_enemystate[? curent].posy-64, -32, obj_particle);
											p._type = "whack_particle"+string(irandom_range(1,3));
											p._alpha = true;
											p._alpha_spd = 0.04;
											p._move = true;
											p._frameend = false;
											if(i == 0){
												p._xspd = -8;
											} else {
												p._xspd = 8;
											}
										}
									}
								}
								
								if(_enemystate[? curent].amp <= -14){
									if(_enemystate[? curent].boss){
										_enemystate[? curent].boss = false;
										_enemystate[? curent].exists = false;
										_enemystate[? curent].act = WHACK_ACT_APPEAR;
										_enemystate[? curent].block = 0;
										_enemystate[? curent].hp = 1;
										
										if(_boss_hp > 0){
											_boss_itemrefill = 1;
											_boss_itemrefill_timer = 60;
											_boss_itemrefill_force = 1;
											
											_boss_rememberblock = -1;
											_boss_bonks = 0;
											_bossphase ++;
											_boss_timer = 0;
											_boss_act = 3;
										} else {
											//fill place up with items
											if(_boss && _boss_itemrefill <= 0){
												_bonked -= 140;
												if(_bonked < 0){
													_bonked = 0;
												}
												_boss_itemrefill = 6;
												_boss_itemrefill_timer = 180;
												_boss_itemrefill_force = -1;
											}
											
											_mus_spdup = false;
											
											_mus_spd += 0.1;
											
											_boss = false;
										}
									}
									if(_enemystate[? curent].codename == "good1"){
										if(_bonus_damageless <= 0){
											_hp -= 20;
										
											_hurt_alp = 1;
											_hp_ui_amp[1] = 32;
										
											sfx_play(snd_whack_kd);
										
											_score -= _score_sub.dialm_hit;
										
											if(_hp < 0){
												_hp = 0;
											}
										}
									}
									_enemystate[? curent].exists = false;
								}
							break;
							case WHACK_ACT_OUT:
								//back into the spot
								_enemystate[? curent].anim = "appear";
								if(_enemystate[? curent].codename == "smile"){
									_enemystate[? curent].anim = "explode";
								}
								_enemystate[? curent].img -= 0.5;
								
								_enemystate[? curent].scale = [_enmscale,_enmscale];
								
								var endout = false;
								if(_enemystate[? curent].codename != "smile"){
									if(_enemystate[? curent].img <= 0){
										endout = true;
									}
								} else {
									if(_enemystate[? curent].timer >= 50){
										endout = true;
									}
								}
								
								if(endout){
									_enemystate[? curent].exists = false;
									if(!_enemystate[? curent].bad && !_enemystate[? curent].fried){
										switch(_enemystate[? curent].codename){
											case "good1":
												//spawn an item
												var item = 1;
												if(_juice < _juice_max){
													item = 3;
												}
												if(_tnt_active){
													item = 1;
												}
												_enemystate[? curent].exists = true;
												_enemystate[? curent].bad = false;
												_enemystate[? curent].codename = "item"+string(item);
												_enemystate[? curent].img = 0;
												_enemystate[? curent].sintimer = random(1000);
						
												_enemystate[? curent].item = true;
												_enemystate[? curent].refill = false;
												
												switch(item){
													case 1:
														//corn
														_enemystate[? curent].itemtnt = 0;
														_enemystate[? curent].itemhp = WHACK_RESTORE_CORN;
													break;
													case 3:
														//choco
														_enemystate[? curent].itemtnt = WHACK_RESTORE_CHOCO;
														_enemystate[? curent].itemhp = 0;
													break;
												}
						
												_enemystate[? curent].offset = [0,0];
												_enemystate[? curent].amp = 0;
						
												_enemystate[? curent].timer = 0;
												_enemystate[? curent].act = WHACK_ACT_APPEAR;
											break;
											case "item1":
												//spawn a better item
												_enemystate[? curent].exists = true;
												_enemystate[? curent].bad = false;
												_enemystate[? curent].codename = "item2";
												_enemystate[? curent].img = 0;
												_enemystate[? curent].sintimer = random(1000);
						
												_enemystate[? curent].item = true;
												_enemystate[? curent].refill = false;
												
												//tomato
												_enemystate[? curent].itemtnt = 0;
												_enemystate[? curent].itemhp = WHACK_RESTORE_TOMATO;
						
												_enemystate[? curent].offset = [0,0];
												_enemystate[? curent].amp = 0;
						
												_enemystate[? curent].timer = 0;
												_enemystate[? curent].act = WHACK_ACT_APPEAR;
											break;
										}
									}
								}
							break;
						}
						
						_enemystate[? curent].amp --;
						if(_enemystate[? curent].amp > 0){
							_enemystate[? curent].offset[0] = sin(random(480))*(_enemystate[? curent].amp*1.5);
						}
						
						if(_enemystate[? curent].act == WHACK_ACT_APPEAR || _enemystate[? curent].act == WHACK_ACT_PRESENT){
							if(!_gameover && _enemystate[? curent].on){
								//whack
								var action = false;
								if(_inptype == WHACK_INPUT_MOUSE && mouse_check_button_pressed(mb_left)){
									action = true;
								}
								if(_inptype == WHACK_INPUT_KEY && keypress("punch")){
									action = true;
								}
								if(action){
									action = false;
									if(_enemystate[? curent].blockpoints > 0){
										var mpos = [mouse_x,mouse_y];
										if(_inptype == WHACK_INPUT_KEY){
											mpos = [_curspot_coords[0],_curspot_coords[1]];
										}
										var p = instance_create_depth(mpos[0],mpos[1],-32,obj_particle);
										p._type = "whack_block";
										
										_enemystate[? curent].blockpoints --;
										_enemystate[? curent].block ++;
										
										_enemystate[? curent].offset = [0,0];
										_enemystate[? curent].amp = min(150,_enemystate[? curent].block*5);
										
										sfx_play_choose([snd_whack_block1,snd_whack_block2,snd_whack_block3]);
									} else {
										_enemystate[? curent].img = 0;
										_enemystate[? curent].timer = 0;
									
										_enemystate[? curent].offset = [0,0];
										_enemystate[? curent].amp = 30;
									
										_enemystate[? curent].act = WHACK_ACT_BONKED;
										
										if(_tnt_active && _enemystate[? curent].boss){
											_enemystate[? curent].anim = "whack";
											_enemystate[? curent].block = 0;
											_juice = 0;
											_juice_display = _tnt_active_juice;
											_tnt_active = false;
										}
										
										if(_enemystate[? curent].boss){
											_boss_hp --;
											_enemystate[? curent].hp = _boss_hp;
											if(_boss_hp <= 0){
												global._pad_vibrate = 24;
												
												sfx_play(snd_whack_lanky_dead);
												_enemystate[? curent].amp = 100;
												
												_score += _score_add.boss_defeat*_score_multiplier;
											}
										}
									
										if(string_starts_with(_enemystate[? curent].codename, "bonus")){
											//bonus item
											sfx_play(snd_mg_bonus);
											sfx_play(snd_mg_item);
											
											global._pad_vibrate = 5;
											
											switch(_enemystate[? curent].codename){
												case "bonus1":
													_bonus_damageless = 1;
													_hp_ui_amp[1] = 22;
												break;
												case "bonus2":
													_bonus_scoremult = 1;
													_tnt_amp = 16;
												break;
											}
										} else {
											if(!_enemystate[? curent].item){
												//whacked
												sfx_play_choose([snd_whack_slam1,snd_whack_slam2,snd_whack_slam3,snd_whack_slam4,snd_whack_slam5]);
									
												global._pad_vibrate = 2;
												
												if(!_enemystate[? curent].bad){
													if(_enemystate[? curent].codename == "good1"){
														sfx_play(snd_whack_dialm);
													}
												}
									
												//particles
												var offs = [-64,0];
												var pos = [mouse_x,mouse_y];
												if(_inptype == WHACK_INPUT_KEY){
													pos = [_curspot_coords[0],_curspot_coords[1]];
												}
												for(var i = 0; i < 2; i++){
													var p = instance_create_depth(pos[0]+offs[0],pos[1]+offs[1], -32, obj_particle);
													p._type = "whack_particle"+string(irandom_range(1,3));
													p._alpha = true;
													p._alpha_spd = 0.04;
													p._move = true;
													p._frameend = false;
													if(i == 0){
														p._xspd = -8;
													} else {
														p._xspd = 8;
													}
												}
												for(var i = 0; i < 2; i++){
													var p = instance_create_depth(pos[0],pos[1], -32, obj_particle);
													p._type = "whack_particle"+string(irandom_range(4,6));
													p._alpha = true;
													p._alpha_spd = 0.02;
													p._move = true;
													p._frameend = false;
													if(i == 0){
														p._xspd = -4;
													} else {
														p._xspd = 4;
													}
												}
											} else {
												//grabbed an item
												sfx_play(snd_mg_item);
										
												global._pad_vibrate = 4;
										
												var pcolor = c_white;
										
												var pspot = [mouse_x+64,mouse_y+64];
												if(_inptype == WHACK_INPUT_KEY){
													pspot = [_curspot_coords[0]+64,_curspot_coords[1]+64];
												}
										
												var healnum = instance_create_depth(pspot[0], pspot[1], -32, obj_nums);
												healnum._plus = true;
										
												switch(_enemystate[? curent].codename){
													case "item1":
														pcolor = make_color_rgb(239, 217, 61);
														healnum._num = _enemystate[? curent].itemhp;
													break;
													case "item2":
														pcolor = make_color_rgb(225, 72, 84);
														healnum._num = _enemystate[? curent].itemhp;
													break;
													case "item3":
														pcolor = make_color_rgb(206, 55, 34);
														healnum._num = _enemystate[? curent].itemtnt;
														healnum._tnt = true;
													break;
												}
										
												var p = instance_create_depth(pspot[0],pspot[1],-32,obj_particle);
												p._type = "whack_item";
												p._color = pcolor;
										
												_juice += _enemystate[? curent].itemtnt;
												if(_enemystate[? curent].itemtnt > 0){
													_juice_ui_amp[1] = _enemystate[? curent].itemtnt*1.2;
												}
												if(_juice > _juice_max){
													_juice = _juice_max;
												}
										
												_hp += _enemystate[? curent].itemhp;
												if(_enemystate[? curent].itemhp > 0){
													_hp_ui_amp[1] = _enemystate[? curent].itemhp*1.2;
												}
												if(_hp > _hp_max){
													_hp = _hp_max;
												}
											
												_score += _score_add.item*_score_multiplier;
											}
										}
									
										if(!_firstbonked){
											if(global._minigame_diff > 0){
												_bonked = round(global._minigame_diff*50);
											}
											
											_firstbonked = true;
										}
									
										if(!_enemystate[? curent].boss && _enemystate[? curent].bad){
											if(_boss && _boss_act == 4){
												//enemy bonked during boss
												_boss_bonks ++;
												var maxbonks = 0;
												switch(_bossphase){
													case 1:
														maxbonks = 12;
													break;
													case 2:
														maxbonks = 20;
													break;
													case 3:
														maxbonks = 35;
													break;
													case 4:
														maxbonks = 44;
													break;
												}
												if(_boss_bonks >= maxbonks){
													_boss_timer = 0;
													_boss_act = 0;
												}
											}
											
											_juice += 0.22;
										
											if(_juice > _juice_max){
												_juice = _juice_max;
											}
										
											if(!_boss){
												_preboss_bonks ++;
											}
											_bonked ++;
											_bonkmultipl = _bonkmultipl_start+random_range(-0.14,0.18);
											
											_score += _score_add.bonk*_score_multiplier;
										}
									}
								}
							}
						}
						
						var spr = asset_get_index("spr_whack_"+_enemystate[? curent].codename+"_"+_enemystate[? curent].anim);
						if(sprite_exists(spr)){
							_enemystate[? curent].spr = spr;
						}
					}
				}
			}
			
			//item refill
			if(_boss_itemrefill_timer){
				_boss_itemrefill_timer --;
			}
			if(_boss_itemrefill > 0){
				var spots = [];
				var n = 0;
				for(var yy = 0; yy < array_length(_spots); yy++){
					for(var xx = 0; xx < array_length(_spots[yy]); xx++){
						//check if spot exists
						if(_spots[yy][xx]){
							spots[n] = string(xx)+" "+string(yy);
							n ++;
						}
					}
				}
				
				var shuffle_spots = array_shuffle(spots);
				for(var i = 0; i < array_length(shuffle_spots); i++){
					var item = irandom_range(1,3);
					var itemspot = shuffle_spots[i];
					if(!_enemystate[? itemspot].exists){
						_enemystate[? itemspot].exists = true;
						_enemystate[? itemspot].bad = false;
						if(_boss_itemrefill_force != -1){
							item = _boss_itemrefill_force;
							_enemystate[? itemspot].codename = "item"+string(item);
						}
						_enemystate[? itemspot].codename = "item"+string(item);
						_enemystate[? itemspot].img = 0;
						_enemystate[? itemspot].sintimer = random(1000);
						
						_enemystate[? itemspot].item = true;
						_enemystate[? itemspot].refill = true;
						switch(item){
							case 1:
								//corn
								_enemystate[? itemspot].itemtnt = 0;
								_enemystate[? itemspot].itemhp = WHACK_RESTORE_CORN;
							break;
							case 2:
								//tomato
								_enemystate[? itemspot].itemtnt = 0;
								_enemystate[? itemspot].itemhp = WHACK_RESTORE_TOMATO;
							break;
							case 3:
								//choco
								_enemystate[? itemspot].itemtnt = WHACK_RESTORE_CHOCO;
								_enemystate[? itemspot].itemhp = 0;
							break;
						}
						
						_enemystate[? itemspot].offset = [0,0];
						_enemystate[? itemspot].amp = 0;
						
						_enemystate[? itemspot].timer = 0;
						_enemystate[? itemspot].act = WHACK_ACT_APPEAR;
						
						_boss_itemrefill --;
						break;
					}
				}
			}
			
			//hurt effect
			if(_hurt_alp > 0){
				_hurt_alp -= 0.04;
			}
			
			//tnt juice attack
			if(!_gameover && _flames_init){
				if(!_flames_active){
					if(_flames_y == 0){
						if(_flames_rows[0][0] != -1){
							_flames_y = _flames_rows[0][2];
							_flames_row = 0;
						} else {
							_flames_y = _flames_rows[1][2];
							_flames_row = 1;
						}
					}
				
					for(var i = 0; i < array_length(_flames_rows); i++){
						if(_flames_rows[i][0] != -1){
							var checky = mouse_y;
							if(_inptype == WHACK_INPUT_KEY){
								checky = _curspot_coords[1];
							}
							if(checky >= _flames_rows[i][0] && checky <= _flames_rows[i][1]){
								_flames_y = _flames_rows[i][2];
								_flames_row = i;
							}
						}
					}
				}
				
				var tntrelease = false;
				if(_inptype == WHACK_INPUT_MOUSE && mouse_check_button_released(mb_right)){
					tntrelease = true;
				}
				if(_inptype == WHACK_INPUT_KEY && keyrelease("tnt")){
					tntrelease = true;
				}
				if(tntrelease = true){
					tntrelease = false;
					if(!_flames_active && !_tnt_active){
						if(_juice >= _juice_atk){
							_flames_active = true;
					
							sfx_play(snd_mg_fireend);
					
							_juice -= _juice_atk;
							if(_juice < 0){
								_juice = 0;
							}
						}
					}
				}
			}
			if(_flames_active){
				_fireframe += 0.3;
				
				_flames_timer ++;
				if(_flames_timer >= 4){
					if(_flames_x[0] > 32){
						//spawn flames until a cerain threshold
						_flames[? ds_map_size(_flames)] = {
							posx: _flames_x[0],
							posy: _flames_y,
							row: _flames_row,
							scalex: 0,
							scaley: 0,
							timer: 0,
							tnt: false,
						}
						_flames[? ds_map_size(_flames)+1] = {
							posx: _flames_x[1],
							posy: _flames_y,
							row: _flames_row,
							scalex: 0,
							scaley: 0,
							timer: 0,
							tnt: false,
						}
						
						_flames_started = true;
					
						_flames_x[0] -= 56;
						_flames_x[1] += 56;
					}
					
					_flames_timer = 0;
				}
			} else {
				_flames_x = [floor(WIDTH/2),floor(WIDTH/2)];
				_flames_timer = 99;
				_fireframe = 0;
				_flames_started = false;
			}
			
			//update flames
			if(ds_map_size(_flames) > 0){
				var dskeys = ds_map_keys_to_array(_flames);
				for(var i = 0; i < array_length(dskeys); i++){
					if(ds_map_exists(_flames, dskeys[i])){
						var curflame = _flames[? dskeys[i]];
						
						_flames[? dskeys[i]].timer ++;
						if(curflame.timer < 25){
							_flames[? dskeys[i]].scalex += 0.14;
							if(_flames[? dskeys[i]].scalex > 1){
								_flames[? dskeys[i]].scalex = 1;
							}
							_flames[? dskeys[i]].scaley += 0.22;
							if(_flames[? dskeys[i]].scaley > 1){
								_flames[? dskeys[i]].scaley = 1;
							}
						} else {
							_flames[? dskeys[i]].scalex -= 0.28;
							if(_flames[? dskeys[i]].scalex <= 0){
								_flames[? dskeys[i]].scalex = 0;
							}
							_flames[? dskeys[i]].scaley -= 0.28;
							if(_flames[? dskeys[i]].scaley <= 0){
								_flames[? dskeys[i]].scaley = 0;
								ds_map_delete(_flames, dskeys[i]);
							}
						}
					}
				}
			} else {
				//stop flames once ds map is empty
				if(_flames_started){
					_flames_active = false;
				}
			}
			
			//tnt quake stuff
			if(_tnt_amp > 0){
				_tnt_offset = sin(random(480))*(_tnt_amp*global._shakevals[global._shakeval]);
				
				_tnt_amp --;
			}
			
			if(!_gameover && _juice >= _juice_max && !_tnt_active){
				var tnthold = false;
				if(_inptype == WHACK_INPUT_MOUSE && mouse_check_button(mb_right)){
					tnthold = true;
				}
				if(_inptype == WHACK_INPUT_KEY && keyhold("tnt")){
					tnthold = true;
				}
				if(tnthold){
					_holdc += 0.5;
					if(_holdc >= 10){
						sfx_play(snd_mg_tnt);
						
						_juice = 0;
						_juice_display = 0;
						_tnt_active_juice = _juice_max;
						_tnt_active = true;
						_holdc = 0;
					}
				} else {
					_holdc = 0;
				}
			}
			
			if(_tnt_active){
				global._pad_vibrate = 2;
				
				_tnt_amp = random_range(4,7);
				_tnt_active_juice -= 0.3;
				if(_tnt_active_juice <= 0){
					_tnt_active = false;
					_tnt_active_juice = 0;
				}
			}
			
			if(_thunder_alp > 0){
				_thunder_alp -= 0.08;
			}
			if(_thunder_alp < 0){
				_thunder_alp = 0;
			}
			
			//non mouse input
			if(!_howto && _inptype == WHACK_INPUT_KEY){
				var nohold = true;
				
				if(keyhold("left") || keyhold("menu_left")){
					if(_spots[1,1]){
						_curspot = [1,1];
						nohold = false;
					}
				} else if(keyhold("right") || keyhold("menu_right")){
					if(_spots[1,3]){
						_curspot = [3,1];
						nohold = false;
					}
				} else if(keyhold("up") || keyhold("menu_uo")){
					if(_spots[0,2]){
						_curspot = [2,0];
						nohold = false;
					}
				} else if(keyhold("down") || keyhold("menu_down")){
					if(_spots[2,2]){
						_curspot = [2,2];
						nohold = false;
					}
				}
				if((keyhold("left") && keyhold("up")) || (keyhold("menu_left") && keyhold("menu_up"))){
					if(_spots[0,1]){
						_curspot = [1,0];
						nohold = false;
					}
				} else if((keyhold("right") && keyhold("up")) || (keyhold("menu_right") && keyhold("menu_up"))){
					if(_spots[0,3]){
						_curspot = [3,0];
						nohold = false;
					}
				} else if((keyhold("left") && keyhold("down")) || (keyhold("menu_left") && keyhold("menu_down"))){
					if(_spots[2,1]){
						_curspot = [1,2];
						nohold = false;
					}
				} else if((keyhold("right") && keyhold("down")) || (keyhold("menu_right") && keyhold("menu_down"))){
					if(_spots[2,3]){
						_curspot = [3,2];
						nohold = false;
					}
				}
				
				if(nohold){
					_curspot = [2,1];
				}
			}
			
			//bonus
			if(_bonus_scoremult > 0){
				_bonus_scoremult -= 0.0009;
			}
			if(_bonus_damageless > 0){
				_bonus_damageless -= 0.0007;
			}
			
			_score_multiplier = 1;
			if(_bonus_scoremult > 0){
				_score_multiplier = 2;
			}
			
			//ui stuff
			_hp_display = lerp(_hp_display, _hp, 0.12);
			if(!_tnt_active){
				_juice_display = lerp(_juice_display, _juice, 0.12);
			}
			
			for(var i = 0; i < 2; i++){
				if(_hp_ui_amp[i] > 0){
					_hp_ui_amp[i] --;
				} else if(_hp_ui_amp[i] < 0){
					_hp_ui_amp[i] = 0;
				}
			
				if(_juice_ui_amp[i] > 0){
					_juice_ui_amp[i] --;
				} else if(_juice_ui_amp[i] < 0){
					_juice_ui_amp[i] = 0;
				}
			}
			
			_hp_ui_offs[0] = sin(random(480))*_hp_ui_amp[0];
			_hp_ui_offs[1] = cos(random(480))*_hp_ui_amp[1];
			
			_juice_ui_offs[0] = sin(random(480))*_juice_ui_amp[0];
			_juice_ui_offs[1] = cos(random(480))*_juice_ui_amp[1];
			
			//score display
			_score = clamp(_score, 0, 9999999);
			_monyx = clamp(_monyx, 0, 9999999);
			
			_score_display = lerp(_score_display, _score, 0.12);
			_score_string = string_pad(round(_score_display), "0", 7);
			_monyx_string = string_pad(round(_monyx), "0", 7);
		}
	}
	
	//how to whack
	if(!global._pause && _howto){
		if(_howto_page == 0){
			_howto_showleft = false;
		} else {
			_howto_showleft = true;
		}
		
		if(_howto_page < _howto_length-1){
			_howto_showclose = true;
		} else {
			_howto_showclose = false;
		}
		
		if(_handright_on > 0){
			_handright_on --;
		}
		if(_handleft_on > 0){
			_handleft_on --;
		}
		if(_closebtn_on > 0){
			_closebtn_on --;
		}
		
		_howto_timer ++;
		
		_howto_offs += _howto_yspd;
		_howto_yspd += 1.68;
		if(_howto_offs > 0){
			_howto_yspd = 0;
			_howto_offs = 0;
		}
		
		if(_howto_timer >= _howto_startval){
			//appearing
			if(!_howto_out){
				_howto_alpha = lerp(_howto_alpha, 0.7, 0.15);
			} else {
				_howto_alpha = lerp(_howto_alpha, 0, 0.15);
			}
			
			if(_howto_timer <= 60){
				_howto_scale = ease_out_elastic(0, 1, 40, 0.7);
			} else {
				//appeared
				_howto_intro = true;
				if(!_howto_out){
					_howto_scale = lerp(_howto_scale, 1, 0.15);;
				} else {
					_howto_scale -= 0.09;
					if(_howto_scale <= 0){
						_howto = false;
					}
				}
			}
		}
		
		//accept input
		if(_howto_intro && !_howto_out){
			if(_howto_showright){
				if((_inptype == WHACK_INPUT_MOUSE && _handright_on && mouse_check_button_pressed(mb_left)) || (_inptype == WHACK_INPUT_KEY && (keypress("right") || keypress("menu_right")))){
					if(_howto_page < _howto_length-1){
						sfx_play(snd_mg_popnext);
						_howto_page ++;
						_howto_offs = -1;
						_howto_yspd = -10;
					} else {
						sfx_play(snd_mg_popaway);
						_howto_out = true;
						global._whack_help = true;
					}
				}
			}
			if(_howto_showleft){
				if((_inptype == WHACK_INPUT_MOUSE && _handleft_on && mouse_check_button_pressed(mb_left)) || (_inptype == WHACK_INPUT_KEY && (keypress("left") || keypress("menu_left")))){
					sfx_play(snd_mg_popnext);
					_howto_page --;
					_howto_offs = -1;
					_howto_yspd = -10;
				}
			}
			
			if(_howto_showclose){
				if((_inptype == WHACK_INPUT_MOUSE && _closebtn_on && mouse_check_button_pressed(mb_left)) || (_inptype == WHACK_INPUT_KEY && keypress("confirm"))){
					sfx_play(snd_mg_popaway);
					_howto_out = true;
					global._whack_help = true;
				}
			}
		}
	}
	
	//game over code
	if(!_gameover){
		if(_hp <= 0){
			global._minigame_nopause = true;
					
			_mus_spdup = false;
			_mus_spd = 1;
			_gameover = true;
		}
	} else {
		minigame_lose_step(_score);
	}
}