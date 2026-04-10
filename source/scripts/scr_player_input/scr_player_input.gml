function scr_player_input(){
	//input
	var disallowedstatesinput = ["win","shockwave", "nomove", "zapped","bigpunch"];

	if(_freeze <= 0 && _shield){
		if(_state == "win"){
			_shield = false;
		}
		if(_afterslam){
			_shield = false;
		}
		if(!_jump_enmhit && keyhold("shield")){
			if(_height <= _groundlevel){
				_shieldpower += _shieldgain[0];
			} else {
				_shieldpower += _shieldgain[0]*4.5;
			}
		} else {
			_shield = false;
		}
	}
	
	if(global._finalhit <= 0 && ( (_state != "item" && !_enemygrab) || _enemygrab) && !array_contains(disallowedstatesinput, _state) && !_blowup && _hurtTimer == 0 && !_dead && !_falling && _begin && _mashact == 0 && !_grabfail){
		//walking
		
		//stop if any of these return true
		if(!_stopspd){
			if(
				(keyhold("left") && keyhold("right") && keyhold("up") && keyhold("down"))
				|| (!keyhold("left") && !keyhold("right") && !keyhold("up") && !keyhold("down"))
			){
				_spd[0] *= _decel;
				if(abs(_spd[0]) < 0.1){
					_spd[0] = 0;
				}
				_spd[1] *= _decel;
				if(abs(_spd[1]) < 0.1){
					_spd[1] = 0;
				}
			}
			if((keyhold("left") && keyhold("right")) || (!keyhold("left") && !keyhold("right"))){
				_spd[0] *= _decel;
				if(abs(_spd[0]) < 0.1){
					_spd[0] = 0;
				}
			}
			if((keyhold("up") && keyhold("down")) || (!keyhold("up") && !keyhold("down"))){
				_spd[1] *= _decel;
				if(abs(_spd[1]) < 0.1){
					_spd[1] = 0;
				}
			}
		}
		
		//running
		if(_state == "default" && _grabinst == noone && !_attack){
			if(keypress("left") || keypress("right") || keypress("down") || keypress("up")){
				//double tap to run
				if(!_running){
					_runs ++;
					if((keypress("left") && keypress("up")) || (keypress("left") && keypress("down"))){
						_runs = 0;
					}
					if((keypress("right") && keypress("up")) || (keypress("right") && keypress("down"))){
						_runs = 0;
					}
					if(keypress("left")){
						_runkeys[_runs] = "l";
					} else if(keypress("right")){
						_runkeys[_runs] = "r";
					} else if(keypress("up")){
						_runkeys[_runs] = "u";
					} else if(keypress("down")){
						_runkeys[_runs] = "d";
					}
					if(global._inptype == 0){
						_runtimer = 20;
					}
					else{
						_runtimer = 24;
					}
					if(_runs >= 2){
						if(array_length(_runkeys) >= 3){
							if(_runkeys[1] == _runkeys[2]){
								_running = true;
								_runs = 2;
							} else {
								_runs = 0;
							}
						} else {
							_runs = 0;
						}
					}
				}
			}
		}
		
		if(_grabinst != noone && instance_exists(_grabinst)){
			_running = false;
			_runs = 0;
		}
		if((!keyhold("left") && !keyhold("right")) || (keyhold("left") && keyhold("right"))){
			if((!keyhold("up") && !keyhold("down")) || (keyhold("up") && keyhold("down"))){
				if(_runtimer == 0){
					_running = false;
				}
			}
		}
		if(_walltouch[0] > 0 && _spd[1] == 0){
			_runtimer = 0;
			_running = false;
		}
		if(_walltouch[1] > 0 && _spd[0] == 0){
			_runtimer = 0;
			_running = false;
		}
		
		if((_shield && _height <= _groundlevel) || (_crouch && !_slide)){
			_spd = [0,0];
		}
		
		if(!_crouch && !_runroll && !_taunt && (!_shield || (_shield && _height > _groundlevel)) && _stunnedtimer <= 0){
			//horizontal / vertical
			if(keyhold("left")){
				if(abs(_preservespd) < 2){
					_spd[0] -= _accel;
				}
				if(_spd[0] < -_maxspd[0]){
					_spd[0] = -_maxspd[0];
				}
				if(_freeze == 0 && _skidtimer == 0 && _stopwalk == 0 && !keyhold("right")){
					_curdir_prev = _curdir;
					_curdir = DIR_L;
				}
			}
			if(keyhold("right")){
				if(abs(_preservespd) < 2){
					_spd[0] += _accel;
				}
				if(_spd[0] > _maxspd[0]){
					_spd[0] = _maxspd[0];
				}
				if(_freeze == 0 && _skidtimer == 0 && _stopwalk == 0 && !keyhold("left")){
					_curdir_prev = _curdir;
					_curdir = DIR_R;
				}
			}
			if(keyhold("up")){
				_spd[1] -= _accel;
				if(_spd[1] < -_maxspd[1]){
					_spd[1] = -_maxspd[1];
				}
			}
			if(keyhold("down")){
				_spd[1] += _accel;
				if(_spd[1] > _maxspd[1]){
					_spd[1] = _maxspd[1];
				}
			}
		
			//diagonal
			if(keyhold("left") && keyhold("up")){
				if(abs(_preservespd) < 2){
					_spd[0] -= _accel;
				}
				if(_spd[0] < -_maxspd[0]){
					_spd[0] = -_maxspd[0];
				}
				_spd[1] -= _accel;
				if(_spd[1] < -_maxspd[1]){
					_spd[1] = -_maxspd[1];
				}
			}
			if(keyhold("left") && keyhold("down")){
				if(abs(_preservespd) < 2){
					_spd[0] -= _accel;
				}
				if(_spd[0] < -_maxspd[0]){
					_spd[0] = -_maxspd[0];
				}
				_spd[1] += _accel;
				if(_spd[1] > _maxspd[1]){
					_spd[1] = _maxspd[1];
				}
			}
			if(keyhold("right") && keyhold("up")){
				if(abs(_preservespd) < 2){
					_spd[0] += _accel;
				}
				if(_spd[0] > _maxspd[0]){
					_spd[0] = _maxspd[0];
				}
				_spd[1] -= _accel;
				if(_spd[1] < -_maxspd[1]){
					_spd[1] = -_maxspd[1];
				}
			}
			if(keyhold("right") && keyhold("down")){
				if(abs(_preservespd) < 2){
					_spd[0] += _accel;
				}
				if(_spd[0] > _maxspd[0]){
					_spd[0] = _maxspd[0];
				}
				_spd[1] += _accel;
				if(_spd[1] > _maxspd[1]){
					_spd[1] = _maxspd[1];
				}
			}
		}
		
		if(!_enemygrab){
			//jumping
			var jmpspd = 4.5;
			if(_shield || _stunnedtimer > 0) return;
			if(!_runroll && !_runroll_slide){
				//only do this if not rolling
				if(!keyhold("crouch") && buffercheck_press("jump") && !_shield && _attack && _attacktype == "upper"){
					_delayjump = true;
				}
				if(!_rolljump && !_crouch){
					if(!_jump && _delayjump){
						_attack = false;
						_attacktype = "";
						
						_jumpreach = 0;
						_vspd = jmpspd;
						_jump = true;
						_slide = false;
						_height = _groundlevel+3;
						_runslide = false;
						_prevstate = _state;
						_state = "jump";
						
						sfx_play(snd_jump);
					}
					if((!_slide && buffercheck_press("jump")) || (_slide && !place_meeting(x,y,obj_slidespot) && keyhold("jump"))){
						if(!_jump && !_attack){
							_jumpreach = 0;
							_vspd = jmpspd;
							_jump = true;
							_slide = false;
							_height = _groundlevel;
							_runslide = false;
							_prevstate = _state;
							_state = "jump";
						
							sfx_play(snd_jump);
						}
					} else if(keyhold("jump") || _delayjump){
						if(_vspd > 0 && _jump){
							if(_jumpback){
								_jumpjuice = 0;
							} else {
								if(_jumpjuice > 0){
									if(_jumpjuice <= _maxjumpjuice-3){
										_delayjump = false;
									}
									_jumpreach = _height;
									_jumpjuice --;
									_vspd = (min(10,_jumpjuice)*2.7);
								}
							}
						}
					} else {
						if(!_jumpback && _jump){
							if(_vspd > 0){
								_vspd = 0;
							}
							_jumpjuice = 0;
						}
					}
				}
			} else {
				//rolling input
				if(!_runroll_slide){
					if(buffercheck_press("jump") && !_runroll_dive && _runhops >= 1){
						_vspd = 16;
						_jump = true;
						_runhops = 0;
					
						sfx_play(snd_jump);
					} else if(!_forceroll && buffercheck_press("punch") && !_attack && !_runroll_dive){
						if(_height <= _groundlevel + 40){
							_vspd = 10;
						} else {
							_vspd = 4;
						}
						_jump = true;
						_runhops = 0;
						
						_height += 3;
						
						_displayobj.image_index = 0;
					
						sfx_play(snd_jump);
					
						_runroll_dive_timer = 0;
						_runroll_dive = true;
					}
				} else {
					if(!_runroll_dive){
						//can jump out of runroll sliding if speed is low enough
						if(abs(_spd[0]) <= 7){
							_vspd = jmpspd;
							_jump = true;
							_slide = false;
							_height = _groundlevel;
							_runslide = false;
							_prevstate = _state;
							_state = "jump";
						
							sfx_play(snd_jump);
						}
					}
				}
			}
		
			//crouching
			if(keyhold("crouch")){
				if(!_runroll && !_runroll_slide && !_runroll_dive){
					if(!_crouch && !_jump && !_attack){
						_prevstate = _state;
						_state = "crouch";
						_crouch = true;
					}
				}
			} else {
				if(!_runroll_slide){
					if(!_runslide && _crouch){
						if(!_slide && !_attack){
							_prevstate = _state;
							_state = "default";
							_crouch = false;
						}
					}
				}
			}
			
			//diving
			function do_dive(addspd) {
				_state = "roll";
				_anim = "dive";
				_anim_transition = false;
				
				_jump = true;
						
				_displayobj.image_index = 0;
						
				_crouch = false;
				
				if(keyhold("right")){
					_curdir = DIR_R;
				} else if(keyhold("left")){
					_curdir = DIR_L;
				}
				
				_height += 4;
				
				_rollspd = (abs(_spd[0]*0.32)+7+addspd)*_curdir;
				_runroll = true;
				_runroll_dive_timer = 0;
				_runroll_dive = true;
				
				sfx_play(snd_jump);
			}
			
			if(buffercheck_press("jump")){
				if(!keyhold("crouch")){
					if(_nodive_timer <= 0 && _crouch && _attack && _attacktype == "crouch"){
						_delaydive = true;
						_delayupper = false;
						dive = false;
					}
				} else {
					if(_freeze <= 0){
						_delayupper = true;
						_delaydive = false;
						dive = false;
					}
				}
			}
			
			if(_nodive_timer <= 0 && !_forceroll && buffercheck_press("dive")){
				var checkcolleft = false;
				var checkcolright = false;
				if(instance_number_array(_collidesolid) > 0 || instance_number_array(global._solidOtherArray) > 0){
					if(place_meeting_array(x+64,y,_collidesolid) || place_meeting_array(x+64,y,global._solidOtherArray)){
						checkcolright = true;
					}
					if(place_meeting_array(x-64,y,_collidesolid) || place_meeting_array(x-64,y,global._solidOtherArray)){
						checkcolleft = true;
					}
				}
				if((_curdir == DIR_R && !checkcolright) || (_curdir == DIR_L && !checkcolleft)){
					if(!_falling && !_dead && !_jumpback && !_running && !_runroll_dive){
						if(_attacktype != "air" || (_attacktype == "air" && global._birdmode)){
							var addspd = 0;
							var dive = true;
					
							if(instance_exists(_displayobj)){
								if(_crouch){
									_delaydive = true;
									dive = false;
								}
							}
					
							if(dive){
								if(!_crouch){
									if(_height <= _groundlevel+120){
										_height += 12;
										_vspd = 10;
									} else {
										_height += 5;
										_vspd = 6;
									}
								}
						
								do_dive(addspd);
							}
						}
					}	
				}
			}
			
			if(_delaydive){
				if(instance_exists(_displayobj)){
					if(_crouch){
						if(!_attack || (_attack && _attacktype != "crouch")){
							_delaydive = false;
						}
						if(_attack && _attacktype == "crouch" && _displayobj.image_index >= 4){
							var addspd = 6;
							_attack = false;
							_attacktype = "";
								
							_height += 5;
							_vspd = 17;
							
							if(!(_runroll && !_runroll_dive && !_runroll_slide)){
								_lowkick_dive = true;
							}
							
							do_dive(addspd);
							
							_delaydive = false;
						}
					} else {
						_delaydive = false;
					}
				}
			}
		}
			
		if(!_slide){
			_runroll_slide = false;
			sfx_stop(snd_slide);
		}
			
		if(_crouch && !_runroll_slide){
			_throw = false;
			if(buffercheck_press("punch")){
				if(!_attack){
					if(keyhold("left")){
						_curdir = DIR_L;
					} else if(keyhold("right")){
						_curdir = DIR_R;
					}
					_displayobj.image_index = 0;
					_attack = true;
					_attacktype = "crouch";
					_attackcooldown = 2;
					var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
					atk._parentobj = self.id;
					atk._scale = [9.6, 3.6];
					atk._offset = [232,-25];
					atk._height = 20;
					atk._timer = 6;
					atk._type = "crouch";
					atk._damage = ATK_KO;
						
					sfx_play_choose(global._swishsounds[0]);
				}
			}
		}
		
		if(_state != "default" && _state != "jump"){
			_running = false;
		}
		if(_falling){
			_runtimer = 0;
			_running = false;
		}
		
		//shielding
		if(_roll_bounceoff <= 0 && _state != "win"){
			if(!_shield && _hurtTimer <= 0 && !_enemygrab && !_throw && !_afterslam && !_attack){
				if(!_jump_enmhit && !_rolljump && (_state == "default" || _state == "jump" || _crouch || _runroll_dive)){
					if(keyhold("shield") && _shieldcd <= 0 && _shieldpower > 0.1 && _successparry <= 0){
						_displayobj.image_index = 0;
						_parrytimer = _maxparry;
						_shield = true;
						_shieldcd = 16;
						_crouch = false;
					
						sfx_stop(snd_shield);
						sfx_play(snd_shield);
					}
				}
			}
		}
		
		//taunts
		var tauntsound = [snd_dh_voice_chuckle1,snd_dh_voice_chuckle2,snd_dh_voice_chuckle3];
		
		if(_state == "default" && !_attack && !_grab && !_enemygrab && !_slam && !_throw && !_anim_transition && !_taunt && !_doWin && !keyhold("punch") && keypress("taunt")){
			_displayobj.image_index = 0;
			_spd = [0,0];
			_taunt = true;
			
			if(keyhold("left") || keyhold("right")){
				if(keyhold("left")){
					_curdir = DIR_L;
				} else if(keyhold("right")){
					_curdir = DIR_R;
				}
				_taunt_type = "tauntside";
			} else if(keyhold("down")){
				_taunt_type = "tauntdown";
			} else if(keyhold("up")){
				_taunt_type = "tauntup";
			} else {
				_taunt_type = "taunt";
			}
			
			if(_taunt_type == "tauntup" || _taunt_type == "tauntdown"){
				tauntsound = [snd_dh_voice_grunt1,snd_dh_voice_grunt2,snd_dh_voice_grunt3,snd_dh_voice_grunt4];
			}
			
			sfx_play_choose([snd_taunt1,snd_taunt2,snd_taunt3,snd_taunt4,snd_taunt5], 0.6);
			voice_play_choose(tauntsound, global._dhvoices);
		}
		
		if(_taunt && (buffercheck_press("left") || buffercheck_press("right") || buffercheck_press("up") || buffercheck_press("down"))){
			if(_taunt_type != "tauntmoney"){
				voice_stop_array(tauntsound);
				_taunt = false;
			}
		}
	
		if(_state == "jump" && _vspd <= 0 && _height >= _groundlevel+100 && !_rolljump && !_afterslam && !_attack){
			if(keyhold("crouch")){
				//dropping down
				_vaccel += 12;
				_noslidecd = 20;
				_vspd -= _vaccel;
				if(_vspd <= -32){
					_vspd = -32;
				}
			}
		} else {
			_vaccel = 0;
		}
		
		if(_slide || _runroll){
			if(keyhold("up")){
				_spd[1] = -3;
			} else if(keyhold("down")){
				_spd[1] = 3;
			} else {
				_spd[1] = 0;
			}
		}
		
		if(!_attack){
			if(_attackcooldown > 0){
				_attackcooldown --;
			} else if(_attackcooldown < 0){
				_attackcooldown = 0;
			}
		}
		
		//punching
				
		if(_attack && _attacktype == "idle"){
			if(_height <= _groundlevel && _running){
				_spd[0] = 0;
				_running = false;
				_runtimer = 0;
				_runs = 0;
			}
		}
				
		if(_success_hit > 0){
			_success_hit --;
		}
				
		function punch(){
			if(_noAtkTimer <= 0){
				_spd[0] = 6*_curdir;
				_displayobj.image_index = 0;
				var downattack = false;
				if(_success_hit <= 0 || (!keyhold("left") && !keyhold("right"))){
					if(place_meeting_array(x,y,global._hurtboxArray)){
						var enm = place_meeting_array(x,y,global._hurtboxArray, true);
						if(instance_exists(enm) && instance_exists(enm._parentobj)){
							if(_hitobj.y <= enm.y){
								if(variable_instance_exists((enm._parentobj).id, "_typeallowed")){
									if(array_length((enm._parentobj)._typeallowed) == 0 || (array_length((enm._parentobj)._typeallowed) > 0 && array_contains((enm._parentobj)._typeallowed, "idle"))){
										if((enm._parentobj)._fall_ko && !(enm._parentobj)._standup) downattack = true;
									}
								} else {
									if((enm._parentobj)._fall_ko && !(enm._parentobj)._standup) downattack = true;
								}
							}
						}
					}
				}
				if(downattack){
					_attacktype = "down";
					_attack = true;
					_attackcooldown = 2;
					_attackvar ++;
					_totalhits = 2;
					_downattack = 5;
					var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
					atk._parentobj = self.id;
					atk._scale = [5, 3.7];
					atk._offset = [0,40];
					atk._timer = 9;
					atk._height = 0;
					
					sfx_play_choose(global._swishsounds[0]);
				} else {
					_attacktype = "idle";
					_attack = true;
					_attackcooldown = 2;
					_attackvar ++;
					_totalhits = 7;
					_downattack = 0;
					var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
					atk._parentobj = self.id;
					atk._scale = [4.85, 4.2];
					atk._offset = [178,-12];
					atk._timer = 9;
					
					sfx_play_choose(global._swishsounds[0]);
				}
			}
		}
				
		if(global._finalhit <= 0 && _atk_timer > 0){
			_atk_timer --;
		}
				
		if(!_shield && !_afterslam){
			if(!_enemygrab && !_throw && !_grab){
				if(!_attack && _attackcooldown == 0 && !_rolljump){
					if(_delayupper || buffercheck_press("jump")){
						if(_crouch || _delayupper){
							_delayupper = false;
							
							if(keyhold("left")){
								_curdir = DIR_L;
							}
							if(keyhold("right")){
								_curdir = DIR_R;
							}
							
							if(_runroll_after <= 0){
								if(_doublekickbools[0] == true && _doublekickbools[1] == true){
									if(!_doublekick){
										//double kick
										_displayobj.image_index = 0;
										_attacktype = "doublekick";
										_attack = true;
										_attackcooldown = 2;
							
										_doublekick = true;
										_downattack = 0;
							
										if(_hurtTimer > 0){
											_doublekick = false;
											_attack = false;
											_attacktype = "";
										}
									}
								} else {
									if(!_upper){
										//uppercut
										_displayobj.image_index = 0;
										_attacktype = "upper";
										_attack = true;
										_attackcooldown = 2;
								
										_upper = true;
										_downattack = 0;
									}
								}
					
								sfx_play_choose(global._swishsounds[1]);
							}
						}
					}
					
					if(_nodive_timer <= 0 && !_forceroll && buffercheck_press("dive")){
						switch(_state){
							case "default":
							case "jump":
								var checkcolleft = false;
								var checkcolright = false;
								if(instance_number_array(_collidesolid) > 0 || instance_number_array(global._solidOtherArray) > 0){
									if(place_meeting_array(x+64,y,_collidesolid) || place_meeting_array(x+64,y,global._solidOtherArray)){
										checkcolright = true;
									}
									if(place_meeting_array(x-64,y,_collidesolid) || place_meeting_array(x-64,y,global._solidOtherArray)){
										checkcolleft = true;
									}
								}
								if((_curdir == DIR_R && !checkcolright) || (_curdir == DIR_L && !checkcolleft)){
									if(!_runroll && _running && _skidtimer == 0 && (abs(_spd[0]) >= (_maxspd[0]-2) || abs(_spd[1]) >= (_maxspd[1]-2)) && _rundist >= 16 && (keyhold("left") || keyhold("right"))){
										_runroll = true;
										_runroll_dive_timer = 0;
										_runroll_dive = false;
										_runroll_slide = false;
									
										_runhops = 0;
										if(keyhold("right")){
											_spd[0] = _maxspd[0];
											_curdir_prev = _curdir;
											_curdir = DIR_R;
										} else if(keyhold("left")){
											_spd[0] = -_maxspd[0];
											_curdir_prev = _curdir;
											_curdir = DIR_L;
										}
								
										_rollspd = 20*_curdir;
								
										if(_height <= _groundlevel + 64){
											_vspd = 10;
										}
										_jump = true;
								
										sfx_play(snd_jump);
								
										_attackcooldown = 2;
										var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
										atk._parentobj = self.id;
										atk._scale = [4, 4];
										atk._offset = [64,-24];
										atk._timer = 999;
										atk._timerignore = true;
										atk._type = "roll";
										atk._damage = ATK_KO;
									}
								}
							break;
						}
					}
					
					if(buffercheck_press("punch")){
						_punchtimer = 0;
						switch(_state){
							case "default":
								punch();
							break;
							case "jump":
								_rolljump = false;
								_jump_enmhit = false;
								_displayobj.image_index = 0;
								_attacktype = "air";
								_attackhits = 2;
								_attack = true;
								_attackcooldown = 2;
							
								sfx_play_choose(global._swishsounds[2]);
							break;
							case "roll":
								if(_runroll_dive && _runroll_dive_timer >= 8 && !_runroll_slide){
									_runroll_dive = false;
									_runroll = false;
									_jump_enmhit = false;
									_preservespd = _rollspd*_curdir;
									_height += 1;
									_vspd += 8;
									_rolljump = false;
									_displayobj.image_index = 0;
									_attacktype = "air";
									_attackhits = 2;
									_attack = true;
									_attackcooldown = 2;
							
									sfx_play_choose(global._swishsounds[2]);
								}
							break;
						}
					}
				
					if(keyhold("punch")){
						//rapid punch
						_punchtimer ++;
						if(_state == "default"){
							if(!_attack && _punchtimer % 4 == 0){
								punch();
							}
						} else {
							_punchtimer = 1;
						}
					} else {
						_upper = false;
						if(_atk_timer > 0 && _hits >= 3 && !_finalcombo){
							_hits = 0;
							_displayobj.image_index = 0;
							_atk_timer = 0;
							_attack = true;
							_finalcombo = true;
							if(_downattack <= 0){
								_attacktype = "idle";
								
								var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
								atk._parentobj = self.id;
								atk._scale = [4, 2.2];
								atk._offset = [136,-54];
								atk._timer = 9;
								atk._damage = ATK_KO;
							} else {
								_attacktype = "down";
								
								var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
								atk._parentobj = self.id;
								atk._scale = [5, 3.5];
								atk._offset = [0,90];
								atk._timer = 9;
								atk._damage = ATK_KO;
								atk._height = 0;
								atk._delay = 16;
							}
						}
						_punchtimer = 1;
					}
					
					if(keyhold("grab")){
						//other
						if(_state == "default" && _height <= _groundlevel && !_attack && !_enemygrab && !_slam){
							if(place_meeting(x, y, obj_item)){
								_iteminst = instance_place(x, y, obj_item);
								if(!_iteminst._hopping){
									_grabhold_other = _iteminst;
									_grabhold_other_timer = 2;
								}
							} else if(place_meeting(x, y, obj_tnt)){
								_iteminst = instance_place(x, y, obj_tnt);
								if(!_iteminst._trigger && !_iteminst._flyhigh && !_iteminst._boxonly){
									_grabhold_other = _iteminst;
									_grabhold_other_timer = 2;
								}
							} else if(place_meeting(x, y, obj_moneypickup_mask)){
								_iteminst = instance_place(x, y, obj_moneypickup_mask);
								if(_iteminst._act == 1 && !_iteminst._picked){
									_grabhold_other = _iteminst;
									_grabhold_other_timer = 2;
								}
							}
						}
						
						//enemies
						if(_state == "default" && _height <= _groundlevel && !_enemygrab && _noAtkTimer <= 0 && !_attack){
							if(!_grab && !_anim_transition){
								//check if standing on fallen badhead
								_grabhold_downfail = true;
								if(place_meeting(x, y, obj_en_grabzone)){
									var gzone = instance_place(x, y, obj_en_grabzone);
									if(gzone != noone && instance_exists(gzone)){
										var g_enm = gzone._parentobj;
										if(g_enm != noone && instance_exists(g_enm)){
											if(g_enm._fall_ko && g_enm._height <= g_enm._groundlevel){
												_grabhold_downfail = false;
											}
											if(g_enm._standup){
												_grabhold_downfail = true;
											}
										}
									}
								}
							
								if((_grabhold_downfail && (_curdir == DIR_R && place_meeting(x+_grabdist, y, obj_en_grabzone)) || (_curdir == DIR_L && place_meeting(x-_grabdist, y, obj_en_grabzone))) || !_grabhold_downfail){
									var gzone;
									if(_grabhold_downfail){
										if(_curdir == DIR_R){
											gzone = instance_place(x+_grabdist, y, obj_en_grabzone);
										} else if(_curdir == DIR_L){
											gzone = instance_place(x-_grabdist, y, obj_en_grabzone);
										}
									} else {
										gzone = instance_place(x, y, obj_en_grabzone);
									}
								
									_grabinst = gzone._parentobj;
									if(has_trait(TRAIT_GRAB, _grabinst)){
										if(_grabinst._sequence_finished && _grabinst._phaseend_act == 0 && !_grabinst._stunlock_dodge && _grabinst._stunlock_after <= 0 && !_grabinst._attack && !_grabinst._grabdodge && !_grabinst._death && !_grabinst._grabbed && (((!_grabinst._fall_ko || _grabinst._standup) && _grabhold_downfail) || !_grabhold_downfail) && _grabinst._curstate != STATE_JUMP && !_grabinst._block){
											if(!_grabinst._parachute || (_grabinst._parachute && _grabinst._height <= _grabinst._groundlevel+550)){
												if(_grabinst._standup || (!_grabinst._standup && _grabinst._height <= _grabinst._groundlevel)){
													//check grab height if falling
													if((_grabhold_downfail && !_grabinst._falling || (_grabinst._falling && _grabinst._height <= _height+140)) || !_grabhold_downfail){
														_grabhold_enemy = _grabinst;
														_grabhold_enemy_timer = 2;
													}
												} else {
													_grabinst = noone;
												}
											} else {
												_grabinst = noone;
											}
										} else {
											_grabinst = noone;
										}
									} else {
										_grabinst = noone;
									}
								}
							}
						}
					}
				} else {
					_punchtimer = 1;
				}
			
				//grab enemies
				_grabweight = 1;
				if(_grab){
					_stopwalk = 3;
				
					if(_hurtTimer > 0 || _falling){
						_grab = false;
					}
				}
				
				if(buffercheck_release("grab")){
					var gzone;
					if(_grabhold_downfail){
						if(_curdir == DIR_R){
							gzone = instance_place(x+_grabdist, y, obj_en_grabzone);
						} else if(_curdir == DIR_L){
							gzone = instance_place(x-_grabdist, y, obj_en_grabzone);
						}
					} else {
						gzone = instance_place(x, y, obj_en_grabzone);
					}
					if(instance_exists(gzone)){
						if(gzone._parentobj != noone && instance_exists(gzone._parentobj)){
							(gzone._parentobj)._grabattempt = 8;
						}
					}
					
					if(_state == "default" && _height <= _groundlevel && !_enemygrab && _noAtkTimer <= 0 && !_attack){
						if(!_grab && !_anim_transition){
							_spd[0] = 6*_curdir;
							_displayobj.image_index = 0;
							
							sfx_play_choose(global._swishsounds[0]);
							_grab = true;
						}
					}
					
					if(_grabhold_enemy != noone){
						//grab enemies
							
						_grabinst = _grabhold_enemy;
							
						_damageTimer = 0;
						_enemygrab = true;
						_grabinst._falling = false;
						_grabinst._dh = self;
						_grabinst._grabstart = true;
						_grabinst._grabbed = true;
						//_grabinst._grab_startpos = [_grabinst.x - x, 0];
						//_grabinst._grab_lerppos = [0, -200];
						with(_grabinst){
							_displayobj.image_index = 0;
						}
						if(!_grabhold_downfail){
							_grabinst._fall_ko = false;
							_grabinst._falling = false;
							_grabinst._standup = false;
							_grabinst._kotimer = 0;
											
							_grabdown = true;
						}
										
						global._deadid = _grabinst.id;
						with(obj_punchhitbox){
							if(self.id == global._deadid){
								instance_destroy();
							}
						}
									
						if(_grabinst._grabhp){
							with(_grabinst._hitobj){
								if(has_trait(TRAIT_HP, _parentobj)){
									ui_hp_stuff(_parentobj);
								}
							}
						}
							
						_grabhold_enemy = noone;
						_grabhold_other = noone;
					} else if(_grabhold_other != noone){
						//grab other
							
						//item pickup
						switch(_grabhold_other.object_index){
							case obj_item:
								if(!_pickup){
									_iteminst = _grabhold_other;
										
									_state = "item";
									_displayobj.image_index = 0;
									_spd = [0,0];
									_itemanim = 0;
									_curdir = DIR_L;
									if(x >= _iteminst.x+96){
										_curdir = DIR_R;
									}
									_curdir_prev = _curdir;
									switch(_iteminst._restore_type){
										case 0:
											_hp += _iteminst._restore;
											_lastpickuphprestore = _iteminst._restore;
												
											if(_hp > _maxhp){
												_hp = _maxhp;
											}
												
											with(obj_gui){
												ui_fade("dh", 1);
											}
										break;
										case 1:
											global._tntjuice += _iteminst._restore;
											if(global._tntjuice > global._tntjuice_max){
												global._tntjuice = global._tntjuice_max;
											}
												
											sfx_play(snd_flame, 0.75);
												
											with(obj_gui){
												_tntamp = 18;
													
												ui_fade("tnt", 1);
											}
										break;
									}
									sfx_play_choose(global._swishsounds[2]);
									
									_pickup = true;
								}
							break;
							case obj_tnt:
								if(!_pickup){
									//tnt explosion
									_iteminst = _grabhold_other;
										
									_iteminst._dh = self.id;
									_state = "item";
									_displayobj.image_index = 0;
									_spd = [0,0];
									var tdir = 1;
									if(_iteminst._dir == "l"){
										tdir = -1;
									}
									_curdir = tdir;
									_curdir_prev = _curdir;
									x = _iteminst.x - (140*tdir);
									y = _iteminst.y - 42;
									_itemanim = 1;
									
									_pickup = true;
								}
							break;
							case obj_moneypickup_mask:
								//item pickup
								if(!_pickup){
									_iteminst = _grabhold_other;
									_state = "item";
									_displayobj.image_index = 0;
									_spd = [0,0];
									_itemanim = 0;
										
									sfx_play_choose(global._swishsounds[2]);
									sfx_play(snd_money1);
									
									_iteminst._dh = self.id;
									
									_pickup = true;
									_moneypickup = true;
									_moneypickup_inst = _iteminst;
								}
							break;
						}
							
						_grabhold_other = noone;
						_grabhold_enemy = noone;
					}
				}
			} else {
				_punchtimer = 1;
				if(_grabinst != noone && instance_exists(_grabinst)){
					if(has_trait(TRAIT_SLAM, _grabinst)){
						_grabweight = _grabinst._grabweight;
						_running = false;
						if(_slam){
							_stopwalk = 3;
							_spd = [0,0];
						}
						if(!_throw && !_grabinst._grabstart && _grabinst._grabbed){
							if((_anim != "grabdown" && _anim != "grab" && !_anim_transition) && !_slam_init && keyhold("punch") && (keyhold("left") || keyhold("right"))){
								_slam_init = true;
							}
							if(_slam_init){
								//slam
								if(!_slam){
									_slam_bufferkeys = [false,true];
									_displayobj.image_index = 0;
								}
								global._cameraOffset = [global._defCamOffset[0], global._defCamOffset[1]-56];
								_slam = true;
								_slamdir = _curdir;
						
								//slam inputs
								var frame = _displayobj.image_index;
								var keys_ = ["left", "right"];
								if(_slamdir == DIR_L){
									keys_ = ["right", "left"];
								}
							
								//prompts
								if(_prompts != noone && instance_exists(_prompts)){
									if(frame < 11){
										_prompts._help_prompt = global._help_prompt_time;
										_prompts._prompt_type = "slam"+keys_[0];
									} else {
										_prompts._help_prompt = global._help_prompt_time;
										_prompts._prompt_type = "slam"+keys_[1];
									}
								}
							
								if(frame >= 8 && frame <= 12){
									//other side
									_slam_bufferkeys[1] = false;
									if(keyhold(keys_[0])){
										_slam_bufferkeys[0] = true;
									}
									if(keyhold(keys_[1])){
										_slam_bufferkeys[0] = false;
									}
								}
								if(frame > 12 && frame < 18){
									if(!_slam_bufferkeys[0]){
										throw_enemy();
									}
								}
								if(frame >= 18){
									//other side
									_slam_bufferkeys[0] = false;
									if(keyhold(keys_[1])){
										_slam_bufferkeys[1] = true;
									}
									if(keyhold(keys_[0])){
										_slam_bufferkeys[1] = false;
									}
								}
								if(frame < 8){
									if(!_slam_bufferkeys[1]){
										throw_enemy();
									}
								}
								
								if(_slambonks >= 3){
									_displayobj.image_index = 0;
									
									_afterslam = true;
									
									with(obj_camera){
										_ampY = 28;
									}
									
									var pos = 350;
									var curpos = pos*_slamdir;
									var partc = instance_create_depth((x-170)+curpos, y, 0, obj_particle);
									partc._type = "fx5";
									
									sfx_play_choose([snd_dhthud,snd_dhthud2,snd_dhthud3]);
									
									throw_enemy();
								}
							}
						
							//letting go of the grabbed enemy
							if(keyhold("shield") || (!_slam_init && buffercheck_release("punch") || (!_slam && buffercheck_release("grab")))){
								throw_enemy();
							}
						}
						
						//force throw
						if(_damageTimer > 0){
							global._cameraOffset = [global._defCamOffset[0], global._defCamOffset[1]];
							force_throw_enemy();
						}
					} else {
						//force throw
						if(_damageTimer > 0){
							global._cameraOffset = [global._defCamOffset[0], global._defCamOffset[1]];
							force_throw_enemy();
						}
						
						//letting go of the grabbed enemy
						if(!_slam && buffercheck_release("grab")){
							throw_enemy();
						}
					}
				}
			}
		}	
		
		//charged
		if(_state == "default" && _hurtTimer == 0 && !_falling && !_dead && !_shield){
			if(_candospecial && global._tntjuice >= global._tntjuice_max){
				if(keyhold("tnt")){
					var game = instance_find(obj_gui, 0);
					game._holdc += 0.5;
					if(game._holdc > 10){
						if(_enemygrab){
							if(_grabinst != noone && instance_exists(_grabinst)){
								_grabinst._height += 190;
								_grabinst._vspd = 8;
					
								_grabinst._falling = true;
								_grabinst._fall_ko = false;
								_grabinst._falls = 0;
					
								_grabinst._jump = true;
								_grabinst._grabout = true;
							
								_grabinst._grabbed = false;
								_grabinst._curstate = STATE_FALL;
								_grabinst._fixwall = true;
							
								with(_grabinst){
									do_grid_collisions();
								}
							
								_enemygrab = false;
								_state = "default";
							}
						}
						global._tntjuice = 0;
						game._holdc = 0;
						_displayobj.image_index = 0;
						_blowup = true;
						_blowupexpl = false;
						global._blowup_kill = 0;
						global._tntZoomState = 0;
						global._tntZoomTimer = 5;
						global._tntZoom = true;
						global._mashinst = self;
							
						for(var i = 0; i < array_length(global._enemyArray); i++){
							with(global._enemyArray[i]){
								if(variable_instance_exists(self.id, "_tntko")){
									_tntko = false;
								}
							}
						}
						
						sfx_play(snd_charge);
						sfx_play(snd_charge2);
					}
				} else {
					var game = instance_find(obj_game, 0);
					game._holdc = 0;
				}
			}
				
			//mash attack
			if(_candospecial && global._tntjuice >= global._tntjuice_mash){
				if(_mashact == 0 && !_enemygrab && !_jump && buffercheck_release("tnt")){
					_mashsuccess = false;
					global._dhmashing = true;
					global._tntjuice_store = global._tntjuice;
					global._tntjuice -= 30;
					with(obj_gui){
						_holdc = 0;
					}
					_mashtime = 75;
					_mashact = 1;
					sfx_play(snd_charge);
							
					with(obj_gui){
						ui_fade("tnt", 1);
					}
				}
			}
		} else {
			var game = instance_find(obj_game, 0);
			game._holdc = 0;
		}
	}
}