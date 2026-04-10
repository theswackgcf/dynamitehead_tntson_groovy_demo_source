{	
	if(!global._tutorial){
		scr_culling();
	}
	
	if(!global._pause){
		_allsoundstimer ++;
		if(_allsoundstimer >= 180){
			scr_clearsounds();
			_allsoundstimer = 0;
		}
		
		global._sticktimer = 2;
		
		with(_displayobj){
			if(!_parentobj._slam){
				image_speed = 1;
			}
		}
		
		if(!_init){
			scr_player_setinput();
		} else {
			//input buffering
			for(var i = 0; i < array_length(_tempinputs); i++){
				if(keypress(_tempinputs[i])){
					_buffertimer_press = 0;
					if(array_length(_input_keypress) >= 3){
						array_delete(_input_keypress, 0, 1);
					}
					array_push(_input_keypress, _tempinputs[i]);
				}
				if(keyrelease(_tempinputs[i])){
					_buffertimer_release = 0;
					if(array_length(_input_keyrelease) >= 3){
						array_delete(_input_keyrelease, 0, 1);
					}
					array_push(_input_keyrelease, _tempinputs[i]);
				}
			}
			
			//clear buffers after half a second
			_buffertimer_press ++;
			if(_buffertimer_press >= 30){
				_input_keypress = [];
				
				_buffertimer_press = 0;
			}
			_buffertimer_release ++;
			if(_buffertimer_release >= 30){
				_input_keyrelease = [];
				
				_buffertimer_release = 0;
			}
			
			if(global._defCamZoom <> 0){
				global._playerX = (_displayobj.x-global._cameraX)/global._defCamZoom;
				global._playerY = (_displayobj.y-global._cameraY)/global._defCamZoom;
			}
			global._playerDir = _curdir;
		
			//movement / collision
		
			if(place_meeting_array(x, y, _collidesolid)){
				var inst = place_meeting_array(x, y, _collidesolid, true);
				if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height >= inst._height && _vspd <= 0){
					_groundlevel = inst._height;
				}
			} else {
				_groundlevel = 0;
			}
			if(_groundlevel < _height && !_jump){
				_height = _groundlevel;
			}
		
			//progression
			var maxclamp = 1;
			var divide = 1;
			var mult = 3;
			var progress_mult = 1;
			var knockout_mult = 0;
			switch(global._location){
				case 0:
					maxclamp = 5;
					divide = 8;
					mult = 3;
					
					knockout_mult = 0.1;
				break;
				case 1:
					maxclamp = 6.65;
					divide = 40;
					mult = 7;
					progress_mult = 0.58;
					
					knockout_mult = 0.15;
				break;
			}
			
			global._progress = (((room_width*room_height)/(WIDTH*HEIGHT))/divide)-(distance_to_object(obj_finish)/(HEIGHT*mult));
			global._progress = max(2, clamp(global._progress*progress_mult, 0, maxclamp)-(global._knockouts*knockout_mult));
			
			if(instance_number(obj_finish) == 0){
				global._progress = 3.5;
			}
			
			//show_debug_message(global._progress);
			
			if(!global._dialogue){
				if(!_doWin && place_meeting(x, y, obj_finish)){
					var finish = instance_place(x, y, obj_finish);
					if(instance_exists(finish) && finish._collidewin){
						_runroll = false;
						_runroll_dive = false;
						_runroll_bump = false;
						_doWin = true;
						if(global._tutorial){
							mus_fade(0, 1000, true);
						}
					}
				}
			}
		
			//light spot
			_showlight = false;
			if(global._location == 1 && instance_number(obj_boss2_mask) > 0 && !global._lightsout){
				_showlight = true;
			}
			if(!_showlight){
				if(instance_exists(_lightsource)){
					instance_destroy(_lightsource.id);
					_lightsource = noone;
				}
			} else {
				if(_lightsource == noone){
					_lightsource = instance_create_depth(x,y+32,0,obj_lightsource);
				} else {
					if(instance_exists(_lightsource)){
						_lightsource.x = x;
						_lightsource.y = y+32;
						_lightsource.image_xscale = _light_scalex;
					}
				}
			}
		
			//movement

			if(global._tutorial){
				_spd[1] = 0;
				totalspd[1] = 0;
				_realspd[1] = 0;
				y = _starty;
			}

			scr_player_movement();
	
			//states
			var disallowedstates = ["begin","item","tnt","win","shockwave","nomove","zapped","shield"];
		
			if(!array_contains(disallowedstates, _state)){
				_state = "default";
				if(_crouch){
					_state = "crouch";
					if(_slide){
						_state = "slide";
					}
				}
				if(_jump){
					_state = "jump";
				}
			}

			//winning
			if(_state == "win"){
				if(!global._winscreen){
					mus_stop();
				}
				if(_wintimer >= 180+_wintimeroffset && !global._winscreen){
					if(!global._tutorial){
						var results = instance_create_depth(0,0,0,obj_results);
						
						results._dhwinobj = instance_create_depth(-WIDTH, 0, 0, obj_windh);
						results._bgwinobj = instance_create_depth(0, 0, 0, obj_winbg);
						
						global._winscreen = true;
						mus_play(mus_win);
						
						//newgrounds achievements
						if(global._newgrounds && global._nglogin){
							ng_unlockmedal(NG_ACHV_COMPLETE);
							if(global._knockouts <= 0){
								ng_unlockmedal(NG_ACHV_HELLYEAH);
							}
						}
					} else {
						with(obj_tipbox){
							instance_destroy();
						}
						if(!global._fadeout){
							global._fadeout = true;
						}
					}
				}
			}
	
			//animation
			_hitobj._curscale = 0; //hitbox size
			
			if(_freeze <= 0){
				if(_anim_transition){
					scr_player_animtransitions("before");
				} else {
					scr_player_animation();
				
					scr_player_animtransitions("after");
				}
			}
		
			//occupy zones
			if(_zoneobj_l._occupytimer <= 0){
				_occupied_zone[0] = -1;
			} else {
				_occupied_zone[0] = _zoneobj_l._curenemyid;
			}
			if(_zoneobj_r._occupytimer <= 0){
				_occupied_zone[1] = -1;
			} else {
				_occupied_zone[1] = _zoneobj_r._curenemyid;
			}
			
			//stage begin
			scr_player_begin();
		
			//direction
			if(_freeze <= 0){
				if(instance_exists(_displayobj)){
					_curdir = clamp(_curdir, DIR_L, DIR_R);
					if(round(_curdir) == 0){
						_curdir = choose(DIR_L, DIR_R);
					}
					var mirrordir = 1;
					var mirroranims = ["fall","dead"];
					//mirror direction when one of the animations above are playing
					for(var ind = 0; ind < array_length(mirroranims); ind++){
						if(_anim == mirroranims[ind]){
							mirrordir = -1;
						}
					}
					if(_slam){
						_curdir = _slamdir;
					}
					_displayobj._xscale = _curdir*mirrordir;
				
					var spdAdjust = min(1, (abs(_diagspeed)*0.6))*_speed;
					if(spdAdjust <= 0){
						spdAdjust = 0.2;
					}
			
					if(!_running && (abs(_spd[0]) > 0 || abs(_spd[1]) > 0) && _inptype == 1){
						//analog walking
						_displayobj.image_speed = spdAdjust;
					}
					if(_running && (abs(_spd[0]) > _maxspd[0]/4 || abs(_spd[1]) > _maxspd[1]/4)){
						_displayobj.image_speed = spdAdjust;
					}
				}
			}

			//hp
			_displayhp = _displayhp + (_hp - _displayhp) * 0.12;
			if(_hptimer > 0){
				_hptimer --;
				_displayhp = 0;
			}

			//end attacking
			if(_attack){
				if(_displayobj.image_index >= _displayobj.image_number-1){
					if(_anim == "melee_idle3"){
						_finalcombo = false;
					}
					if(_attacktype != "air"){
						_attack = false;
					} else {
						_displayobj.image_index = _displayobj.image_number-4;
					}
				}
				if(_attacktype == "air" && _displayobj.image_index >= 2){
					if(!_attackhb){
						_attackhb = true;
						var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
						atk._parentobj = self.id;
						atk._scale = [6, 5.2];
						atk._offset = [180,90];
						atk._timer = 320;
						if(_height >= _groundlevel + _mingroundko){
							atk._damage = ATK_KO;
						} else {
							atk._damage = ATK_NORM;
						}
						atk._frame = 2;
						atk._type = "air";
						atk._persist = true;
					}
				}
				if(_attacktype == "upper" && _displayobj.image_index > 0){
					if(!_attackhb){
						_attackhb = true;
						var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
						atk._parentobj = self.id;
						atk._scale = [6.2, 4];
						atk._offset = [170,-100];
						atk._timer = 9;
						atk._damage = ATK_KO;
					}
				}
				if(_attacktype == "doublekick" && _displayobj.image_index >= 2){
					if(!_attackhb){
						_attackhb = true;
						var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
						var atk2 = instance_create_depth(x, y, -1, obj_punchhitbox);
						atk._parentobj = self.id;
						atk2._parentobj = self.id;
						atk._scale = [6.25, 6];
						atk._offset = [220, -75];
						atk._curdir = DIR_R;
						atk._parentdir = false;
						atk._persist = true;
						atk2._scale = [6.25, 6];
						atk2._offset = [220, -75];
						atk2._curdir = DIR_L;
						atk2._parentdir = false;
						atk._timer = 10;
						atk2._timer = 10;
						atk._damage = ATK_KO;
						atk2._damage = ATK_KO;
						atk2._persist = true;
						atk2._delay = 5;
					}
				}
				if(_attacktype == "air" && _jump_enmhit){
					_vaccel += 12;
					_vspd -= _vaccel;
					if(_vspd <= -32){
						_vspd = -32;
					}
				}
				
				if(_attacktype == "air" && _state != "jump"){
					_attack = false;
					if(_jump_enmhit){
						//do jump roll thing if enemy has been attacked by the air attack
						_state = "jump";
						_jump = true;
						_height = _groundlevel+2;
						_vspd = 18;
						_rolljump = true;
						
						with(obj_camera){
							_ampY = 20;
						}
						
						var pos = 90;
						var partc = instance_create_depth((x-170)+pos, y, 0, obj_particle);
						partc._type = "fx5";
					
						sfx_play_choose([snd_thud,snd_thud2,snd_thud3,snd_thud4]);
					
						_jump_enmhit = false;
					}
				}
			} else {
				_attacktype = "";
				_finalcombo = false;
				_attackhb = false;
				_doublekick = false;
			}
			
			if(_rolljump && _height <= _groundlevel){
				_roll_bounceoff = 15;
				_rolljump = false;
			}
			
			if(_nojump > 0){
				_nojump_end = true;
				if(_hurtTimer > 0 || _falling){
					_nojump = 0;
				}
					
				with(obj_camera){
					if(_ampY < 8){
						_ampY = 8;
					}
				}
					
				_nojump --;
				_state = "nomove";
			} else {
				if(_nojump_end){
					_state = "default";
					_nojump_end = false;
				}
			}
			
			//slam attack
			if(_enemygrab && _slam){
				if(_freeze <= 0){
					if(_grabinst._hp <= 0){
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
					
					if(_slamcooldown > 0){
						_slamcooldown --;
					}
					
					for(var i = 0; i < array_length(_slamsounds); i++){
						if(!_slamsounds[i][3] && _displayobj.image_index >= _slamsounds[i][2]){	
							if(_grabinst != noone && _grabinst._hp > 0){
								sfx_stop_array(_slamsounds[i][0]);
								sfx_play_choose(_slamsounds[i][0]);
							
								global._pad_vibrate = 2;
							}
						
							//set offset
							var offset = 450;
							var boxoffset = offset;
								
							var pos = 0;
							var boxpos = 0;
						
							pos = offset*_slamsounds[i][4]*_curdir;
							boxpos = boxoffset*_slamsounds[i][4];
							_tempdir = _slamsounds[i][4];
						
							if(_grabinst != noone && instance_exists(_grabinst) && _grabinst._hp > 0){
								_grabinst._dmgoffset[0] = pos;
								_grabinst._dmgoffset[1] = 160;
							}
						
							//other
							if(_canslam && _slamsounds[i][1] == "slam"){
								_canslam = false;
								//damage enemy
								if(_grabinst != noone && instance_exists(_grabinst) && _grabinst._freeze <= 0){
									with(obj_gui){
										ui_fade("enemy", 1);
									}
									if(_hurtTimer <= 0 && _grabinst._hurttimer <= 0){
										_grabinst._stunlock_hits += 0.8;
										_grabinst._stunlock_timer = _grabinst._stunlock_formula;
										_grabinst._dmgcoold = 0;
										_grabinst._hurttimer = 3;
										var minval = 0;
										if(_grabinst._codename != "fridge"){
											minval = ceil((_slamcount+1)*0.48);
										} else {
											minval = 3;
										}
										_grabinst._hp -= minval;
										_grabinst._deathoffset = [pos, 42];
										with(_grabinst._hitobj){
											if(has_trait(TRAIT_HP, _parentobj)){
												ui_hp_stuff(_parentobj);
											}
										}
									}
									
									if(_grabinst._hp > ceil((_slamcount+1)*0.48)){
										var grabhitbox = _grabinst._hitobj;
										
										if(_slamcooldown <= 0 && instance_exists(grabhitbox)){
											_slamcooldown = 24;
											with(grabhitbox){
												scr_showhits();
											}
										}
									}
									
									if(_grabinst._hp > 0){
										with(obj_camera){
											_ampY = 25;
										}
										
										var partc = instance_create_depth(x+pos, y+42, 0, obj_particle);
										partc._type = "fx5";
										
										//create hurtbox
										var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
										atk._parentobj = self.id;
										atk._scale = [7.8, 7.2];
										atk._offset = [boxpos*1,70];
										atk._timer = 10;
										atk._damage = ATK_KO;
										atk._slam = true;
											
										var array = (_grabinst._playvoice).slam;
							
										if(array != -1){
											var randind = irandom_range(0,array_length(array)-1);
											var randsound = array[randind];
											voice_play_overlap_proximity(randsound);
											sfx_pitch(randsound, random_range(_grabinst._slampitch[0],_grabinst._slampitch[1]));
										}
									}
									
									_slambonks ++;
								}
							}
							if(_slamsounds[i][1] != "slam"){
								_slamcooldown = 0;
								_canslam = true;
							}
						
							_slamsounds[i][3] = true;
						}
					}
					
					//reset actions
					if(_displayobj.image_index >= _displayobj.image_number-1){
						_displayobj.image_index = 0;
						if(_hurtTimer <= 0){
							_slamcount += 2.24;
						}
						for(var i = 0; i < array_length(_slamsounds); i++){
							_slamsounds[i][3] = false;
						}
					}
				}
			}
			
			if(!_slam){
				_slamcooldown = 0;
				_canslam = true;
			}
			
			//double kick checks
			for(var i = 0; i < array_length(_doublekickcheck); i++){
				var enemy = collision_rectangle(x + _doublekickcheck[i][0][0], y + _doublekickcheck[i][0][1], x + _doublekickcheck[i][1][0], y + _doublekickcheck[i][1][1], obj_enemy, false, true);
			    if(instance_exists(enemy) && enemy._sequence_finished && enemy._phaseend_act == 0 && !enemy._grabbed && !enemy._falling && !enemy._fall_ko){ //this PROOOOBABLY needs more checks for enemy states...
					_doublekickbools[i] = true;
				} else {
					_doublekickbools[i] = false;
				}
			}

			//jump, spd, decel/accel, sliding
			scr_player_movement_other();
		
			scr_player_falling();
			
			scr_player_melee_mashing();
		
			//hp, timers, etc
			scr_player_other();

			//battle zone
			if(!global._freeRoam){
				if(place_meeting(x, y, obj_battlezone_trigger)){
					var bz = instance_place(x, y, obj_battlezone_trigger);
					if(!bz._trigger && bz._bzone != noone && instance_exists(bz._bzone)){
						var battlezonereal = bz._bzone;
						if(battlezonereal._act == 0){
							//trigger
							battlezonereal._act = 1;
							var camera = instance_find(obj_camera, 0);
							camera._battleTarget = self;
							camera._battlezone = battlezonereal;
							camera._mode = 1;
						}
						instance_destroy(bz.id);
					}
				}
			}
			
			//interaction
			if(place_meeting(x,y,obj_checkp)){
				var inst = instance_place(x,y,obj_checkp);
				if(inst.id != global._checkpoint && inst._checktrig && !inst._triggered){
					//valid checkpoint
					global._checkpoint = inst.id;
					global._checkPos = [x,y];
				
					inst._checkanim = true;
				
					with(inst){
						global._checkps[? self.id] = self.id;
						_triggered = true;
					}
				
					global._moneypickups.prev = global._moneypickups.cur;
					global._plusmoney.prev = global._plusmoney.cur;
					
					global._kills_prev = global._kills;
					
					ds_map_copy(global._deletedStuffPrev, global._deletedStuff);
			
					with(inst){
						sfx_play(snd_checkp);
					}
				}
			}
			
			if(place_meeting(x,y,obj_floor)){
				var _floor = instance_place(x,y,obj_floor);
				if(_floor != noone && instance_exists(_floor) && _floor._floortype != ""){
					_floortype = _floor._floortype;
				}
			} else {
				_floortype = _deffloortype;
			}
			
			if(_prompts != noone && instance_exists(_prompts)){
				if(_state == "default" && _mashattack == 0 && _height <= _groundlevel && !_dead && !_enemygrab && !_slam){
					if(place_meeting(x, y, obj_item)){
						var inst = instance_place(x, y, obj_item);
						if(!inst._hopping && !inst._falloff){
							_prompts._help_prompt = global._help_prompt_time;
							_prompts._prompt_type = "grab";
						}
					}
					if(_itemanim == 0 && place_meeting(x, y, obj_tnt)){
						var inst = instance_place(x, y, obj_tnt);
						if(inst.visible && !inst._flyhigh && !inst._boxonly){
							_prompts._help_prompt = global._help_prompt_time;
							_prompts._prompt_type = "grab";
						}
					}
					if(place_meeting(x, y, obj_moneypickup_mask)){
						var inst = instance_place(x, y, obj_moneypickup_mask);
						if(inst._act == 1 && !inst._picked){
							_prompts._help_prompt = global._help_prompt_time;
							_prompts._prompt_type = "grab";
						}
					}
				}
			}

			if(_freeze <= 0 && _nojump <= 0){
				scr_player_input();
			}
			
			if(place_meeting(x,y,obj_crouchspot)){
				if(!_slide && !_runroll){
					if(_height > _groundlevel+12){
						_height = _groundlevel+12;
					}
					_crouch = true;
				}
				if(_vspd > 0){
					_vspd = 0;
				}
			}
		
			//enemy is too heavy to grab
			if(_grabfail){
				_spd = [0,0];
				_grabfailtime ++;
				switch(_grabfailact){
					case 0:
						if(_grabfailtime > 12){
							sfx_play(snd_pop);
							
							_displayobj.image_index = 0;
							_grabfailtime = 0;
							_grabfailact = 1;
						}
					break;
					case 1:
						if(_displayobj.image_index >= 7){
							_displayobj._newdepth = _grabid.depth-9;
							if(!_grabfailshake){
								sfx_play(snd_slam);
								
								with(obj_camera){
									_ampY = 26;
								}
								_grabfailshake = true;
							}
						}
						if(_displayobj.image_index >= _displayobj.image_number-1){
							if(_grabid != noone && instance_exists(_grabid)){
								var inst = instance_create_depth(x, y, depth-1, asset_get_index("obj_"+_grabid._codename+"_mask"));
								instance_destroy(_grabid.id);
								inst._height += 4;
								inst._vspd = 10;
								inst._dead = true;
								inst._jumpback = true;
								inst._jump = true;
								inst._hp = _storegrabhp;
								inst._displayhp = _storegrabhp;
								inst._ailevel = _storegrabai;
								inst._grabfall = true;
								(inst._displayobj).visible = true;
								(inst._displayobj).sprite_index = asset_get_index("spr_"+string(inst._codename)+"_standup");
								inst._diddamage = _store_diddamage;
								inst._gotdamaged = _store_gotdamaged;
								_state = "default";
								if(!inst._boss){
									//global._curenemy = inst;
									with(obj_gui){
										ui_fade("enemy", 1);
									}
								} else {
									global._curboss = inst;
									with(obj_gui){
										ui_fade("boss", 1);
									}
								}
							}
							_jump = true;
							_vspd = 10;
					
							sfx_play(snd_jump);
							
							_displayobj._newdepth = 0;
							_grabfailshake = false;
							_grabfail = false;
							_grabfailtime = 0;
							_grabfailact = 0;
						}
					break;
				}
			}
		}
		
		scr_player_screenclear();
		
		if(_anim == "idle" || _anim == "idle_lowhp" || _anim == "idling1" || _anim == "idling2" || _anim == "idling_lowhp"){
			_idleguitimer++;
		}
		else{
			_idleguitimer = 0;
		}
		
		if(_idleguitimer >= _idleguithreshold){
			with(obj_dh_display){
				if(!_outline_idle){
					_outline_alpto = 1;
					_outline_timer = _outline_maxtimer;
					
					_outline_idle = true;
				}
			}
			
			with(obj_gui){
				ui_all_fade(1);
			}
		} else {
			with(obj_dh_display){
				_outline_idle = false;
			}
		}
		
		if(!global._dialogue && _forcemash){
			global._tntjuice = global._tntjuice_mash;
		}
		if(!global._dialogue && _forcetnt){
			global._tntjuice = global._tntjuice_max;
		}
		
		//animation not affected by freeze
		if(_hurtTimer <= 0 && _mashact == 0 && global._blowup_kill == 0){
			if(_attack){
				if(_downattack > 0){
					_attacktype = "down";
				}
				switch(_attacktype){
					case "idle":
					case "down":
						if(!_finalcombo){
							if(_attackvar % 2 == 0){
								_anim_prev = _anim;
								_anim = "melee_"+_attacktype+"1";
							} else if(_attackvar % 2 == 1){
								_anim_prev = _anim;
								_anim = "melee_"+_attacktype+"2";
							}
						}
					break;
					case "air":
						_anim_prev = _anim;
						_anim = "melee_jump";
					break;
					case "crouch":
						_anim_prev = _anim;
						_anim = "melee_crouch";
					break;
					case "upper":
						_height = _groundlevel;
						if(_hurtTimer > 0){
							_attack = false;
							_attacktype = "";
						}
						_anim_prev = _anim;
						_anim = "melee_uppercut";
					break;
					case "doublekick":
						_height = _groundlevel;
					
						_anim_prev = _anim;
						_anim = "doublekick";
					
						if(_hurtTimer > 0){
							_attack = false;
							_attacktype = "";
						}
					break;
				}
			}
		}
		
		switch(_attacktype){
			case "idle":
			case "down":
				if(_finalcombo){
					_anim_prev = _anim;
					if(_height <= _groundlevel){
						_anim = "melee_"+_attacktype+"3";
					} else {
						_anim = "melee_jump";
					}
					_onecombo = 0;
				}
			break;
		}
		if(_phasehit > 0){
			_anim = _phasehit_anim;
			_displayobj.image_index = _phasehit_frame;
		}
		if(global._finalhit <= 0 && _freeze <= 0 && _phasehit > 0){
			_phasehit --;
		}
		
		if(!_runroll_slide){
			if(_crouch || (_attack && _attacktype == "idle")){
				_spd[0] = _crouchspd;
				var mult = 1;
				if(_attack){
					mult = 2.6;
				}
				if(_afterrun_timer > 0){
					_crouchspd = lerp(_crouchspd, 0, 0.045*mult);
				} else {
					_crouchspd = lerp(_crouchspd, 0, 0.18*mult);
				}
				if(_crouchspd < 0 && _crouchspd > -1){
					_crouchspd = 0;
				}
				if(_crouchspd > 0 && _crouchspd < 1){
					_crouchspd = 0;
				}
			} else {
				if(_height <= _groundlevel){
					_crouchspd = _spd[0];
				}
			}
		}
		
		//stage specific
		if(global._location == 0 && place_meeting(x, y, obj_event)){
			global._toxicshack = true;
		} else {
			global._toxicshack = false;
		}

		//kill all badheads achievement
		if(global._newgrounds && global._nglogin && !_checkallkills){
			if(global._kills >= global._stagebadheads[global._location]){
				ng_unlockmedal(NG_ACHV_ALLKILLS);
				_checkallkills = true;
			}
			
			if(global._debug){
				if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("W"))){
					ng_unlockmedal(NG_ACHV_ALLKILLS);
					_checkallkills = true;
				}
			}
		}
	} else {
		with(_displayobj){
			image_speed = 0;
		}
	}
	
	if(global._debug){
		if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("D"))){
			_hp = 0;
		}
		if(global._showHitbox){
			visible = true;
		} else {
			visible = false;
		}
		if(global._freeRoam){
			if(keyboard_check(vk_left)){
				x -= 16;
			}
			if(keyboard_check(vk_right)){
				x += 16;
			}
			if(keyboard_check(vk_up)){
				y -= 16;
			}
			if(keyboard_check(vk_down)){
				y += 16;
			}
		}
	}
}