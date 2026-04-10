{
	if(!global._debug){
		visible = false;
	} else {
		visible = global._showHitbox;
	}
	
	scr_sequence_pause();
	
	if(!global._pause){
		if(!_init){
			_startTimer = 2;
			if(_fr_type == "fridge_crouch"){
				_startTimer = 0;
			}
			scr_enemyscript_init("step");
		} else {
			if(!_fr_settype){
				if(place_meeting(x,y,obj_event)){
					var event = instance_place(x,y,obj_event);
					if(instance_exists(event) && string_starts_with(event._event, "fridge_")){
						_fr_type = event._event;
					}
				}
				if(place_meeting(x,y,obj_event_other)){
					var event = instance_place(x,y,obj_event_other);
					if(instance_exists(event) && string_starts_with(event._event, "fridge_")){
						_fr_type = event._event;
					}
				}
				_fr_settype = true;
			}
			
			if(_startTimer > 0 && (_fr_type == "fridge_upper" || _fr_type == "fridge_upper_win")){
				_height = 520;
				_vspd = -16;
			}
			
			if(_startTimer > 0 && _fr_type == "fridge_tnt"){
				_fr_dir = choose(DIR_L,DIR_R);
				_jump = true;
				_height = 520;
				_vspd = -20;
			}
			
			if(_startTimer > 0 && _fr_type == "fridge_combo"){
				_jump = true;
				_height = 520;
				_vspd = -20;
			}
			
			if(_startTimer > 2){
				_startTimer = 2;
			}
			
			_startTimer --;
			if(!_idiot && _startTimer <= 0){
				scr_enemyscript_behavior("");
				if(_freeze <= 0){
					_movetimer ++;
					
					//fridge types and behavior
					
					if(_fr_settype){
						if(_fr_type != "fridge_slam" && _fr_type != "fridge_combo"){
							_hp = _maxhp;
						}
						if(_fr_type == "fridge_slam"){
							_maxhp = 10;
							if(!_fr_sethp){
								_hp = _maxhp;
								_fr_sethp = true;
							}
						}
						if(!_fr_backtopos){
							if(_fr_type != "fridge_tnt"){
								_curdir = DIR_L;
							} else {
								_curdir = _fr_dir;
							}
						}
						switch(_fr_type){
							case "fridge_kicks":
								_enemytraits = [TRAIT_HURT];
								if(_falling || _fall_ko){
									_enemytraits = [];
								}
								
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_punch"){
											other._fr_tipobj = self;
										}
									}
								}
								
								_atkallowed = [ATK_NORM];
								_typeallowed = ["idle"];
								if(_hurts < 4){
									_hurts = 4;
								}
							break;
							case "fridge_crouch":
								_enemytraits = [TRAIT_HURT];
								_atkallowed = [ATK_KO];
								_typeallowed = ["crouch"];
								_kotimer = 0;
								if(_fall_ko){
									_curdir = DIR_R;
								}
								
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_crouch"){
											other._fr_tipobj = self;
										}
									}
								}
								
								var dh = instance_nearest(x,y,obj_dh_mask);
								if(instance_exists(dh) && distance_to_object(dh) <= 320){
									if(!_fr_kicked && !_fall_ko){
										with(obj_camera){
											_ampY = 24;
										}
										sfx_play_choose_proximity([snd_thud,snd_thud2,snd_thud3,snd_thud4]);
										_fall_ko = true;
										_nocked ++;
									}
								}
							break;
							case "fridge_upper":
							case "fridge_upper_win":
								if(_fr_upperready){
									_enemytraits = [TRAIT_HURT];
									_atkallowed = [ATK_KO];
									_typeallowed = ["upper","doublekick"];
								} else {
									_enemytraits = [];
									_atkallowed = [];
									_typeallowed = [];
								}
								
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_upper"){
											other._fr_tipobj = self;
										}
									}
								}
								
								var bzone = instance_place(x,y,obj_battlezone);
								if(instance_exists(bzone)){
									if(x < bzone.x){
										_curdir = DIR_R;
									}
								}
								
								_jump = true;
								var h = 100;
								if(!_fr_kicked){
									_fallxspd = 0;
									_fallyspd = 0;
									if(_height <= _groundlevel+h+240){
										_fr_upperready = true;
									}
									if(_height <= _groundlevel+h){
										if(!_fr_jump){
											_height = _groundlevel+h+4;
											_vspd = 10;
											_fr_jump = true;
										} else {
											_height = _groundlevel+h;
											_vspd = 0;
										}
									}
								}
							break;
							case "fridge_grab":
								_enemytraits = [TRAIT_GRAB];
								if(global._dialogue){
									_enemytraits = [];
								}
								
								if(_fr_backtopos){
									_enemytraits = [];
									x = lerp(x, _fr_startx, 0.15);
									y = lerp(y, _fr_starty, 0.15);
									if(diff_abs(x,_fr_startx) <= 12 && diff_abs(y,_fr_starty) <= 12){
										x = _fr_startx;
										y = _fr_starty;
										_fr_backtopos = false;
									}
								}
								
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_grab"){
											other._fr_tipobj = self;
										}
									}
								}
								
								_atkallowed = [];
								_typeallowed = [];
								_grabresist = 0;
								_kotimer = 999;
							break;
							case "fridge_spin":
								if(_fr_dodgecd > 0){
									_fr_dodgecd --;
								}
								if(_fr_dodgecd <= 0 && place_meeting(x,y,obj_dh_mask)){
									var dhshield = instance_place(x,y,obj_dh_mask);
									if(instance_exists(dhshield) && dhshield._shield){
										dhshield._freeze = global._freezeFrames.mid_freeze;
										_freeze = global._freezeFrames.mid_freeze;
										
										var p = instance_create_depth(x-64,y-64,depth,obj_particle);
										p._type = "fx6";
										
										global._pad_vibrate = 4;
										
										with(obj_camera){
											_ampX = 12;
										}
										
										sfx_play_choose_proximity([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
										sfx_pitch(snd_punchfail1,1+(_wallbonks*0.1));
										sfx_pitch(snd_punchfail2,1+(_wallbonks*0.1));
										sfx_pitch(snd_punchfail3,1+(_wallbonks*0.1));
									
										_fr_dodgecd = 16-(_wallbonks*2);
									}
								}
							
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_shield"){
											other._fr_tipobj = self;
										}
									}
								}
							break;
							case "fridge_mash":
								_enemytraits = [TRAIT_HURT, TRAIT_MASHED];
								_atkallowed = [ATK_MASH,ATK_MASHKO];
								_typeallowed = [];
								
								if(_fr_solid == noone){
									if(place_meeting(x,y,obj_solid)){
										var sol = instance_place(x,y,obj_solid);
										if(instance_exists(sol) && sol._delete){
											_fr_solid = sol;
										}
									}
								}
								
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_mash"){
											other._fr_tipobj = self;
										}
									}
								}
								
								if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
									_fr_tipobj._prompt = "tutr_mash";
									var dh = instance_nearest(x,y,obj_dh_mask);
									if(instance_exists(dh)){
										if(dh._mashact == 2){
											_fr_tipobj._prompt = "tutr_mash2";
										}
									}
								}
							break;
							case "fridge_tnt":
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_tnt"){
											other._fr_tipobj = self;
										}
									}
								}
							break;
							case "fridge_roll":
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_roll"){
											other._fr_tipobj = self;
										}
									}
								}
							break;
							case "fridge_slam":
								_enemytraits = [TRAIT_GRAB, TRAIT_SLAM];
								if(global._dialogue){
									_enemytraits = [];
								}
								_atkallowed = [];
								_typeallowed = [];
								
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_slam1"){
											other._fr_tipobj = self;
										}
									}
								}
								
								if(_grabbed){
									with(obj_fridge_mask){
										if(_fr_type != "fridge_slam"){
											killself();
										}
									}
								}
								
								if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
									if(!_grabbed){
										_fr_tipobj._prompt = "tutr_slam1";
									} else {
										_fr_tipobj._prompt = "tutr_slam2";
									}
								}
								
								_grabresist = 0;
								_kotimer = 999;
								
								with(obj_dh_mask){
									_slamcount = 0;
									_slambonks = 0;
								}
								
								if(!_grabbed){
									_hp = _maxhp;
								}
								
								if(_death){
									if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
										_fr_tipobj._active = false;
									}
									
									with(obj_fridge_mask){
										if(_fr_type == "fridge_slam_destroy"){
											killself();
										}
									}
								}
							break;
							case "fridge_parry":
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_parry"){
											other._fr_tipobj = self;
										}
									}
								}
							
								if(!global._dialogue){
									var dh = instance_nearest(x,y,obj_dh_mask);
									if(instance_exists(dh)){
										dh._hp = dh._maxhp;
										dh._shieldpower = 1;
									
										if(dh._parryspot && dh._hurtTimer > 0){
											dh._curdir = DIR_R;
										}
										if(!_fr_parryactive && dh._parryspot){
											_fr_parrytimer = 30;
											_fr_parryactive = true;
										}
										if(!dh._parryspot){
											_fr_parryactive = false;
										}
									}
								}
								if(!_fr_parryactive){
									_fr_parryact = 0;
									_fr_parrytimer = 0;
								} else {
									//shooting projectiles
									_fr_parrytimer ++;
									if(_fr_parryact == 0){
										if(_fr_parrytimer >= 60){
											_fr_shoot = false;
											if(instance_exists(_displayobj)){
												_displayobj.image_index = 0;
											}
											_fr_parryact = 1;
											_fr_parrytimer = 0;
											
											sfx_play(snd_fridge_hinge,0.55);
										}
									} else if(_fr_parryact == 1){
										if(!_fr_shoot && _displayobj.image_index >= 4){
											var pr = instance_create_depth(x-32,y+18,depth-12,obj_fridge_projectile);
											pr._curdir = _curdir;
											pr.image_index = irandom_range(0,sprite_get_info(spr_fridge_projectiles).num_subimages-1);
											var p = instance_create_depth(x-64,y-64,depth,obj_particle);
											p._type = "vanish";
											_fr_shoot = true;
											
											sfx_play(snd_barf);
										}
										if(_fr_parrytimer >= 40){
											_fr_parryact = 0;
											_fr_parrytimer = 0;
										}
									}
								}
								
								with(_hitobj){
									if(place_meeting(x,y,obj_fridge_projectile)){
										var pr = instance_place(x,y,obj_fridge_projectile);
										if(instance_exists(pr) && pr._xspd < 0){
											other._fr_crackamp = 50;
											other._fr_crackstate ++;
										
											var p = instance_create_depth(pr.x-32,pr.y-32,depth,obj_particle);
											p._type = "fx6";
											sfx_play(snd_fall_huge, 0.6);
											instance_destroy(pr.id);
										}
									}	
								}
								
								_dispoffset[0] = 0;
								if(_fr_crackamp > 0){
									_dispoffset[0] = sin(random(480))*_fr_crackamp;
									_fr_crackamp --;
								} else if(_fr_crackamp < 0){
									_fr_crackamp = 0;
								}
								
								if(_fr_crackstate >= 3){
									var p = instance_create_depth(x-64,y-64,depth,obj_particle);
									p._type = "vanish";
									with(obj_audio){
										x = other.x;
										y = other.y;
										sfx_play_proximity(snd_ghost);
									}
									
									if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
										_fr_tipobj._active = false;
									}
									
									with(obj_camera){
										_ampX = 35;
									}
									
									if(place_meeting_array(x,y,_collide_solid)){
										var sol = place_meeting_array(x,y,_collide_solid, true, true);
										if(instance_exists(sol) && sol._delete){
											instance_destroy(sol.id);
										}
									}
									
									killself();
								}
							break;
							case "fridge_combo":
								_enemytraits = [TRAIT_HURT,TRAIT_GRAB];
								if(global._dialogue){
									_enemytraits = [];
								}
								
								if(_fr_tipobj == noone){
									with(obj_tipbox){
										if(_prompt == "tutr_combo1"){
											other._fr_tipobj = self;
										}
									}
								}
								
								_atkallowed = [ATK_NORM,ATK_KO,ATK_MASH,ATK_MASHKO];
								_typeallowed = [];
								if(_fr_backtopos){
									_enemytraits = [];
									_atkallowed = [];
									x = lerp(x, _fr_startx, 0.15);
									y = lerp(y, _fr_starty, 0.15);
									if(diff_abs(x,_fr_startx) <= 12 && diff_abs(y,_fr_starty) <= 12){
										x = _fr_startx;
										y = _fr_starty;
										_fr_backtopos = false;
									}
								}
								if(!_falling && !_fall_ko && !_standup && _anim == "idle"){
									_fr_combocount = 0;
								}
								if(_dh_atk > 0 && _dh_atk_inst != noone){
									if(instance_exists(_dh_atk_inst) && _dh_atk_inst._attack && _dh_atk_inst._attacktype == "crouch"){
										if(_fr_combocount == 0){
											_fr_combocount = 1;
										}
									}
								}
								
								if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
									_fr_tipobj._prompt = "tutr_combo"+string(_fr_combocount+1);
								}
								
								if(instance_number(obj_enm_afterIM) > 0 && _fr_combocount == 1){
									_fr_combocount = 2;
								}
								if(_fr_combocount < 2 && _fall_ko){
									_kotimer = 999;
									_fr_backtopos = true;
								}
								if(_fr_combocount == 2 && _fall_ko){
									_kotimer = 0;
									_maxhp = 4;
									if(!_fr_sethp){
										_hp = _maxhp;
										_fr_sethp = true;
									}
									_enemytraits = [TRAIT_HURT];
									_atkallowed = [ATK_NORM];
									_typeallowed = ["idle","down"];
									if(_hurttimer > 0){
										if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
											_fr_tipobj._active = false;
										}
									}
								} else {
									_maxhp = 99;
									_hp = _maxhp;
								}
							break;
						}
						
						switch(_fr_type){
							case "fridge_kicks":
							case "fridge_crouch":
							case "fridge_upper":
								//deleting fridge
								if(_dh_atk > 0){
									_fr_kicked = true;
								}
								if(_fr_kicked && _falling){
									_atkallowed = [];
									_typeallowed = [];
									
									if(place_meeting_array(x,y,_collide_solid)){
										var sol = place_meeting_array(x,y,_collide_solid, true, true);
										if(instance_exists(sol) && sol._delete){
											instance_destroy(sol.id);
										}
									}
								}
								if(_fr_kicked && _fall_ko){
									if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
										_fr_tipobj._active = false;
									}
									
									var p = instance_create_depth(x-64,y-64,depth,obj_particle);
									p._type = "vanish";
									with(obj_audio){
										x = other.x;
										y = other.y;
										sfx_play_proximity(snd_ghost);
									}
									killself();
								}
							break;
							case "fridge_grab":
								if(_fr_throw){
									var p = instance_create_depth(x-64,y-64,depth,obj_particle);
									p._type = "vanish";
									with(obj_audio){
										x = other.x;
										y = other.y;
										sfx_play_proximity(snd_ghost);
									}
									
									if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
										_fr_tipobj._active = false;
									}
									
									with(obj_fridge_mask){
										if(_fr_type == "fridge_grab_destroy"){
											killself();
										}
									}
									killself();
								} else {
									if(_fall_ko){
										_fr_backtopos = true;
										_kotimer = 999;
									}
								}
							break;
							case "fridge_spin":
								if(!global._dialogue){
									var dh = instance_nearest(x,y,obj_dh_mask);
									if(instance_exists(dh) && dh._shield){
										dh._shieldpower = 1;
										if(!_spin){
											_wallbonks = 0;
											if(instance_exists(_displayobj)){
												_displayobj.image_index = 0;
											}
											_spin = true;
											_spinhits = 0;
											
											_freedir = DIR_L;
											_fallyspd = 0;
										} else {
											_freespd = true;
											_fallxspd = (20+(_wallbonks*9))*_freedir;
											_fallyspd = 0;
										
											//wall bonk
											if(_fr_bonkcd <= 0 && (_boundwall.left > 0 || _boundwall.right > 0)){
												if(_fallxspd <> 0){
													if(!_freespd){
														_tempdir *= -1;
														_curdir = _tempdir;
													} else {
														if(_boundwall.left > 0){
															_freedir = DIR_R;
														} else if(_boundwall.right > 0){
															_freedir = DIR_L;
														}
														_tempdir = _freedir;
														_curdir = _freedir;
													}
												}
											
												_wallbonks ++;
						
												_boundwall.left = 0;
												_boundwall.left = 0;
						
												var partc = instance_create_depth(_displayobj.x, _displayobj.y-96, 0, obj_particle);
												partc._type = "fx6";
				
												with(obj_camera){
													if(other._fallxspd <> 0){
														_ampX = 20;
													}
												}
					
												sfx_play_choose_proximity([snd_wallslam,snd_wallslam2,snd_wallslam3]);
										
												_fr_bonkcd = 20;
											}
										
											if(_wallbonks >= 5){
												var p = instance_create_depth(x-64,y-64,depth,obj_particle);
												p._type = "vanish";
												with(obj_audio){
													x = other.x;
													y = other.y;
													sfx_play_proximity(snd_ghost);
												}
												
												if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
													_fr_tipobj._active = false;
												}
												
												with(obj_fridge_mask){
													if(_fr_type == "fridge_spin_destroy"){
														killself();
													}
												}
												killself();
											}
										}
									}
									if(instance_exists(dh) && !dh._shield){
										if(_spin){
											var p = instance_create_depth(x-64,y-64,depth,obj_particle);
											p._type = "vanish";
											x = _fr_startx;
											y = _fr_starty;
										
											_spin = false;
											_freespd = false;
											_fallxspd = 0;
										}
									}
								}
							break;
							case "fridge_mash":
								if(_falling){
									if(_fr_solid != noone && instance_exists(_fr_solid)){
										instance_destroy(_fr_solid.id);
									}
									
									global._tntjuice = 0;
									with(obj_dh_mask){
										_forcemash = false;
									}
									
									if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
										_fr_tipobj._active = false;
									}
									
									var p = instance_create_depth(x-64,y-64,depth,obj_particle);
									p._type = "vanish";
									with(obj_audio){
										x = other.x;
										y = other.y;
										sfx_play_proximity(snd_ghost);
									}
									killself();
								}
							break;
							case "fridge_tnt":
								if(_scrclear_happened && _fall_ko){
									global._tntjuice = 0;
									with(obj_dh_mask){
										_forcetnt = false;
									}
									var p = instance_create_depth(x-64,y-64,depth,obj_particle);
									p._type = "vanish";
									
									if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
										_fr_tipobj._active = false;
									}
									
									with(obj_audio){
										x = other.x;
										y = other.y;
										sfx_play_proximity(snd_ghost);
									}
									killself();
								}
								if(!_scrclear_happened){
									if(_fall_ko){
										_kotimer = 999;
									}
								}
							break;
							case "fridge_upper_win":
								//deleting fridge
								if(_dh_atk > 0){
									_fr_kicked = true;
								}
								if(_fr_kicked && _fall_ko){
									var p = instance_create_depth(x-64,y-64,depth,obj_particle);
									p._type = "vanish";
									with(obj_audio){
										x = other.x;
										y = other.y;
										sfx_play_proximity(snd_ghost);
									}
									
									with(obj_dh_mask){
										var f = instance_create_depth(x,y,depth,obj_finish);
										f._collidewin = true;
									}
									
									killself();
								}
							break;
							case "fridge_roll":
								if(place_meeting(x-32,y,obj_dh_mask)){
									var dh = instance_place(x-32,y,obj_dh_mask);
									if(instance_exists(dh) && dh._runroll && !dh._runroll_dive){
										if(place_meeting_array(x,y,_collide_solid)){
											var sol = place_meeting_array(x,y,_collide_solid, true, true);
											if(instance_exists(sol) && sol._delete){
												instance_destroy(sol.id);
											}
										}
									}
								}
								
								if(place_meeting(x,y,obj_dh_mask)){
									var dh = instance_place(x,y,obj_dh_mask);
									if(instance_exists(dh) && dh._runroll && !dh._runroll_dive){
										with(obj_fridge_mask){
											if(_fr_type == "fridge_upper" || _fr_type == "fridge_upper_win"){
												killself();
											}
										}
										
										with(obj_camera){
											_ampX = 22;
										}
										var p = instance_create_depth(dh.x-48,dh.y-48,-16, obj_particle);
										p._type = "fx6";
										
										sfx_play_choose([snd_kd1,snd_kd2,snd_kd3,snd_kd4,snd_kd5]);
										
										dh._freeze = 6*global._freezevals[global._freezeval];
										_freeze = 6*global._freezevals[global._freezeval];
										_fr_rollkill = true;
									}
								}
							break;
						}
						
						if(_fr_bonkcd > 0){
							_fr_bonkcd --;
						}
					}
					
					if(_fr_rollkill){
						var p = instance_create_depth(x-64,y-64,depth,obj_particle);
						p._type = "vanish";
						with(obj_audio){
							x = other.x;
							y = other.y;
							sfx_play_proximity(snd_ghost);
						}
							
						if(_fr_tipobj != noone && instance_exists(_fr_tipobj)){
							_fr_tipobj._active = false;
						}
							
						killself();
					}
					
					scr_enemyscript_spd();
					
					_curspd = [0,0];
					_realspd = [0,0];
						
					//hop values
					_hop_archeight = _hop_archeight_def;
					_hop_spd = _hop_spd_def;
				
					if(!_death){
						scr_enemyscript_behavior("battlezone");
						scr_enemyscript_behavior("grab");
					}
					
					if(!_fr_throw){
						scr_enemyscript_falling();
			
						scr_enemyscript_animation("step");
					}
					
					if(!_death){
						if(_anim_transition){
							//transitions
							switch(_anim_tr_anim){
								case "spin_idle":
									_anim = "tr_spin_idle";
								break;
								case "fire_idle":
									_anim = "tr_fire_idle";
								break;
							}
							if(instance_exists(_displayobj)){
								if(_displayobj.image_index >= _displayobj.image_number-1){
									_anim_tr_anim = "";
									_anim_prev = _anim;
									_anim_transition = false;
								}
							}
						} else {
							if(_hurttimer == 0){
								switch(_behaviortype){
									case "idle":
										_anim_prev = _anim;
										_anim = "idle";
										_idletimer = 0;
							
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
					
							if(_fall_ko){
								if(!_standup){
									_anim_prev = _anim;
									_anim = "dead";
								} else {
									if(_hurttimer <= 0){
										_anim_prev = _anim;
										_anim = "standup";
									}
								}
							}
							
							//hurt anim
							if(_hurttimer > 0){
								_anim_prev = _anim;
								_anim = "hurt"+string(_hurtanim);
								if(_mashed){
									_anim_prev = _anim;
									_anim = "mashhurt";
									_displayobj.image_index = _mashhurt;
								}
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
						
							if(_fallabove && _hurttimer <= 0){
								_anim_prev = _anim;
								_anim = "standup";
							}
						}
					}
					
					//make transition
					if(_anim_prev != _anim){
						if(instance_exists(_displayobj)){
							if(compare_anim("spin", "idle")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "spin_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
							if(compare_anim("fire", "idle")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "fire_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
						}
					
						_anim_prev = _anim;
					}
			
					scr_enemyscript_other();
				} else {
					_curstate = STATE_OTHER;
					clearpath();
				}
				
				scr_enemyscript_death();
				
				y = _fr_starty;
				_fixwall = false;
				
				_behaviortype = "move";
				_hop_snd = false;
				_hop_arcstart = false;
				_hop_startpos = [x,y];
				_hop_time = 0;
				_hop_arc = 0;
				_curstate = STATE_IDLE;
						
				_dohop = false;
				
				_pissedoff_int = 0;
				_pissedoff = 0;
				
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
				
				if(_fr_type == "fridge_upper" || _fr_type == "fridge_upper_win"){
					_anim = "hangin";
				}
				
				if((_fr_type == "fridge_grab" || _fr_type == "fridge_slam") && !_falling && !_grabbed && !_fall_ko){
					_anim = "grabbable";
				}
				
				if((_fr_type == "fridge_grab" || _fr_type == "fridge_slam") && _standup){
					_anim = "grabbable";
				}
				
				if(_fr_type == "fridge_spin" && _spin){
					_anim = "spin";
				}
				
				if(_fr_type == "fridge_roll"){
					_anim = "rollable";
				}
				
				if(_fr_type == "fridge_parry"){
					if(_fr_parryact == 1){
						_anim = "fire";
					}
				}
				
				if(_death){
					_anim = "idle";
				}
				
				scr_enemyscript_dir();
					
				scr_enemyscript_bottomscript();
			}
		}
	} else {
		clearpath();
		with(_displayobj){
			image_speed = 0;
		}
	}
}