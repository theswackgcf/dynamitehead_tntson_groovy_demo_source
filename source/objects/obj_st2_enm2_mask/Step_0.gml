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
					if(_spawndir == "c"){
						_sequence_id = seq_st2_enm2_entC;
					} else {
						_sequence_id = seq_st2_enm2_entH;
					}
				}
			}
			
			//alt behavior
			if(_enmtype == 0){
				//red cap
				_movespd[? SPD_WALK] = 5;
				_movespd[? SPD_BACK] = 5;
				_movespd[? SPD_PANIC] = 9;
				
				_stunrange = [90, 190];
			}
			
			if(_enmtype == 1){
				//milkman
				_movespd[? SPD_WALK] = 7;
				_movespd[? SPD_BACK] = 4;
				_movespd[? SPD_PANIC] = 9;
				_movespd[? SPD_FALL] = 9;
							
				_stunrange = [50, 100];
				
				_slidespd_max = 35;
				_slidedecel_max = 0.1;
			}
			
			scr_enemyscript_init("step");
		} else {
			_startTimer --;
			if(!_idiot && _startTimer <= 0){
				if(!_sequence_finished){
					scr_enemyscript_startsequence();
				} else {
					if(_freeze <= 0){
						switch(_yolob_atkstate){
							case YOLOB_ATK_NONE:
								scr_enemyscript_behavior("");
							
								_movetimer ++;
						
								scr_enemyscript_spd();
					
								if(_hurttimer == 0 && _dodgetimer == 0){
									switch(_behaviortype){
										case "move":
											if(_curstate == STATE_WALK){
												scr_enemyscript_behavior("walk");
											} else {
												_randoffset = [random_range(-_walkdist[0],_walkdist[0]),random_range(-_walkdist[1],_walkdist[1])];
												_multdist = 1;
											}
											if(_curstate == STATE_FOLLOW && !_yolob_milk){
												scr_enemyscript_behavior("follow");
											}
										break;
										case "attack":
											if(!_yolob_milk){
												scr_enemyscript_behavior("attack");
											}
										break;
									}
								}
					
								if(!_death){
									scr_enemyscript_behavior("battlezone");
									scr_enemyscript_behavior("grab");
							
									_grabhp = false;
							
									if(_stuntimer > 0){
										_grabhp = true;
									}
							
									//dodge sound
									if(_anim == "hop" && _dodge_snd){
										sfx_play_proximity(snd_yolo_dodge1);
										sfx_pitch(snd_yolo_dodge1, random_range(1.1,1.45))
										
										_dodge_snd = false;
									}
							
									//stuns
							
									if(!_falling && _grabbed && _stuntimer == 0 && !_fall_ko){
										_grabdodge = true;
										if(_dh != noone && instance_exists(_dh)){
											with(_dh){
												force_throw_enemy();
											}
										}
										sfx_play_choose_proximity(global._swishsounds[1]);
									}
						
									if(_grabbed && _stuntimer > 0){
										_stun = false;
										_stunact = 0;
										_stuntimer = 1;
									}
						
									if(_forcehop && _immunetimer <= 0){
										//hop to the spot and then lowkick
										scr_hopspot(HOP_LOWKICK);
								
										if(scr_enemyscript_calculatejump(0)){
											_hopslide = true;
											
											_dohop = true;
											_dodges = 0;
											
											_atkallowed = [ATK_NORM,ATK_KO];
											
											_forcehop = false;
											_slidetimer = 0;
										}
									}
						
									//trait removal/addition
									if(_curstate == STATE_SLIDE){
										if(has_trait(TRAIT_GRAB)){
											remove_trait(TRAIT_GRAB);
										}
										if(has_trait(TRAIT_DODGE)){
											remove_trait(TRAIT_DODGE);
										}
									} else {
										if(!has_trait(TRAIT_GRAB)){
											add_trait(TRAIT_GRAB);
										}
										if(!has_trait(TRAIT_DODGE)){
											add_trait(TRAIT_DODGE);
										}
									}
							
									if(_falling || _fall_ko){
										if(has_trait(TRAIT_HOP) || has_trait(TRAIT_LOWKICK)){
											remove_trait([TRAIT_HOP, TRAIT_LOWKICK]);
										}
									} else {
										if(!has_trait(TRAIT_HOP) || !has_trait(TRAIT_LOWKICK)){
											add_trait([TRAIT_HOP, TRAIT_LOWKICK]);
										}
									}
							
									if(_curstate == STATE_IDLE && _anim == "dead"){
										if(has_trait(TRAIT_DODGE)){
											remove_trait(TRAIT_DODGE);
										}
									} else {
										if(!has_trait(TRAIT_DODGE)){
											add_trait(TRAIT_DODGE);
										}
									}
								}
						
								scr_enemyscript_falling();
								
								if(!_death){
									//end attacking
									if(_attack){
										switch(_attacktype){
											case "idle":
												if(!_yolob_milk){
													if(_yolob_kickdir == 0){
														_yolob_kickdir = _curdir;
													} else {
														_curdir = _yolob_kickdir;
													}
									
													if(_curstate == STATE_JUMP){
														_attack = false;
														_yolob_timer = 0;
														_yolob_kick = false;
													}
								
													_jumpingtimer = 0;
													_yolob_timer ++;
													if(!_yolob_kick && _anim != "standup" && _behaviortype != "hopping"){
														if(_displayobj.image_index >= _displayobj.image_number-1){
															_displayobj.image_index = _displayobj.image_number-2;
														}
										
														if(_yolob_timer >= scr_ailevel(16,30)){
															//kick
															_displayobj.image_index = 0;
											
															var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
															atk._parentobj = self.id;
															atk._ptype = "enm";
															atk._scale = [12, 3];
															atk._offset = [150,-60];
															atk._timer = 9;
															atk._damage = ATK_KO;
											
															_afterim_active = 60;
											
															sfx_play_choose_proximity(global._swishsounds[0]);
											
															_yolob_kick = true;
														}
													} else {
														if(_displayobj.image_index >= _displayobj.image_number-1){
															_yolob_kickdir = 0;
															_attack = false;
														}
													}
												}
											break;
										}
									} else {
										_yolob_kickdir = 0;
										_yolob_kick = false;
										_yolob_timer = 0;
									}
							
									//milk gimmick
									_yolob_addtimer = true;
							
									if(_yolob_milk && _attack){
										_attack = false;
									}
									if(_yolob_milk && _taunt > 0){
										_taunt = 0;
									}
									if(_yolob_milk && _curstate == STATE_JUMP){
										_jumpingtimer = 0;
										_curstate = STATE_IDLE;
									}
									if(_falling){
										add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED]);
										_yolob_milk = false;
										_yolob_addtimer = false;
										_yolob_milkact = 0;
									}
									if(_shockwave || _grabbed){
										add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED]);
										_yolob_milk = false;
										_yolob_milktimer = 0;
										_yolob_milkact = 0;
										_yolob_heal = false;
									}
									
									//red cap
									if(_enmtype == 0){
										if(_fall_ko){
											_stuntimer = scr_ailevel(50,120);
										} else {
											_stuntimer = 0;
										}
										if(_standup){
											_stuntimer = 0;
										}
									}
									
									//milkman
									if(_enmtype == 1){
										if(_alt_tutorial && !_milksign){
											instance_create_depth(x-470,y-75,depth,obj_st2_milkpunch);
											_milksign = true;
										}
										
										if(_anim == "idle" || _anim == "walk" || _successparry > 0 || _attack){
											_yolob_kicked = false;
											_yolob_kicked_init = false;
											
											_block_endzones = _block_endzones_start;
											_dodgezones = _dodgezones_start;
											_atkallowed = [ATK_NORM,ATK_KO];
											_immunetimer = 0;
											
											add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED,TRAIT_DODGE]);
										}
										
										if(_successparry > 0 && !_yolob_milkstun){
											//set proper stun when parried
											_attack = false;
											_attacktype = "";
						
											_yolob_milk = false;
											_yolob_milkact = 0;
											_yolob_milktimer = 0;
											_yolob_heal = false;
						
											_yolob_milkstun = true;
											_yolob_milkhits = 0;
											_yolob_milkstun_inactive = 0;
										}
										
										if(_mashed || _shockwave > 0){
											//stop attack when being mashed or quaked
											_yolob_milkstun = false;
											_successparry = 0;
											_yolob_atkcooldown = 999;
											_yolob_subhp = true;
											_yolob_hit = true;
											_yolob_milk = true;
											_yolob_stopheal = true;
										}
										
										if(_stuntimer > 0 || _curstate == STATE_SLIDE){
											
											_yolob_milktimer = 999;
										}
										
										if(_stuntimer > 0 && _successparry <= 0){
											_stuntimer = 0;
										}
										
										if(_yolob_milkstun && _successparry <= 0){
											_successparry = 60;
										}
										
										if(_yolob_milkstun){
											_yolob_hit = true;
											
											_yolob_milkstun_inactive ++;
											
											if(_hurttimer > 0){
												_yolob_milkhits ++;
												_yolob_milkstun_inactive = 0;
												_hurttimer = 0;
											}
											
											var inactivemax = 200;
											if(_total_ailevel >= 3){
												inactivemax = 180;
											}
											if(_total_ailevel >= 5){
												inactivemax = 135;
											}
											if(_total_ailevel >= 7){
												inactivemax = 90;
											}
											if(_total_ailevel >= 9){
												inactivemax = 60;
											}
											
											if(_alt_tutorial){
												_yolob_milkstun_inactive = 0;
												_yolob_milkhits = 0;
											}
											
											//stop stun
											if(_yolob_milkstun_inactive >= inactivemax || _yolob_milkhits >= 4){
												_yolob_atkcooldown = 120;
												_yolob_milkstun = false;
												_successparry = 0;
											}
										}
										if(_yolob_atkcooldown > 0){
											_yolob_atkcooldown --;
										}
										
										if(_successparry > 0){
											_dodgezones = [];
											_yolob_parry = true;
										} else {
											if(_yolob_parry){
												_dodgezones = _dodgezones_start;
												_yolob_parry = false;
											}
										}
										
										if(!_mashed && _shockwave <= 0 && !_yolob_subhp){
											if(!_yolob_stopheal){
												_hp = _maxhp-4;
											}
											
											if(_alt_tutorial){
												_yolob_sol = instance_create_depth(x-200,y-200,depth,obj_solid);
												_yolob_sol._collidewith = "enemy";
												_yolob_sol.image_xscale = 8;
												_yolob_sol.image_yscale = 8;
												remove_trait(TRAIT_LOWKICK);
											}
											
											_yolob_subhp = true;
										}
										
										//milkman tutorial
										if(_alt_tutorial){
											x = _yolob_pos[0];
											y = _yolob_pos[1];
											if(_falling || _standup){
												_yolob_hit = false;
												_yolob_milk = false;
											}
											remove_trait([TRAIT_GRAB]);
											
											if(_mashed || _shockwave > 0){
												if(_yolob_sol != noone && instance_exists(_yolob_sol)){
													_alt_tutorial = false;
													instance_destroy(_yolob_sol.id);
												}
											}
											
											if(!_mashed && _shockwave <= 0 && _yolob_subhp){
												if(!_yolob_stopheal && !_yolob_hit && !_yolob_milk && instance_number(obj_st2_enm2_milk) == 0){
													_hp = _maxhp-4;
												}
											}
										}
										
										//prevent stunlock
										if(_falling){
											_yolob_kicked = true;
										}
										if(_yolob_kicked){
											remove_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_DODGE]);
											_yolob_kicked_init = true;
										} else {
											if(_yolob_kicked_init){
												add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_DODGE]);
												_yolob_kicked_init = false;
											}
										}
									}
							
									var canmilk = true;
									if(_falling || _fall_ko || _standup || _taunt > 0 || _successparry > 0 || _shockwave || _mashed || _stuntimer > 0){
										canmilk = false;
									}
							
									//force attack move
									if(_enmtype != -1 && !_alt_attack){
										_yolob_milktimer = 9999;
									}
							
									if(_yolob_addtimer){
										_yolob_milktimer ++;
									}
							
									if(_enmtype == 1){
										//milkman
										if(_standup){
											_yolob_milktimer = 999;
											_behaviortype = "move";
											_curstate = STATE_IDLE;
											canmilk = true;
										}
										
										if(!_yolob_milkstun && (_hurttimer > 0 || _falling)){
											_milkthrow = true;
										}
										if(_dodgetimer > 0 || _attack){
											_milkthrow = true;
										}
										
										if(_hp < _maxhp-1 || _milkthrow){
											if(!_standup && _behaviortype == "move" && _curstate != STATE_JUMP && canmilk){
												if(!_yolob_milk){
													remove_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED]);
														
													for(var i = 0; i < array_length(_yolob_sfx); i++){
														_yolob_sfx[i][2] = false;
													}
										
													_yolob_kick = false;
													_slide = false;
													_attack = false;
													_anim_transition = false;
										
													_milkthrow = false;
										
													_anim = "glontch";
													_displayobj.image_index = 0;
													_yolob_milktimer = 0;
													_yolob_milkact = 0;
													_yolob_milkstun = false;
													_yolob_milkhits = 0;
													_yolob_milk = true;
													_yolob_heal = false;
													_yolob_stopheal = false;
												}
											}
										}
									} else if(_enmtype == 0){
										//redcap
										if(_alt_tutorial){
											_kotimer = 0;
										}
										
										if(_yolob_man_cd <= 0 && !_mashed && _hurttimer <= 0){
											remove_trait([TRAIT_HURT,TRAIT_MASHED]);
										}
										if(_falling && _height > _groundlevel){
											_kotimer = 0;
											_nocked = 0;
										}
										if(_fall_ko || _standup){
											add_trait([TRAIT_HURT,TRAIT_MASHED]);
										}
										
										if(_yolob_man_cd <= 0 && _height <= _groundlevel && _behaviortype == "move" && _curstate != STATE_JUMP && canmilk){
											_dodgezones = _dodgezones_start;
											
											_displayobj.image_index = 0;
											_yolob_man_sfx = [false,false];
											_yolob_man_timer = 0;
											_yolob_man_groundpos = [x,y];
											_yolob_man_groundtimer = 0;
											_yolob_man_atktimer = 0;
											_yolob_man_hand = false;
											_yolob_man_handgone = false;
											_yolob_atkstate = YOLOB_ATK_ALT1;
										}
									}
							
									if(_yolob_milk){
										_slide = false;
										_attack = false;
										_jumpingtimer = 0;
										_taunt = 0;
									
										_grabout = false;
								
										_jumpingtimer = 0;
										_slidetimer = 0;
								
										_yolob_timer = 0;
										_yolob_kick = false;
								
										_curspd = [0,0];
										clearpath();
								
										if(_dodgetimer > 0 || _hurttimer > 0 || _falling){
											add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED]);
											_yolob_milk = false;
											_yolob_milkact = 0;
											_yolob_milktimer = 0;
											_yolob_heal = false;
										}
									
										_dh = instance_nearest(x,y,obj_dh_mask);
										if(_dh != noone && instance_exists(_dh)){
											if(_dh.x < x){
												_curdir = DIR_L;
											} else {
												_curdir = DIR_R;
											}
										}
								
										switch(_yolob_milkact){
											case 0:
												//glontching animation
												_alt_attack = true;
										
												if(!_yolob_heal && _displayobj.image_index >= 16){
													//healing
													var hpheal = 3;
											
													if(!_yolob_stopheal){
														_storehp = _hp;
														_hp += hpheal;
														if(_hp > _maxhp){
															_hp = _maxhp;
														}
													}
											
													with(_hitobj){
														ui_hp_stuff(_parentobj);
													}
													with(obj_gui){
														ui_fade("enemy", 1);
													}
											
													sfx_play_proximity(snd_item);
											
													var n = 0;
													if(_hp < _maxhp){
														n = hpheal;
													} else {
														n = diff_abs(_storehp, _maxhp);
													}
													
													if(floor(n) > 0){
														var healnum = instance_create_depth(x, y - 220, 0, obj_nums);
														healnum._num = n;
														healnum._plus = true;
													}
											
													_yolob_heal = true;
												}
										
												//sounds
												for(var i = 0; i < array_length(_yolob_sfx); i++){
													if(!_yolob_sfx[i][2] && _displayobj.image_index >= _yolob_sfx[i][0]){
														sfx_play_proximity(_yolob_sfx[i][1]);
														sfx_pitch(_yolob_sfx[i][1], random_range(0.86, 1.12));
														_yolob_sfx[i][2] = true;
													}
												}
										
												if(_anim == "glontch" && !_anim_transition && _displayobj.image_index >= _displayobj.image_number-1){
													_displayobj.image_index = 0;
													_yolob_milkact = 1;
													
													_yolob_kicked = false;
													
													var milk = instance_create_depth(x+(32*_curdir), y+32, _displayobj.depth, obj_st2_enm2_milk);
													milk._curdir = _curdir;
													milk._enmtype = _enmtype;
													milk._parentobj = self;
													milk._alt_tutorial = _alt_tutorial;
										
													milk._xspd = 14;
													if(_ailevel >= 4){
														milk._xspd = 18;
													}
													if(_ailevel >= 5.5){
														milk._xspd = 23;
													}
													if(_ailevel >= 7){
														milk._xspd = 28;
													}
										
													milk._maxcolors = _maxcolors;
													milk._mult_colorinArray = _mult_colorinArray;
													milk._mult_coloroutArray = _mult_coloroutArray;
													milk._mult_tolrArray = _mult_tolrArray;
													milk._mult_blendArray = _mult_blendArray;
											
													sfx_play_choose_proximity(global._punchsounds[0]);
												}
											break;
											case 1:
												//throwing animation
												if(_displayobj.image_index >= _displayobj.image_number-1){
													add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED]);
													
													_yolob_milk = false;
													_yolob_milktimer = 0;
													_yolob_milkact = 0;
													_yolob_heal = false;
												}
											break;
										}
									}
								}
							break;
							
							case YOLOB_ATK_ALT1:
								//redcap attack behavior
								if(has_trait(TRAIT_HURT)){
									remove_trait(TRAIT_HURT);
								}
								if(has_trait(TRAIT_GRAB)){
									remove_trait(TRAIT_GRAB);
								}
								if(has_trait(TRAIT_MASHED)){
									remove_trait(TRAIT_MASHED);
								}
								
								_fixwall = false;
								clearpath();
								_curspd = [0,0];
								
								_grabout = false;
								
								//hp
								_displayhp = _displayhp + (_hp - _displayhp) * 0.12;
								
								if(_displayobj.image_index >= 1 && !_yolob_man_sfx[0]){
									sfx_play_proximity(snd_redcap_rise);
									_yolob_man_sfx[0] = true;
								}
								
								if(_displayobj.image_index >= 6 && !_yolob_man_sfx[1]){
									with(obj_camera){
										_ampY = 50;
									}
									
									sfx_stop(snd_redcap_rise);
									sfx_play_proximity(snd_redcap_hit);
									sfx_pitch(snd_redcap_hit, random_range(0.9,1.1));
									
									voice_play_overlap_proximity(snd_yolo_taunt);
									sfx_pitch(snd_redcap_hit, random_range(1.05,1.15));
									_yolob_man_sfx[1] = true;
								}
								
								if(!_yolob_man_hand && _yolob_man_sfx[1]){
									with(obj_camera){
										if(_ampY < 5){
											_ampY = 5;
										}
									}
								}
								
								//move ground spots to dh
								var dh = instance_nearest(x,y,obj_dh_mask);
								if(dh != noone && instance_exists(dh)){
									if(!_yolob_man_hand){
										var finalpos = [dh.x,dh.y];
										var spd = 12;
									
										_yolob_man_atktimer ++;
										if(_yolob_man_atktimer >= 60){
											_yolob_man_groundtimer ++;
											if(_yolob_man_groundtimer >= 7){
												var spot = instance_create_depth(_yolob_man_groundpos[0]+random_range(-14,14),_yolob_man_groundpos[1]+random_range(4,28), depth, obj_st2_enm2_ground);
												if(diff_abs(_yolob_man_groundpos[0], finalpos[0]) <= spd+7 && diff_abs(_yolob_man_groundpos[0], finalpos[0]) <= spd+7){
													spot._hand = true;
													spot._obj = dh;
													spot._total_ailevel = _total_ailevel;
													spot._parentobj = self;
													spot._alt_tutorial = _alt_tutorial;
												
													spot._maxcolors = _maxcolors;
													spot._mult_colorinArray = _mult_colorinArray;
													spot._mult_coloroutArray = _mult_coloroutArray;
													spot._mult_tolrArray = _mult_tolrArray;
													spot._mult_blendArray = _mult_blendArray;
													
													_yolob_man_handobj = spot;
												
													_yolob_man_hand = true;
												}
												_yolob_man_groundtimer = 0;
											}
									
											if(_yolob_man_groundpos[0] < finalpos[0]){
												_yolob_man_groundpos[0] += spd;
											} else if(_yolob_man_groundpos[0] > finalpos[0]){
												_yolob_man_groundpos[0] -= spd;
											}
									
											if(_yolob_man_groundpos[1] < finalpos[1]){
												_yolob_man_groundpos[1] += spd;
											} else if(_yolob_man_groundpos[1] > finalpos[1]){
												_yolob_man_groundpos[1] -= spd;
											}
										}
									}
								}
									
								if(_yolob_man_lowkick){
									_hp -= 9;
									
									_standup_mult = 2.32;
									_dodgezones = [];
									_stuntimer = scr_ailevel(100, 180);
									remove_trait(TRAIT_DODGE);
									
									with(_hitobj){
										ui_hp_stuff(_parentobj);
									}
									
									with(obj_camera){
										_ampX = 12;
										_ampY = 12;
									}
									
									global._pad_vibrate = 6;
									
									var dmgnums = instance_create_depth(x+_dmgoffset[0], y-((sprite_height * 2)+150)+_dmgoffset[1], 0, obj_nums);
									dmgnums._num = max(1,floor(_hplastframe - _hp));
									_hplastframe = _hp;	
									
									_fall_ko = false;
									_jump = false;
									_standup = false;
									_dodge = false;
									
									_falling = true;
									_height = _groundlevel + 1;
									_vspd = 17;
									
									var snd = [snd_yolo_slam1,snd_yolo_slam2,snd_yolo_slam3];
									voice_play_overlap_proximity(snd[irandom(array_length(snd)-1)]);
									
									_yolob_man_lowkick_end = true;
									_yolob_man_lowkick = false;
								}
								
								var jumpoff = false;
								var mashed = false;
								
								function endattack() {
									with(obj_st2_enm2_ground){
										if(!_hand){
											_timer = 999;
										}
									}
									if(_yolob_man_handobj != noone && instance_exists(_yolob_man_handobj)){
										with(_yolob_man_handobj){
											var p = instance_create_depth(x-64,y-64,-32, obj_particle);
											p._type = "vanish";
							
											sfx_play(snd_skullcrack);
								
											instance_destroy();
										}
									}
									with(obj_boss2_mine_warning){
										instance_destroy();
									}
								}
								
								//jump off
								if(place_meeting(x,y,obj_punchhitbox)){
									var hbox = instance_place(x,y,obj_punchhitbox);
									if(instance_exists(hbox)){
										if(hbox._ptype == "pl"){
											endattack();
											
											if(hbox._damage != ATK_MASH){
												jumpoff = true;
											} else {
												mashed = true;
											}
											
											instance_destroy(hbox.id);
											
											_yolob_man_handgone = true;
										}
									}
								}
								if(_grabattempt > 0 || _shockwave > 0){
									endattack();
									
									_yolob_man_handgone = true;
									jumpoff = true;
									if(_shockwave > 0){
										jumpoff = false;
									}
									mashed = false;
									_grabattempt = 0;
								}
								
								if(_yolob_man_handgone || _falling || _death || _shockwave > 0){
									add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED]);
									_attack = false;
									_yolob_atkstate = YOLOB_ATK_NONE;
									if(!_yolob_man_lowkick_end && jumpoff){
										if(!_fall_ko || !_standup){
											_displayobj.image_index = 0;
										}
										_yolob_man_cd = 12;
										_fall_ko = true;
										_jump = true;
										_standup = true;
										_height = _groundlevel + 1;
										_vspd = random_range(12,17);
										_dodge = true;
										_curspd = [0,0];
										clearpath();
										
										sfx_play_choose_proximity(global._swishsounds[1]);
									}
									if(mashed){
										add_trait([TRAIT_HURT,TRAIT_MASHED]);
										_yolob_man_cd = 60;
									}
								}
							break;
						}
						
						if(_yolob_man_cd > 0){
							_yolob_man_cd --;
						}
					
						scr_enemyscript_animation("step");
						
						if(_anim == "follow"){
							if(_displayobj.image_index >= 0 && _displayobj.image_index < 1){
								if(_dostepsound){
									sfx_play_choose_proximity([asset_get_index("snd_footstep1_"+_floortype),asset_get_index("snd_footstep2_"+_floortype)], 1, false);
									_dostepsound = false;
								}
							} else {
								_dostepsound = true;
							}
						} else if(_anim == "walk"){
							if((_displayobj.image_index >= 2 && _displayobj.image_index < 3)||(_displayobj.image_index >= 5 && _displayobj.image_index < 6)){
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
						
						if(!_death){
							if(_anim_transition){
								if(_hurttimer > 0 || _dodgetimer > 0){
									_anim_transition = false;
								}
								
								//transitions
								switch(_anim_tr_anim){
									case "standup_idle":
										_anim = "tr_standup_idle";
									break;
									case "standup_stun":
										_anim = "tr_standup_stun";
									break;
									case "crouch_in":
										if(_slideact > 0 || _attack){
											_anim_transition = false;
										}
										_anim = "tr_crouch_in";
									break;
									case "crouch_out":
										if(_attack){
											_anim_transition = false;
										}
										_anim = "tr_crouch_out";
									break;
								}
								if(_displayobj.image_index >= _displayobj.image_number-1){
									_anim_tr_anim = "";
									_anim_prev = _anim;
									_anim_transition = false;
								}
							} else {
								if(_hurttimer == 0 && _dodgetimer == 0){
									switch(_behaviortype){
										case "idle":
											_anim_prev = _anim;
											if(_stuntimer == 0){
												_anim = "idle";
											} else {
												if(_stunact == 0){
													_anim = "stun";
												} else if(_stunact > 0){
													_anim = "stun2";
												}
											}
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
								
								if(_yolob_milk){
									switch(_yolob_milkact){
										case 0:
											_anim = "glontch";
										break;
										case 1:
											_anim = "throw";
										break;
									}
								}
								
								if(_attack){
									switch(_attacktype){
										case "idle":
											if(!_yolob_kick){
												_anim_prev = _anim;
												_anim = "kick1";
												//loop kick1
												if(_displayobj.image_index >= _displayobj.image_number-1){
													_displayobj.image_index = 3;
												}
											} else {
												_anim_prev = _anim;
												_anim = "kick2";
											}
										break;
									}
									_curspd = [0,0];
									clearpath();
								}
								
								//slide
								if(_curstate == STATE_SLIDE){
									_anim_prev = _anim;
									if(_slideact == 0){
										_anim = "crouch";
									} else if(_slideact > 0){
										_anim = "lowkick";
									}
								}
								
								if(_taunt > 0){
									_anim_prev = _anim;
									_anim = "taunt";
									_curspd = [0,0];
									clearpath();
								}
								
								if(_anim == "taunt"){
									if(_didtauntsound == false){
										voice_play_overlap_proximity(snd_yolo_taunt, 1);
										_didtauntsound = true;
									}
								}
								else{
									_didtauntsound = false;
								}
								
								if(_behaviortype == "hopping"){
									if(!_hop_walk){
										_anim_prev = _anim;
										_anim = "hop";
									} else {
										_anim_prev = _anim;
										_anim = "walk";
										_animspeed = _walk_animspeed;;
									}
								}
								
						
								//dodge anim
								if(_dodgetimer > 0){
									_anim_prev = _anim;
									_anim = "dodge";
								}
								
								if(_fall_ko){
									if(_stuntimer <= 0){
										_anim_prev = _anim;
										_anim = "dead";
										if(_standup && _hurttimer <= 0){
											_anim_prev = _anim;
											_anim = "standup";
										}
									} else {
										_anim_prev = _anim;
										_anim = "dead_stun";
										if(_standup && _hurttimer <= 0){
											_anim_prev = _anim;
											_anim = "standup_stun";
										}
									}
									if(_grabdodge){
										_anim_prev = _anim;
										_anim = "hop";
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
								
								switch(_yolob_atkstate){
									case YOLOB_ATK_ALT1:
										_anim_prev = _anim;
										_anim = "redcap";
									break;
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
							if(compare_anim("standup", "idle") || compare_anim("standup", "walk") || compare_anim("hop", "idle") || compare_anim("hop", "walk")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_idle";
								_anim_tr_init = false;
								_anim_transition = true;
							}
							if(compare_anim("standup_stun", "stun")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "standup_stun";
								_anim_tr_init = false;
								_anim_transition = true;
							}
							if(compare_anim("parachute", "idle") || compare_anim("parachute", "walk") || compare_anim("parachute", "backoff")){
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
							if(compare_anim("milkman", "idle") || compare_anim("milkman", "walk") || compare_anim("milkman", "backoff")){
								_displayobj.image_index = 0;
								_anim_tr_anim = "crouch_out";
								_anim_tr_init = false;
								_anim_transition = true;
							}
						
							_anim_prev = _anim;
						}
					
						if(_yolob_atkstate == YOLOB_ATK_NONE && !_death){
							scr_enemyscript_detect();
						}
					
						scr_enemyscript_other();
					} else {
						_curstate = STATE_OTHER;
						clearpath();
					}
					
					scr_enemyscript_death();
					
					if(_death || _falling){
						if(_yolob_sol != noone && instance_exists(_yolob_sol)){
							instance_destroy(_yolob_sol.id);
						}
					}
					
					if(_enmtype == 1 && (_falling || _yolob_milkstun)){
						_standup_mult = 0;
						
						_atkallowed = [ATK_NORM,ATK_KO];
						
						_yolob_heal = true;
						_yolob_stopheal = true;
						if(_milkthrow){
							remove_trait(TRAIT_HURT);
							_dmgmultiplier = 0;
						} else {
							add_trait(TRAIT_HURT);
							_dmgmultiplier = 1.32;
						}
					}
					
					if(_alt_tutorial && !_death && !_falling){
						if(_yolob_sol == noone || !instance_exists(_yolob_sol)){
							_yolob_sol = instance_create_depth(x-200,y-200,depth,obj_solid);
							_yolob_sol._collidewith = "enemy";
							_yolob_sol.image_xscale = 8;
							_yolob_sol.image_yscale = 8;
						}
					}
					
					if(_enmtype == 1){
						if(_yolob_milkstun || _successparry > 0){
							_milkthrow = false;
							_atkallowed = [ATK_NORM,ATK_KO];
							_block_endzones = _block_endzones_start;
							_dodgezones = _dodgezones_start;
							add_trait([TRAIT_HURT,TRAIT_GRAB,TRAIT_MASHED]);
						}
					}
					
					//animation not affected by freeze
					if(!_death){
						if(_falling && !_grabout){
							_anim = "fall";
							if(_stuntimer > 0){
								_anim = "fall_stun";
							}
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
	} else {
		clearpath();
		with(_displayobj){
			image_speed = 0;
		}
	}
}