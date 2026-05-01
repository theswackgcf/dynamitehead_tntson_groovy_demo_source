{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		var totalw = sprite_get_width(mask_index);
		
		image_xscale = max(0.5,(totalw-(global._lode_spd*1.2))/totalw);
		
		if(global._inptype == 0){
			_input_digleft = "jump";
			_input_digright = "punch";
		} else if(global._inptype == 1){
			_input_digleft = "shield";
			_input_digright = "taunt";
		}
		
		if(!global._lode_editor && !_win && _backoff <= 0 && !_tnt_activation){
			if(_freeze <= 0){
				if(_backoff_init){
					_offset[1] = 0;
					
					_backoff_init = false;
				}
				
				if(!global._lode_howto){
					_init_timer ++;
					if(_init_timer >= 24 && !_init_voice){
						sfx_play_choose([snd_lode_dialm_start1,snd_lode_dialm_start2,snd_lode_dialm_start3,snd_lode_dialm_start4]);
						_init_voice = true;
					}
				}
				
				if(!_death){
					_xscale = _curdir;
					_animspeed = 1;
		
					_init_timer ++;
					if(_init_timer >= 4 && !_cangetdamage){
						_cangetdamage = true;
					}
		
					//animations
					if(_anim_transition){
						switch(_anim_tr_anim){
							case "climb_in":
								_anim = "climb_in";
							break;
							case "rope_in":
								_anim = "rope_in";
							break;
							case "fall_idle":
								_anim = "fall_idle";
							break;
						}
			
						if(_plstate == LODE_STATE_DIG || image_index >= image_number-1){
							image_index = 0;
							_anim_tr_anim = "";
							_anim_transition = false;
						}
					} else {
						switch(_plstate){
							case LODE_STATE_DEFAULT:
								if(_groundtimer > 0){
									if(abs(_xspd) < _movespd){
										_anim_prev = _anim;
										_anim = "idle";
									} else {
										_anim_prev = _anim;
										_anim = "walk";
									}
									if(_pushtimer > 0){
										_anim = "push";
									}
								} else {
									_anim_prev = _anim;
									_anim = "fall";
								}
							break;
							case LODE_STATE_LADDER:
								_anim_prev = _anim;
								_anim = "climb";
					
								_animspeed = 0;
								if(_xspd <> 0 || _yspd <> 0){
									_animspeed = 1;
								}
							break;
							case LODE_STATE_ROPE:
								_anim_prev = _anim;
								_anim = "rope";
					
								_animspeed = 0;
								if(_xspd <> 0){
									_animspeed = 1;
								}
							break;
							case LODE_STATE_DIG:
								switch(_store_plstate){
									case LODE_STATE_DEFAULT:
										_anim_prev = _anim;
										_anim = "dig_idle";
									break;
									case LODE_STATE_LADDER:
										_anim_prev = _anim;
										_anim = "dig_climb";
									break;
									case LODE_STATE_ROPE:
										_anim_prev = _anim;
										_anim = "dig_rope";
									break;
								}
							break;
						}
			
						if(compare_anim("idle","climb")){
							image_index = 0;
							_anim_tr_anim = "climb_in";
							_anim_transition = true;
							_anim_prev = _anim;
						}
						if(compare_anim("fall","rope")){
							image_index = 0;
							_anim_tr_anim = "rope_in";
							_anim_transition = true;
							_anim_prev = _anim;
						}
						if(compare_anim("fall","idle") || compare_anim("fall","walk") || compare_anim("climb","idle") || compare_anim("climb","walk")){
							image_index = 0;
							_anim_tr_anim = "fall_idle";
							_anim_transition = true;
							_anim_prev = _anim;
						}
						if(compare_anim("tnt","idle") || compare_anim("tnt","walk")){
							image_index = 0;
							_anim_tr_anim = "fall_idle";
							_anim_transition = true;
							_anim_prev = _anim;
						}
					}
		
					_imgspd_mult = 1;
					if(_tnt_power > 0){
						_imgspd_mult = max(1,2.16*_tnt_power);
					}
		
					var spr = asset_get_index("spr_lode_plr_"+_anim);
					if(sprite_exists(spr)){
						sprite_index = spr;
					}
					image_speed = _animspeed*_imgspd_mult*global._lode_spd;
			
					//input and speed
					if(_groundtimer > 0){
						var goleft = true;
						var goright = true;
			
						if(_plstate == LODE_STATE_LADDER){
							if(place_meeting_array(x-2,y,global._lode_collide_solid)){
								goleft = false;
							}
							if(place_meeting_array(x+2,y,global._lode_collide_solid)){
								goright = false;
							}
						}
			
						if((!keyhold("left") && !keyhold("right")) || (keyhold("left") && keyhold("right"))){
							_xspd = 0;
					
							_holdL = false;
							_holdR = false;
						} else if(keyhold("left")){
							if(goleft){
								_xspd = -_movespd;
								_yspd = 0;
					
								_curdir = DIR_L;
						
								_holdL = true;
								_holdR = false;
							}
						} else if(keyhold("right")){
							if(goright){
								_xspd = _movespd;
								_yspd = 0;
					
								_curdir = DIR_R;
						
								_holdL = false;
								_holdR = true;
							}
						}
					} else {
						_xspd = 0;
					}
		
					_fallspd = max(1,_movespd*1.25);
		
					if(_plstate == LODE_STATE_DIG && _jump_power > 0){
						_plstate = LODE_STATE_DEFAULT;
						_digtime = 0;
						_digbox._active = 0;
					}
		
					if(_plstate == LODE_STATE_DEFAULT || _plstate == LODE_STATE_ROPE){
						//ladder interaction
						if((keyhold("down") || keyhold("menu_down")) && place_meeting(x,y+(global._lode_tilesize*0.5),obj_lode_ladder)){
							if(_plstate == LODE_STATE_ROPE){
								_rope_cd = 30;
							}
							var inst = instance_place(x,y+(global._lode_tilesize*0.5),obj_lode_ladder);
							if(instance_exists(inst)){
								var ladderx = inst.x+(global._lode_tilesize*0.5);
								if(!place_meeting_array(ladderx,y+(global._lode_tilesize*0.5),global._lode_collide_solid)){
									_xspd = 0;
									x = inst.x+(global._lode_tilesize*0.5);
									y += _yspd;
									_plstate = LODE_STATE_LADDER;
								}
							}
						}
						if((keyhold("up") || keyhold("menu_up")) && place_meeting(x,y,obj_lode_ladder)){
							if(_plstate == LODE_STATE_ROPE){
								_rope_cd = 30;
							}
							
							var inst = instance_place(x,y,obj_lode_ladder);
							if(instance_exists(inst)){
								_xspd = 0;
								x = inst.x+(global._lode_tilesize*0.5);
								y -= _yspd;
								_plstate = LODE_STATE_LADDER;
							}
						}
					}
		
					switch(_plstate){
						case LODE_STATE_DEFAULT:
							if(_jump_power <= 0){
								_yspd = _fallspd;
							} else {
								_jump_ptimer ++;
								if(_jump_ptimer >= 9){
									var p = instance_create_depth(x,y,0,obj_particle);
									p._lode_particle = true;
									p._type = "lode_break";
									p._move = true;
									p._xspd = random_range(-1,1);
									p._yspd = random_range(1,1.8);
							
									_jump_ptimer = 0;
								}
						
								_jump_power --;
								var factor = 2;
								if(_jump_power < 16){
									factor = 1;
								}
								if(_jump_power < 8){
									factor = 0.5;
								}
								_yspd = -(_fallspd*factor);
							}
							
							//digging
							if(_groundtimer > 0 && _jump_power <= 0 && (keyhold(_input_digleft) || keyhold(_input_digright))){
								if(keyhold(_input_digleft)){
									_digdir = DIR_L;
								} else if(keyhold(_input_digright)){
									_digdir = DIR_R;
								}
								if(_digbox_cur != noone && instance_exists(_digbox_cur)){
									_digbox_cur._visibtimer = 2;
								}
							}
							if(_groundtimer > 0 && _jump_power <= 0 && ((_digdir == DIR_R && keyrelease(_input_digright)) || (_digdir == DIR_L && keyrelease(_input_digleft)))){
								do_dig();
							}
						break;
						case LODE_STATE_LADDER:
							_groundtimer = 2;
							_yspd = 0;
							_ladder_coyotetime = _ladder_coyotetime_max;
			
							var goleft = false;
							var goright = false;
							if(keyhold("left")){
								if(!place_meeting_array(x-sprite_width,y,global._lode_collide_solid)){
									_xspd = -_movespd;
									_yspd = 0;
									goleft = true;
								}
							} else if(keyhold("right")){
								if(!place_meeting_array(x+sprite_width,y,global._lode_collide_solid)){
									_xspd = _movespd;
									_yspd = 0;
									goright = true;
								}
							}
			
							if((!keyhold("up") && !keyhold("down")) || (keyhold("up") && keyhold("down"))){
								_yspd = 0;
							} else if(keyhold("up")){
								if(!goleft){
									_xspd = 0;
									_yspd = -_movespd;
									var inst = instance_place(x,y,obj_lode_ladder);
									if(instance_exists(inst)){
										x = inst.x+(global._lode_tilesize*0.5);
									}
								}
							} else if(keyhold("down")){
								if(!goright){
									_xspd = 0;
									_yspd = _movespd;
									var inst = instance_place(x,y,obj_lode_ladder);
									if(instance_exists(inst)){
										x = inst.x+(global._lode_tilesize*0.5);
									}
								}
							}
				
							//digging
							if(keyhold(_input_digleft) || keyhold(_input_digright)){
								if(keyhold(_input_digleft)){
									_digdir = DIR_L;
								} else if(keyhold(_input_digright)){
									_digdir = DIR_R;
								}
								if(_digbox_cur != noone && instance_exists(_digbox_cur)){
									_digbox_cur._visibtimer = 2;
								}
							}
							if((_digdir == DIR_R && keyrelease(_input_digright)) || (_digdir == DIR_L && keyrelease(_input_digleft))){
								do_dig();
							}
						break;
						case LODE_STATE_ROPE:
							_groundtimer = 2;
							_yspd = 0;
				
							if(keypress("down")){
								_ground_particle_inactive = 4;
								_plstate = LODE_STATE_DEFAULT;
								_rope_cd = 16*global._lode_spd;
							}
				
							//digging
							if(keyhold(_input_digleft) || keyhold(_input_digright)){
								if(keyhold(_input_digleft)){
									_digdir = DIR_L;
								} else if(keyhold(_input_digright)){
									_digdir = DIR_R;
								}
								if(_digbox_cur != noone && instance_exists(_digbox_cur)){
									_digbox_cur._visibtimer = 2;
								}
							}
							if((_digdir == DIR_R && keyrelease(_input_digright)) || (_digdir == DIR_L && keyrelease(_input_digleft))){
								do_dig();
							}
						break;
						case LODE_STATE_DIG:
							_xspd = 0;
							_yspd = 0;
							_curdir = _state_storedir;
							x = _state_storepos[0];
							y = _state_storepos[1];
				
							_digtime += global._lode_spd;
							if(_digtime >= 18){
								_ground_particle_inactive = 4;
								_plstate = _store_plstate;
							}
						break;
					}
		
					//general interaction
					if(place_meeting(x,y,obj_lode_collect)){
						var inst = instance_place(x,y,obj_lode_collect);
						if(instance_exists(inst) && inst._checkdelete && inst._project){
							if(global._stage_layout[0][inst._tilepos[0]][inst._tilepos[1]] == LTILE_COL){
								global._stage_layout[0][inst._tilepos[0]][inst._tilepos[1]] = LTILE_AIR;
							}
							if(global._stage_layout[1][inst._tilepos[0]][inst._tilepos[1]] == LTILE_COL){
								global._stage_layout[1][inst._tilepos[0]][inst._tilepos[1]] = LTILE_AIR;
							}
				
							global._lode_collect_cur ++;
				
							var p = instance_create_depth(inst.x,inst.y,0,obj_particle);
							p._type = "lode_collect";
							p._lode_particle = true;
				
							global._lode_deletedStuff[? inst._id] = 1;
				
							global._lode_score += global._lode_score_add.monyx*global._lode_collect_combo;
							var scoreobj = instance_create_depth(x,y-global._lode_tilesize,0,obj_lode_score);
							scoreobj._score = global._lode_score_add.monyx*global._lode_collect_combo;
							
							global._lode_collect_combo += 1;
							global._lode_collect_combo_timer = 240;
							
							if(_tnt_power <= 0){
								global._lode_tnt += 1.3;
							}
							
							global._pad_vibrate = 3;
							
							sfx_play(snd_lode_monyx);
				
							instance_destroy(inst.id);
						}
					}
					if(place_meeting(x,y+8,obj_lode_spring)){
						var inst = instance_place(x,y+8,obj_lode_spring);
						if(instance_exists(inst)){
							if(!inst._trigger && diff_abs(x,(inst.x+global._lode_tilesize*0.5))<=global._lode_tilesize*0.4){
								inst._trigger = true;
							}
							if(inst._launch){
								var p = instance_create_depth(x,y-16,0,obj_particle);
								p._lode_particle = true;
								p._type = "lode_jump";
						
								y = (inst.y-global._lode_tilesize)-2;
								x = inst.x+(global._lode_tilesize*0.5);
								_jump_ptimer = 99;
								_yspd = -2;
								_jump_power = inst._jump_power*(global._lode_tilesize/(_fallspd*2.3));
							}
						}
					}
			
					_move_mult = 1;
					if(place_meeting(x,y,obj_lode_river)){
						_river_timer ++;
						if(abs(_xspd) >= _movespd && abs(_yspd) >= _movespd && _river_timer >= 12){
							var p = instance_create_depth(x,y-(sprite_height*0.5),0,obj_particle);
							p._lode_particle = true;
							p._type = "lode_river";
					
							if(!sfx_isplaying(snd_lode_rivermove)){
								sfx_play(snd_lode_rivermove);
							}
					
							_river_timer = 0;
						}
						_move_mult = 0.5;
					} else {
						_river_timer = 99;
					}
					if(_pushtimer > 0){
						_move_mult = 0.4;
					}
					
					if(_tnt_power > 0){
						_move_mult = max(_movespd_init,1.8*_tnt_power);
					}
					
					if(place_meeting(x,y,obj_lode_exit)){
						var inst = instance_place(x,y,obj_lode_exit);
						if(instance_exists(inst) && inst._open){
							if(!inst._has_key){
								sprite_index = spr_lode_plr_win;
								image_index = 0;
							
								inst._stage_exit = true;
							
								_tnt_power = 0;
							
								_winpos = [inst.x,inst.y];
								_win = true;
							
								with(obj_lode_soulboss){
									_stopsnd = true;
								}
							
								sfx_play(snd_mg_result2);
							
								var amnt = 75;
							
								_wintimer = amnt+20;
								inst._exit_timer = amnt;
							} else {
								//find the key object
								if(inst._locked && _got_key){
									var p = instance_create_depth(inst.x,inst.y-(inst.sprite_height*0.5),0,obj_particle);
									p._lode_particle = true;
									p._type = "lode_block";
										
									inst._has_key = false;
									inst._locked_spr = -1;
										
									var p = instance_create_depth(inst.x,inst.y-(inst.sprite_height*0.5),0,obj_particle);
									p._lode_particle = true;
									p._type = "lode_skull";
									p._frameend = false;
									p._move = true;
									p._do_grav = true;
									p._grav_val = 0.25;
									p._xspd = -_curdir*3;
									p._yspd = -6;
									p._rotate = true;
									p._rotate_spd = -5;
										
									_got_key = false;
										
									with(obj_lode_key){
										if(_followobj != noone){
											_show = false;
											_project = false;
											_followobj = noone;
										}
									}
								}
							}
						}
					}
					
					if(place_meeting(x,y,obj_lode_key)){
						var inst = instance_place(x,y,obj_lode_key);
						if(instance_exists(inst) && inst._show && inst._followobj == noone){
							var p = instance_create_depth(inst.x,inst.y,0,obj_particle);
							p._type = "lode_collect";
							p._lode_particle = true;
							
							sfx_play(snd_mg_result2);
							sfx_play(snd_mg_bonus);
							
							global._pad_vibrate = 4;
							
							_got_key = true;
							inst._followobj = self;
						}
					}
					
					if(place_meeting(x,y,obj_lode_skulls)){
						var inst = instance_place(x,y,obj_lode_skulls);
						if(instance_exists(inst) && inst._show && inst._active){
							if(global._stage_layout[0][inst._tilepos[0]][inst._tilepos[1]] == LTILE_SKL){
								global._stage_layout[0][inst._tilepos[0]][inst._tilepos[1]] = global._stage_layout_bg[inst._tilepos[0]][inst._tilepos[1]];
							}
							if(global._stage_layout[1][inst._tilepos[0]][inst._tilepos[1]] == LTILE_SKL){
								global._stage_layout[1][inst._tilepos[0]][inst._tilepos[1]] = LTILE_AIR;
							}
				
							var p = instance_create_depth(inst.x,inst.y,0,obj_particle);
							p._type = "lode_skulls";
							p._lode_particle = true;
				
							global._lode_score += global._lode_score_add.skull;
							var scoreobj = instance_create_depth(x,y-global._lode_tilesize,0,obj_lode_score);
							scoreobj._score = global._lode_score_add.skull;
	
							if(_tnt_power <= 0){
								global._lode_tnt += 0.7;
							}
							
							global._pad_vibrate = 3;
							
							sfx_play(snd_lode_skulls);
							sfx_pitch(snd_lode_skulls,random_range(0.92,1.15));
				
							inst._show = false;
							inst._active = false;
							inst._project = false;
						}
					}
					if(place_meeting(x,y,obj_lode_oneup)){
						var inst = instance_place(x,y,obj_lode_oneup);
						if(instance_exists(inst) && inst._show && inst._active){
							if(global._stage_layout[0][inst._tilepos[0]][inst._tilepos[1]] == LTILE_1UP){
								global._stage_layout[0][inst._tilepos[0]][inst._tilepos[1]] = global._stage_layout_bg[inst._tilepos[0]][inst._tilepos[1]];
							}
							if(global._stage_layout[1][inst._tilepos[0]][inst._tilepos[1]] == LTILE_1UP){
								global._stage_layout[1][inst._tilepos[0]][inst._tilepos[1]] = LTILE_AIR;
							}
				
							var p = instance_create_depth(inst.x,inst.y,0,obj_particle);
							p._type = "lode_collect";
							p._lode_particle = true;
				
							global._lode_lives ++;
				
							global._pad_vibrate = 3;
				
							var scoreobj = instance_create_depth(x,y-global._lode_tilesize,0,obj_lode_score);
							scoreobj._score = 0;
							scoreobj._text = "ONE UP!"
							
							sfx_play(snd_mg_item);
							sfx_play(snd_lode_dialm_oneup);
				
							inst._show = false;
							inst._active = false;
							inst._project = false;
						}
					}
					
					//boss interaction
					if(_freeze <= 0){
						_boss_init_timer ++;
						if(_boss_init_timer >= 8 && instance_number(obj_lode_soulboss) > 0){
							if(!_boss_warning){
								with(obj_mg_lode){
									_scr_shake_y = 16;
								}
							
								_backoff = 48;
								_backoff_pos = [x+24,y];
							
								with(obj_mg_lode){
									_exit_type = 2;
									_exit_trigger = true;
						
									_exit_spacing = 48;
									_exit_timer = 0;
									_exit_act = 0;
			
									_exit_bottomy = _disp_dim[1]+sprite_get_height(spr_lode_gui_bottom);
									_exit_bottomalp = 0;
								}
							
								_boss_warning = true;
							} else {
								_boss_timer ++;
								if(_boss_timer >= 90){
									var bossdist = (x-obj_lode_soulboss.x)-500;
									_boss_shakeamp = (1-(bossdist/global._lode_disp_dim[0]));
									with(obj_mg_lode){
										_scr_shake_y = clamp(other._boss_shakeamp*8,0,18);
									}
									with(obj_lode_soulboss){
										_vol = other._boss_shakeamp;
									}
								}
							}
						
							var boss = instance_find(obj_lode_soulboss,0);
							if(instance_exists(boss)){
								if(x - boss.x <= 500){
									if(_hurtbox != noone && instance_exists(_hurtbox)){
										_hurtbox._hurttimer = 2;
									}
									boss._stop = true;
									boss._stopsnd = true;
									_tnt_power = 0;
								}
							}
						}
					}
		
					if(place_meeting(x,y+4,obj_lode_ladder)){
						_ladder_coyotetime = _ladder_coyotetime_max;
					}
					if(_ladder_coyotetime > 0){
						_ladder_coyotetime --;
						if(_plstate != LODE_STATE_LADDER){
							_yspd = 0;
							_groundtimer = 2;
						}
					}
		
					//collision and movement
					_frac_x = frac(_xspd*global._lode_spd);
					_frac_y = frac(_yspd*global._lode_spd);
		
					//x speed
					var amntx = _xspd*global._lode_spd;
					if(_xspd > 0){
						amntx = floor(_xspd*global._lode_spd);
					} else {
						amntx = ceil(_xspd*global._lode_spd);
					}
					
					repeat(abs(amntx)){
						_go_x = true;
						var pixel = sign(_xspd*global._lode_spd);
			
						checkcol(pixel, COL_X);
			
						if(_go_x){
							x += pixel;
						} else {
							_xspd = 0;
						}
					}
		
					//x fraction
					if(_frac_x <> 0){
						_go_x = true;
						var pixel = _frac_x;
			
						checkcol(pixel, COL_X);
			
						if(_go_x){
							x += pixel;
						} else {
							_xspd = 0;
						}
					}
		
					//y speed
					var amnty = _yspd*global._lode_spd;
					if(_yspd > 0){
						amnty = floor(_yspd*global._lode_spd);
					} else {
						amnty = ceil(_yspd*global._lode_spd);
					}
					
					repeat(abs(amnty)){
						_go_y = true;
						var pixel = sign(_yspd*global._lode_spd);
			
						checkcol(pixel, COL_Y);
			
						if(_go_y){
							y += pixel;
						} else {
							if(_yspd > 0){
								_groundtimer = 2;
							}
							_yspd = 0;
						}
					}
		
					//y fraction
					if(_frac_y <> 0){
						_go_y = true;
						var pixel = _frac_y;
			
						checkcol(pixel, COL_Y);
			
						if(_go_y){
							y += pixel;
						} else {
							if(_yspd > 0){
								_groundtimer = 2;
							}
							_yspd = 0;
						}
					}
		
					//death
					if(!global._freeRoam && _hurtbox != noone && instance_exists(_hurtbox)){
						if(_hurtbox._hurttimer > 0){
							_hurtbox._hurttimer = 0;
							with(obj_mg_lode){
								_scr_shake_x = 10;
								_scr_shake_y = 10;
							}
							if(_hurt_inst != noone && instance_exists(_hurt_inst)){
								_hurt_inst._freeze = 30;
								_hurt_inst = noone;
							}
							_freeze = 30;
							
							if(!global._minigame_nopause){
								global._minigame_nopause = true;
							}
							
							if(global._lode_playmode){
								global._lode_lives --;
							}
							
							global._pad_vibrate = 12;
							
							global._lode_score -= global._lode_score_sub.death;
							var scoreobj = instance_create_depth(x,y-global._lode_tilesize,0,obj_lode_score);
							scoreobj._score = -global._lode_score_sub.death;
							
							sfx_stop_array([snd_lode_dialm_start1,snd_lode_dialm_start2,snd_lode_dialm_start3,snd_lode_dialm_start4]);
							
							sfx_play(snd_lode_ko);
							sfx_play(snd_lode_dialm_death1);
							
							sprite_index = spr_lode_plr_dead1;
							_death = true;
						}
					}
		
					if(_groundtimer > 0 && (abs(_xspd) >= _movespd || abs(_yspd) >= _movespd)){
						if(!sfx_isplaying(snd_lode_move)){
							sfx_play(snd_lode_move);
							var pitchmult = 1;
							if(_tnt_power > 0){
								pitchmult = max(1,1.6*_tnt_power);
							}
							sfx_pitch(snd_lode_move,random_range(0.95,1.06)*pitchmult);
						}
					} else {
						sfx_stop(snd_lode_move);
					}
		
					//other
					
					if(_groundtimer > 0){
						_groundtimer -= 1;
						
						if(_ground_particle_inactive <= 0 && _plstate == LODE_STATE_DEFAULT && !_ground_particle){
							var p = instance_create_depth(x,y,0,obj_particle);
							p._type = "lode_land";
							p._lode_particle = true;
					
							sfx_play(snd_lode_land);
					
							_ground_particle = true;
						}
					} else {
						_ground_particle = false;
					}
					if(_rope_cd > 0){
						_rope_cd -= global._lode_spd;
					}
			
					if(_ground_particle_inactive > 0){
						_ground_particle = true;
						_ground_particle_inactive --;
					}
			
					if(_successdig > 0){
						_successdig --;
					}
					
					if(_pushtimer > 0){
						_pushtimer --;
					}
					
					var th = 7;
					
					//enemy stuck clip fix fucking
					if(place_meeting(x,y+th,obj_lode_enmwall)){
						var enm = instance_place(x,y+th,obj_lode_enmwall);
						if(instance_exists(enm)){
							if(y < enm.y+th){
								repeat(global._lode_tilesize){
									y -= 1;
									if(!place_meeting(x,y,enm)){
										break;
									}
								}
								_yspd = 0;
								_groundtimer = 3;
							}
						}
					}
					
					//tnt quake
					if(_tnt_power <= 0 && global._lode_tnt >= global._lode_tntmax){
						if(keyhold("tnt")){
							global._lode_tnt_hold += 0.06;
							if(global._lode_tnt_hold > 1){
								_tnt_blend_amnt = 0;
								_tnt_activation_timer = 0;
								_tnt_activation = true;
								
								global._pad_vibrate = 10;
								
								sfx_play(snd_mg_tnt);
								
								image_index = 0;
								global._lode_tnt = 0;
								global._lode_tnt_hold = 1;
							}
							global._lode_tnt_hold_timer = 2;
						}
					}
		
					_movespd = _movespd_init*_move_mult;
		
					_frac_x = 0;
					_frac_y = 0;
		
					//sprite offset
					_offset = [0,0];
					if(_shakeamp > 0){
						_offset[0] = sin(random(480))*_shakeamp;
						_shakeamp -= 0.3;
					} else {
						_shakeamp = 0;
					}
		
					_tilepos[1] = round((x-(global._lode_tilesize*0.5))/global._lode_tilesize);
					_tilepos[0] = round((y-global._lode_tilesize)/global._lode_tilesize);
				} else {
					//dead dead
					_death_timer += global._lode_spd;
					switch(_death_act){
						case 0:
							sprite_index = spr_lode_plr_dead1;
							if(_death_timer >= 20){
								var deadplr = instance_create_depth(x,y,0,obj_lode_plr_dead);
								deadplr._curdir = -_curdir;
								deadplr._xspd = 1.35;
								deadplr._yspd = -4;
								
								sfx_play(snd_lode_dialm_death2);
								
								_death_act = 1;
								_death_timer = 0;
							}
						break;
					}
				}
			} else {
				image_speed = 0;
				_freeze --;
			}
		} else {
			if(!_win){
				if(_backoff > 0){
					sprite_index = spr_lode_plr_idle;
					
					sprite_index = spr_lode_plr_dead1;
					
					if(x < _backoff_pos[0]){
						_curdir = DIR_L;
						_xscale = _curdir;
					} else if(x > _backoff_pos[0]){
						_curdir = DIR_R;
						_xscale = _curdir;
					}
					
					_offset[1] = sin(random(480))*(_backoff*0.22);
					
					x = lerp(x,_backoff_pos[0],0.07);
					y = lerp(y,_backoff_pos[1],0.07);
					
					_backoff_init = true;
					_backoff --;
				}
				
				if(_tnt_activation){
					_tnt_activation_timer ++;
					if(_tnt_activation_timer >= 60){
						sfx_play(snd_mg_fireend);
						_tnt_snd = false;
						_tnt_power = 1;
						_tnt_activation = false;
					} else {
						with(obj_mg_lode){
							_scr_shake_y = 3;
						}
					
						_prev_anim = _anim;
						_anim = "tnt";
						sprite_index = spr_lode_plr_tnt;
					
						if(image_index >= 3 && !_tnt_snd){
							sfx_play(snd_lode_dialm_death2);
							_tnt_snd = true;
						}
					
						if(image_index >= sprite_get_info(spr_lode_plr_tnt).num_subimages-1){
							image_index = sprite_get_info(spr_lode_plr_tnt).num_subimages-3;
						}
					
						_tnt_blend_amnt += 0.014;
						if(_tnt_blend_amnt > 1){
							_tnt_blend_amnt = 1;
						}
					
						_blend = merge_colour(c_white,global._lode_tnt_blend,_tnt_blend_amnt);
					}
				}
			} else {
				_depth = -2;
				_wintimer --;
				if(_wintimer <= 0){
					_show = false;
				}
				
				if(_wintimer <= 60 && !_winsnd){
					sfx_play_choose([snd_lode_dialm_end1,snd_lode_dialm_end2,snd_lode_dialm_end3,snd_lode_dialm_end4]);
					
					_winsnd = true;
				}
				
				x = lerp(x,_winpos[0],0.06);
				y = lerp(y,_winpos[1],0.06);
				
				sprite_index = spr_lode_plr_win;
				if(image_index >= image_number-1){
					image_index = image_number-3;
				}
				
				with(obj_lode_soulboss){
					_spd = lerp(_spd,0,0.12);
				}
			}
		}
		
		//make fire particles
		if(_tnt_activation || _tnt_power > 0){
			_tnt_particle_timer ++;
			var time = random_range(7,17);
			var range = irandom_range(1,4);
			if(_tnt_power > 0){
				if(_tnt_power <= 0.22){
					time = random_range(22,35);
					range = irandom_range(1,3);
				}
				if(_tnt_power <= 0.1){
					time = random_range(50,75);
					range = 1;
				}
			}
			if(_tnt_particle_timer >= time){
				var p_array = [];
				for(var i = 0; i < range; i++){
					p_array[i] = instance_create_depth(x+random_range(-8,8),y+random_range(0,-12),0,obj_particle);
					p_array[i]._depth = 1;
					p_array[i]._lode_particle = true;
					p_array[i]._type = "lode_fire";
					p_array[i]._move = true;
					p_array[i]._xspd = random_range(-0.65,-1.2)*choose(1,-1);
					p_array[i]._yspd = random_range(-0.65,-1.2)*choose(1,-1);
				}
				
				_tnt_particle_timer = 0;
			}
			
			if(floor((_tnt_power*100)%3) == 0){
				if(global._pad_vibrate < 1){
					global._pad_vibrate = 1;
				}
			}
		} else {
			_tnt_particle_timer = 0;
		}
		
		if(_tnt_power > 0){
			_tnt_power_init = true;
			_blend = merge_colour(c_white,global._lode_tnt_blend,_tnt_power);
			_tnt_power -= 0.0021;
		} else {
			if(_tnt_power_init){
				var p = instance_create_depth(x-3,y-(sprite_height*0.5),0,obj_particle);
				p._lode_particle = true;
				p._type = "lode_block";
				
				with(_fire){
					_show = false;
				}
				
				_blend = c_white;
				_tnt_power_init = false
			}
		}
		
		if(global._lode_editor){
			sprite_index = spr_lode_plr_idle;
		}
		mask_index = spr_lode_plr_mask;

		scr_lode_overtile();
		
		//debug
		if(!global._lode_editor && global._debug){
			if(keyboard_check(ord("T"))){
				//tnt juice
				global._lode_tnt += 3;
			}
			
			if(global._freeRoam){
				//free roam mode
				if(keyboard_check(vk_left)){
					x -= 2;
				} else if(keyboard_check(vk_right)){
					x += 2;
				}
			
				if(keyboard_check(vk_up)){
					y -= 2;
				} else if(keyboard_check(vk_down)){
					y += 2;
				}
			}
			
			if(keyboard_check_pressed(ord("M"))){
				global._lode_collect_cur = global._lode_collect_max;
			}
			if(keyboard_check_pressed(ord("L"))){
				sfx_play(snd_comic_advance);
				global._lode_curloop ++;
				room_restart();
			}
		}
		
		if(_death_act < 1){
			scr_lode_project(sprite_index,image_index,[x+_offset[0],y+_offset[1]],[_xscale,image_yscale],_depth,0,_blend);
		} else {
			with(obj_mg_lode){
				if(ds_map_exists(_project, other._id)){
					ds_map_delete(_project, other._id);
				}
			}
		}
	} else {
		image_speed = 0;
	}
}