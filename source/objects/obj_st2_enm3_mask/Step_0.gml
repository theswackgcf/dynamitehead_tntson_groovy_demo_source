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
					if(_spawndir == "l" || _spawndir == "r"){
						_sequence_id = seq_st2_enm3_entH;
					} else if(_spawndir == "u" || _spawndir == "d"){
						if(_spawndir == "u"){
							_seq_yscale = 1;
						} else {
							_seq_yscale = -1;
						}
						_sequence_id = seq_st2_enm3_entV;
					} else if(_spawndir == "c"){
						_sequence_id = seq_st2_enm3_entC;
					}
				}
			}
			
			//alt behavior
			if(_enmtype == 0){
				//grinzy
				_movespd[? SPD_WALK] = 7;
				_movespd[? SPD_BACK] = 5;
				_movespd[? SPD_PANIC] = 9;
			}
			if(_enmtype == 1){
				//inty
				_movespd[? SPD_WALK] = 4;
				_movespd[? SPD_BACK] = 2;
				_movespd[? SPD_PANIC] = 6;
				_meleeanims = 1;
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
						_gl_passive_timer ++;
						if(_gl_passive_timer >= 24){
							_gl_passive = false;
							
							var otherenm = 0;
							
							for(var i = 0; i < array_length(global._enemyArray); i++){
								for(var j = 0; j < instance_number(global._enemyArray[i]); j++){
									var inst = instance_find(global._enemyArray[i], j);
									if(instance_exists(inst) && variable_instance_exists(inst.id, "_codename")){
										if(inst._codename != "st2_enm3"){
											otherenm ++;
										}
									}
								}
							}
							
							if(otherenm > 0){
								_gl_passive = true;
							}
							
							_gl_passive_timer = 0;
						}
						
						_movetimer ++;
						scr_enemyscript_spd();
					
						if(_hurttimer == 0 && _gl_tongspin_act == 0){
							switch(_behaviortype){
								case "move":
									if(_curstate == STATE_WALK){
										scr_enemyscript_behavior("walk");
									} else {
										_randoffset = [random_range(-_walkdist[0],_walkdist[0]),random_range(-_walkdist[1],_walkdist[1])];
										_multdist = 1;
									}
									if(_curstate == STATE_FOLLOW){
										if(!_gl_passive){
											scr_enemyscript_behavior("follow");
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
						
						scr_enemyscript_falling();
					
						scr_enemyscript_animation("step");
						
						if(_enmtype != 1){
							if(_falling || _fall_ko || _standup || _grabbed){
								_gl_spin = false;
								_gl_spinact = 0;
								_gl_timer = 0;
								_gl_sinetimer = 0;
							} else {
								_gl_sinetimer ++;
								_dispoffset[1] = sin(_gl_sinetimer/12)*36;
							}
							if(_fall_ko){
								_dispoffset[1] = 0;
							}
						}
						
						if(!_gl_spin){
							if(!has_trait(TRAIT_JABS)){
								add_trait(TRAIT_JABS);
							}
							_gl_spinact = 0;
						} else {
							_curatk = 0;
							_animspeed = 1;
							
							_attack = true;
							_attacktype = "idle";
							if(_gl_spinact == 0){
								_gl_timer ++;
								var dh = instance_nearest(x, y, obj_dh_mask);
								if(dh != noone && instance_exists(dh)){
									if(dh.x < x){
										_curdir = DIR_L;
									} else {
										_curdir = DIR_R;
									}
								}
								if(_gl_timer >= scr_ailevel(20, 50)){
									_jabstop = 0;
									
									sfx_play_proximity(snd_gostspin);
									
									_curstate = STATE_SLIDE;
									_fixwall = true;
									_slide = true;
									_slideact = 1;
									_slidespd = 24*_curdir;
									_slidedir = _curdir;
									_slidedecel = 0.12;
									
									var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
									atk._parentobj = self.id;
									atk._ptype = "enm";
									atk._scale = [5.5, 4];
									atk._offset = [0,-48];
									atk._timer = 299;
									atk._type = "slide_enm";
									atk._damage = ATK_KO;
									atk._persist = true;
									
									_gl_timer = 0;
									_gl_spinact = 1;
								}
							} else {
								//actual spinning
								_animspeed = max(abs(_slidespd)/6,0.1);
								
								_afterim_active = 3;
								
								if(abs(_slidespd) <= 0.3){
									sfx_stop(snd_gostspin);
									_gl_timer = 0;
									_gl_spin = 0;
									_gl_spinact = 0;
								}
							}
						}
						
						//traits
						if(_falling || _fall_ko){
							if(has_trait(TRAIT_DODGE) ){
								remove_trait(TRAIT_DODGE);
							}
						} else {
							if(!has_trait(TRAIT_DODGE) ){
								add_trait(TRAIT_DODGE);
							}
						}
						
						//grabbing dodge
						_grabhp = false;
						
						if(!_falling && _grabbed){
							_grabdodge = true;
							if(_dh != noone && instance_exists(_dh)){
								with(_dh){
									force_throw_enemy();
								}
							}
							sfx_play_choose_proximity(global._swishsounds[1]);
							
							_gl_spin = false;
							_gl_spinact = 0;
							_gl_timer = 0;
						}
						
						if(!_death){
							if(_anim_transition){
								//transitions
								switch(_anim_tr_anim){
									case "spin_idle":
										_anim = "tr_spin_idle";
									break;
									case "standup_idle":
										_anim = "tr_standup_idle";
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
											if(!_gl_spin){
												_anim = "melee_idle"+string(_curatk);
											} else {
												if(_gl_spinact == 0){
													_anim = "spin1";
													//loop spin1
													if(_displayobj.image_index >= _displayobj.image_number-1){
														_displayobj.image_index = 3;
													}
												} else {
													_anim = "spin2";
												}
											}
										break;
										case "blockko":
											_block = false;
											_blocktimer = 0;
											_did_ko = 0;
											_anim_prev = _anim;
											_anim = "blockko";
										break;
									}
									_curspd = [0,0];
									clearpath();
								}
								if(_did_ko == 1 && _anim != "blockko"){
									_did_ko = 2;
								}
								if(_did_ko == 2){
									clearpath();
									_anim_prev = _anim;
									_anim = "blockko";
									if(_displayobj.image_index >= _displayobj.image_number-1){
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
								
								if(_behaviortype == "hopping"){
									if(!_hop_walk){
										_anim_prev = _anim;
										_anim = "hop";
									} else {
										_anim_prev = _anim;
										_anim = "walk";
										_animspeed = _walk_animspeed;
									}
								}
								
								if(_fall_ko){
									_anim_prev = _anim;
									_anim = "dead";
									if(_standup && _hurttimer <= 0){
										_anim_prev = _anim;
										_anim = "standup";
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
								
								switch(_gl_tongspin_act){
									case 1:
										_anim_prev = _anim;
										_anim = "tongspin1";
									break;
									case 2:
									case 3:
										_anim_prev = _anim;
										_anim = "tongspin2";
									break;
								}
							}
						} else {
							if(!_downkill){
								_anim_prev = "";
								_anim = "skull";
								if(!_gl_setskull){
									image_index = irandom_range(0,_skullnum-1);
									_gl_setskull = true;
								}
							} else {
								_anim_prev = "";
								_anim = "dead";
							}
						}
						
						//make transition
						if(_anim_prev != _anim){
							if(compare_anim("spin2", "idle") || compare_anim("spin2", "walk") || compare_anim("spin2", "backoff")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "spin_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
							if(compare_anim("tongspin2", "idle") || compare_anim("tongspin2", "walk") || compare_anim("tongspin2", "backoff")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
							if(compare_anim("standup", "idle") || compare_anim("standup", "walk") || compare_anim("standup", "backoff")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_idle";
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
								if(_crouchkicktime <= 6 && _displayobj.image_index >= _displayobj.image_number-1){
									_attack = false;
									_attacktype = "";
								}
							} else {
								if(_crouchkicktime > 0){
									_anim = "crouchkick";
								}
							}
						}
					
						if(!_death){
							if(!_gl_passive){
								scr_enemyscript_detect();
							}
						}
					
						//float effect
						/*_heightoffset = -50+(sin(_sintimer/8)*22);
						if(_death || _falling || _fall_ko || _standup){
							_heightoffset = 0;
						}*/
						
						if(_block || _blocktimer > 0){
							_attack = false;
							_attacktype = "";
						}
						
						//air block directions
						
						/*var dh = instance_nearest(x,y,obj_dh_mask);
						if(instance_exists(dh)){
							if((x < dh.x && _curdir == DIR_L) || x >= dh.x && _curdir == DIR_R){
								if(array_contains(_dodgezones, "air")){
									for(var r = 0; r < array_length(_dodgezones); r++){
										if(_dodgezones[r] == "air"){
											array_delete(_dodgezones, r, 1);
										}
									}
								}
							} else {
								if(!array_contains(_dodgezones, "air")){
									array_push(_dodgezones, "air");
								}
							}
						}
						if(_blocktimer > 0){
							if(!array_contains(_dodgezones, "air")){
								array_push(_dodgezones, "air");
							}
						}*/
						
						if(_attack && _attacktype == "upper"){
							remove_trait([TRAIT_DODGE,TRAIT_BLOCK]);
						} else {
							if(!has_trait(TRAIT_DODGE)){
								add_trait(TRAIT_DODGE);
							}
							if(!has_trait(TRAIT_BLOCK)){
								add_trait(TRAIT_BLOCK);
							}
						}
						
						//wandering behavior
						if(_enmtype != 0){
							if(_gl_passive){
								_dh = noone;
								_interest = 0;
								_forceattack = 0;
								if(_curstate == STATE_FOLLOW || _curstate == STATE_ATTACK){
									_curstate = STATE_WALK;
								}
							}
						}
						
						if(_curatk >= _meleeanims-1){
							_jabstop = 4;
						}
						if(_curatk >= _meleeanims){
							if(!_gl_spin){
								_displayobj.image_index = 0;
							}
							_curatk = 0;
							_gl_spin = true;
						}
						
						//spinning attack
						if(_shockwave || _mashed || _falling || _fall_ko || _standup){
							if(_gl_tongspin_act > 0){
								_block_endzones = _block_endzones_start;
								_dodgezones = _dodgezones_start;
							}
							_wallbonks = 0;
							_gl_tongspin_timer = 0;
							_gl_tongspin_act = 0;
							_gl_spin = false;
							_gl_spinact = 0;
							_gl_timer = 0;
							_gl_tongspin_amp = 0;
						}
						
						if(_enmtype != -1){
							_gl_tongspin_addtime = false;
							if(_gl_tongspin_act > 0){
								_gl_tongspin_addtime = true;
							}
							
							if(_gl_tongspin_act <> 2){
								_gl_tongspin_amp = 0;
								_dispoffset = [0,0];
							}
							
							if(_gl_tongspin_act > 0){
								if(_taunt > 0 || _shockwave || _falling || _hurttimer > 0 || _blocktimer > 0 || _dodgetimer > 0){
									if(_gl_tongspin_act > 0){
										_block_endzones = _block_endzones_start;
										_dodgezones = _dodgezones_start;
									}
									
									_wallbonks = 0;
									_gl_tongspin_act = 0;
									_gl_tongspin_timer = 0;
								}
							}
							
							if(!_falling && !_fall_ko && !_standup && (_curstate == STATE_IDLE || _curstate == STATE_WALK || _curstate == STATE_FOLLOW || _curstate == STATE_OTHER || _slide)){
								_gl_tongspin_addtime = true;
								
								//force attack move
								if(instance_number_array(global._enemyArray) == 1 && _enmtype != -1 && !_alt_attack){
									_gl_tongspin_timer = 9999;
								}
								
								if(_inview){
									if(_gl_tongspin_act == 0){
										if(_gl_tongspin_timer >= scr_ailevel(180, random_range(250, 500))){
											//activate spin
											_gl_spin = false;
											_gl_spinact = 0;
											_attack = false;
											_attacktype = "";
											_slidespd = 0;
											sfx_stop(snd_gostspin);
										
											_displayobj.image_index = 0;
											_gl_tongspin_timer = 0;
											_gl_tongspin_act = 1;
											_spin = false;
											_freespd = false;
										}
									}
								} else {
									_gl_tongspin_timer = 0;
								}
							}
							
							//reset spinning incase stuck
							if(_anim == "idle"){
								with(obj_punchhitbox){
									if(_parentobj.id == other.id){
										if(_type == "spin_enm"){
											if(other._gl_tongspin_act > 0){
												other._block_endzones = other._block_endzones_start;
												other._dodgezones = other._dodgezones_start;
											}
											
											other._wallbonks = 0;
											other._gl_tongspin_act = 0;
											other._curstate = STATE_WALK;
											other._freespd = false;
											other._spin = false;
											
											instance_destroy();
										}
									}
								}
							}
							
							switch(_gl_tongspin_act){
								case 1:
									//prep animation
									if(_displayobj.image_index >= _displayobj.image_number-1){
										_gl_tongspin_timer = 0;
										_gl_tongspin_act = 2;
									}
								break;
								case 2:
									_alt_attack = true;
								
									//pre attack spinning
									_curspd = [0,0];
									clearpath();
									
									_gl_tongspin_amp += 0.4;
									_dispoffset[0] = sin(_gl_tongspin_timer/2)*_gl_tongspin_amp;
									_dispoffset[1] = cos(_gl_tongspin_timer/2)*(_gl_tongspin_amp/2);
									if(_gl_tongspin_amp >= 32){
										_freedir = choose(DIR_L,DIR_R);
										_freedir_v = choose(DIR_U, DIR_D);
											
										_spin = true;
											
										var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
										atk._parentobj = self.id;
										atk._ptype = "all";
										atk._scale = [5.5, 4];
										atk._offset = [0,-48];
										atk._timer = 999;
										atk._height = 0;
										atk._type = "spin_enm";
										atk._damage = ATK_KO;
										atk._persist = true;
										atk._canparry = false;
										
										_gl_tongspin_timer = 0;
										_gl_tongspin_act = 3;
									}
									
									if(_hurttimer > 0 || _falling){
										_block_endzones = _block_endzones_start;
										_dodgezones = _dodgezones_start;
										
										_wallbonks = 0;
										_gl_tongspin_act = 0;
										_gl_tongspin_timer = 0;
									} else {
										if(_standup){
											_block_endzones = _block_endzones_start;
											_dodgezones = _dodgezones_start;
											
											_wallbonks = 0;
											_gl_tongspin_act = 0;
											_gl_tongspin_timer = 0;
										} else {
											_block_endzones = ["upper","idle","crouch","slide"];
											_dodgezones = [];
										}
									}
								break;
								case 3:
									//spinning around
									_curstate = STATE_OTHER;
									_curspd = [0,0];
									clearpath();
										
									_attack = false;
									_afterhop = 0;
									
									_gl_timer = 0;
									_gl_spin = 0;
									_gl_spinact = 0;
									_slidespd = 0;
									
									var spd = 14;
									
									_freespd = true;
									
									_block = false;
									_blocktimer = 0;
									
									_walltouch = 0;
									_walltouch_y = 0;
									_fixwall = false;
									
									_afterim_active = 3;
									
									var maxbonk = 14;
									
									//set speed which depends on direction
									if(_enmtype == 0){
										_gl_tongspin_amp = 16;
										_dispoffset[0] = sin(_gl_tongspin_timer/2)*_gl_tongspin_amp;
										_dispoffset[1] = cos(_gl_tongspin_timer/2)*(_gl_tongspin_amp/2);
										
										_fallxspd = (spd+(_wallbonks*0.5))*_freedir;
										_fallyspd = (spd+(_wallbonks*0.5))*_freedir_v;
									}
									if(_enmtype == 1){
										spd = 20;
										_fallxspd = spd*_freedir;
										_fallyspd = spd*_freedir_v;
									}
									
									//particles
									_gl_particle ++;
									if(_gl_particle >= 5){
										var p = instance_create_depth(x-52+random_range(-20,20),y+76+random_range(-20,20), depth, obj_particle);
										p._type = "gost_smoke"+string(choose(1,2,3));
										_gl_particle = 0;
									}
									
									//ending
									if(_height <= _groundlevel+12 && (_falling || _wallbonks >= maxbonk || abs(_fallxspd) < 4 || _successparry > 0)){
										_block_endzones = _block_endzones_start;
										_dodgezones = _dodgezones_start;
										
										_spin = false;
										
										_freespd = false;
										_fallyspd = 0;
										_wallbonks = 0;
										_gl_tongspin_act = 0;
										_gl_tongspin_timer = 0;
									} else {
										_block_endzones = ["air","upper","idle","crouch","slide"];
										_dodgezones = [];
									}
								break;
							}
							
							if(_gl_tongspin_addtime){
								_gl_tongspin_timer ++;
							}
						}
						//inty
						if(_enmtype == 1){
							if(_gl_tongspin_act == 3 && _height <= _groundlevel){
								with(obj_camera){
									_ampY = 22;
								}
								sfx_play_choose_proximity([snd_dhthud,snd_dhthud2,snd_dhthud3]);
								_height = _groundlevel + 4;
								_vspd = 24;
								_jump = true;
							}
						}
						
						if(_anim == "taunt"){
							if(_didtauntsound == false){
								voice_play_overlap_proximity(snd_gostlik_taunt, 1);
								_didtauntsound = true;
							}
						}
						else{
							_didtauntsound = false;
						}
					
						scr_enemyscript_other();
					} else {
						_curstate = STATE_OTHER;
						clearpath();
					}
					
					scr_enemyscript_death();
					
					//looping sounds
					var spinstartsnd = false;
					var spinsnd = false;
					
					if(_gl_tongspin_act == 2){
						spinstartsnd = true;
					}
					if(_gl_tongspin_act == 3){
						spinsnd = true;
					}
					if(_allsounds != -1){
						if(spinstartsnd){
							if(!sfx_isplaying(snd_spinstart)){
								sfx_play_proximity(snd_spinstart, 0.6);
								sfx_pitch(snd_spinstart, random_range(1,1.3));
							}
						} else {
							if(sfx_isplaying(snd_spinstart)){
								sfx_stop(snd_spinstart);
							}
						}
					
						if(spinsnd){
							if(!sfx_isplaying(snd_spin)){
								sfx_play_proximity(snd_spin, 0.7);
							}
						} else {
							if(sfx_isplaying(snd_spin)){
								sfx_stop(snd_spin);
							}
						}
					} else {
						audio_stop_sound(snd_spin);
						audio_stop_sound(snd_spinstart);
					}
					
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
					
					if(!_attack){
						scr_enemyscript_dir();
					}
					
					scr_enemyscript_bottomscript();
					
					if(_successparry > 0){
						_freespd = false;
						_slidespd = 0;
						_gl_spin = false;
						_gl_spinact = 0;
						_gl_timer = 0;
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