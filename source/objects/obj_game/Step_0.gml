{	
	if(global._buildver == WINDOWS){
		window_set_size(global._res[global._curres][0],global._res[global._curres][1]);
	} else if(global._buildver == HTML){
		global._curres = 0;
		window_set_size(WIDTH,HEIGHT);
		if(global._htmlinit == false && global._buildver == HTML){
			global._htmlinit = true;
			room_goto(r_htmlinit);
		}
	}
	if(!global._setdisp){
		display_reset(global._all_aa[global._aa_filter], global._vsync);
		global._setdisp = true;
	}
	
	//cursor
	global._cursortimer ++;
	if(global._cursortimer % round((2*(60/min(fps, 1)))) == 0){
		global._prevcursorpos = [window_mouse_get_x(), window_mouse_get_y()];
	}
	if(window_mouse_get_x() <> global._prevcursorpos[0] || window_mouse_get_y() <> global._prevcursorpos[1] || mouse_check_button(mb_left)){
		global._inactivecursor = 0;
	}
	global._inactivecursor ++;
	
	//cursor outside of game's window
	if(!window_get_fullscreen()){
		var disppos = [display_mouse_get_x(),display_mouse_get_y()];
		var wbbox = [window_get_x(),window_get_y(),window_get_x()+window_get_width(),window_get_y()+window_get_height()];
		
		if(disppos[0] <= wbbox[0] || disppos[1] <= wbbox[1] || disppos[0] >= wbbox[2] || disppos[1] >= wbbox[3]){
			global._forcecustorstop = 8;
		}
	}
	
	if(global._state == "menu" || (global._state == "game" && global._pause)){
		if(!global._menumouse){
			global._forcecustorstop = 2;
		}
	}
	
	if(global._forcecustorstop > 0){
		global._inactivecursor = global._inactivecursortime;
		global._forcecustorstop --;
	}
	
	if(global._inactivecursor < global._inactivecursortime){
		if(global._buildver == WINDOWS){
			if(global._full){
				cursor_sprite = spr_cursor32;
			} else {
				var sprites = [spr_cursor8,spr_cursor16,spr_cursor24,spr_cursor32];
				var res = clamp(global._res[global._curres][0]/WIDTH,0,1);
				var curind = clamp(floor(res*array_length(sprites))-1,0,array_length(sprites)-1);
				if(global._res[global._curres][0] >= WIDTH){
					curind = array_length(sprites)-1;
				}
				cursor_sprite = sprites[curind];
			}
		}
		if(global._buildver == HTML){
			cursor_sprite = -1;
		}
	} else {
		cursor_sprite = -1;
	}
	
	//black screen over game display
	if(global._drawBlackScreen > 0){
		global._drawBlackScreen --;
	}
	
	global._timer ++;
	if(!global._pause){
		global._gametimer = current_time;
	}
	
	global._menubuttontimer ++;
	global._menubuttonsin = sin(global._menubuttontimer/16)*10;
	
	if(global._timer % 8 == 0){
		global._tntbordertimer ++;
		if(global._tntbordertimer >= 3){
			global._tntbordertimer = 0;
		}
	}
	
	if(global._tntmenuAct == 1){
		if(global._timer % 4 == 3){
			global._tntmenuframe ++;
			if(global._tntmenuframe >= 5){
				global._tntmenuframe = 0;
				global._tntmenuAct = 2;
			}
		}
	}
	
	global._freezeFrames = {
		vshort_freeze: 2*global._freezevals[global._freezeval],
		short_freeze: 5*global._freezevals[global._freezeval],
		mid_freeze: 10*global._freezevals[global._freezeval],
		long_freeze: 18*global._freezevals[global._freezeval]
	}
	
	//spawn objects
	if(!_init){
		instance_create_depth(0,0,0,obj_input);
		instance_create_depth(0,0,0,obj_camera);
		instance_create_depth(0,0,0,obj_music);
		instance_create_depth(0,0,0,obj_audio);
		instance_create_depth(0,0,0,obj_colors);
		
		switch(global._state){
			case "htmlinit":
				instance_create_depth(0,0,0,obj_clicktofocus);
			break;
			case "loading":
				instance_create_depth(0,0,0,obj_loading_new);
			break;
			case "gameintro":
				instance_create_depth(0,0,0,obj_gameintro);
			break;
			case "menu":
				global._menututorial = false;
				instance_create_depth(0,0,0,obj_groovymenu);
				instance_create_depth(0,0,0,obj_stageselect);
			break;
			case "dialogue":
				instance_create_depth(-WIDTH,-HEIGHT,0,obj_dialogue);
			break;
			case "game":
				if(global._tutorial){
					for(var o = 0; o < array_length(_tutr_ocs); o++){
						var oc = instance_create_depth(random_range(256, room_width-256), obj_dh_display.y-128, 9991, obj_tutr_oc);
						oc._codename = _tutr_ocs[o];
					}
					scr_setgamevals();
				}
			
				if(global._checkpoint == noone){
					global._knockouts = 0;
					global._plusmoney.prev = [];
					global._plusmoney.cur = [];
					global._moneypickups.prev = 0;
					global._moneypickups.cur = 0;
					ds_map_destroy(global._deletedStuffPrev);
					global._deletedStuffPrev = ds_map_create();
					ds_map_destroy(global._deletedStuff);
					global._deletedStuff = ds_map_create();
					ds_map_destroy(global._checkps);
					global._checkps = ds_map_create();
					
					global._seenvs = false;
					if(!global._died){
						global._saveMusPos = 0;
					
						instance_create_depth(0,0,0,obj_stageentrance);
						instance_create_depth(0,0,0,obj_startstar);
					} else {
						global._stageentrance = false;
					}
				} else {
					global._moneypickups.cur = global._moneypickups.prev;
					global._plusmoney.cur = global._plusmoney.prev;
					global._stageentrance = false;
					ds_map_copy(global._deletedStuff, global._deletedStuffPrev);
				}
				global._deleteready = true;
			
				instance_create_depth(0,0,0,obj_pause);
				instance_create_depth(0,0,0,obj_vsscreen);
				instance_create_depth(0,0,0,obj_bg);
				instance_create_depth(0,0,0,obj_fade);
				instance_create_depth(-WIDTH,-HEIGHT,0,obj_dialogue);
				instance_create_depth(0,0,0,obj_lighting);
				instance_create_depth(0,0,0,obj_kohit);
				instance_create_depth(0,0,0,obj_enm_manager);
				instance_create_depth(0,0,0,obj_layers);
				instance_create_depth(0,0,0,obj_groovylights);
				
				if(layer_exists("lv_parallaxfg")){
					var elements = layer_get_all_elements(layer_get_id("lv_parallaxfg"));
					for(var i = 0; i < array_length(elements); i++){
						layer_sprite_x(elements[i], (layer_sprite_get_x(elements[i])/(-global._fgScrollSpd))*0.6);
						_fglayerx[i] = layer_sprite_get_x(elements[i]);
					}
				}
				for(var l = 0; l < 2; l++){
					_bglayerx[l] = [];
					if(layer_exists("lv_parallaxbg"+string(l+1))){
						var elements = layer_get_all_elements(layer_get_id("lv_parallaxbg"+string(l+1)));
						for(var i = 0; i < array_length(elements); i++){
							_bglayerx[l][i] = layer_sprite_get_x(elements[i]);
						}
					}
				}
			break;
			case "intro":
				instance_create_depth(0,0,0,obj_stageintro);
			break;
			case "dead":
				instance_create_depth(global._playerX,global._playerY,0,obj_dynamitedead);
			break;
		}
		
		global._reward = global._rewards[global._location];
		
		_init = true;
	}
	
	//final hit
	if(global._state == "game"){
		global._cameraZoom = global._defCamZoom;
		global._camZoomSpd = 0.07;
		if(!global._pause){
			if(global._finalhit > 0 && global._hitinst != noone && instance_exists(global._hitinst)){
				if(!global._finalhit_init){
					if(!global._finalhit_phase){
						mus_stop();
						for(var i = 0; i < array_length(global._enemyArray); i++){
							//kill enemies onscreen
							with(global._enemyArray[i]){
								if(variable_instance_exists(self.id, "_scrclearend")){
									if(!_boss){
										_displayobj.visible = false;
									}
								}
							}
						}
						
						sfx_play(snd_finalhit);
						if(layer_exists("lvfg")){
							layer_set_visible("lvfg", false);
						}
						if(layer_exists("lv_parallaxfg")){
							layer_set_visible("lv_parallaxfg", false);
						}
						instance_create_depth(global._hitinst.x, global._hitinst.y, 9900, obj_finalhit);
					} else {
						sfx_play(snd_finalko);
					}
					global._finalhit_init = true;
				}
				if(!global._finalhit_phase){
					mus_stop();
				}
				global._cameraZoom = 0.7;
				with(obj_game){
					ui_fade("dh", 0);
					ui_fade("tnt", 0);
					ui_fade("enemy", 0);
					ui_fade("boss", 0);
				}
				with(obj_camera){
					_finalhitTarget = global._hitinst;
					_mode = 2;
					_ampX = 16;
					_ampY = 16;
				}
				with(obj_dh_mask){
					_invframe = 0;
					_freeze = 2;
				}
				for(var i = 0; i < array_length(global._enemyArray); i++){
					with(global._enemyArray[i]){
						_freeze = 2;
					}
				}
				global._finalhit --;
			}
			if(global._finalhit <= 0){
				if(global._finalhit_init){
					with(obj_camera){
						_mode = 1;
					}
					if(global._finalhit_phase){
						with(obj_camera){
							_ampY = 26;
						}
					}
					
					for(var i = 0; i < array_length(global._enemyArray); i++){
						//kill enemies onscreen
						with(global._enemyArray[i]){
							if(variable_instance_exists(self.id, "_scrclearend")){
								if(!_boss){
									_displayobj.visible = true;
									tntko_kill();
								}
							}
						}
					}
					
					with(obj_dh_mask){
						_phasehit = 0;
					}
					with(obj_boss2_mask){
						_phasehit = 0;
					}
					
					global._finalhit_init = false;
				}
				if(!global._finalhit_phase){
					if(layer_exists("lvfg")){
						if(!layer_get_visible("lvfg")){
							layer_set_visible("lvfg", true);
						}
					}
					if(layer_exists("lv_parallaxfg")){
						if(!layer_get_visible("lv_parallaxfg")){
							layer_set_visible("lv_parallaxfg", true);
						}
					}
					with(obj_finalhit){
						instance_destroy();
					}
				}
			}
			if(global._mashZoom){
				if(global._mashZoomTimer > 0){
					global._mashZoomTimer --;
					switch(global._mashZoomMode){
						case 0:
							global._cameraZoom = 0.85;
							global._camZoomSpd = 0.08;
						break;
						case 1:
							global._cameraZoom = 1.2;
							global._camZoomSpd = 0.019;
						break;
						case 2:
							global._cameraZoom = 0.75;
							global._camZoomSpd = 0.18;
						break;
					}
				} else {
					global._mashinst = noone;
					global._mashZoomMode = 0;
					global._mashZoom = false;
					global._camZoomSpd = global._defaultCamSpd;
					global._cameraOffset = [global._defCamOffset[0], global._defCamOffset[1]];;
				}
			}
			
			if(global._tntZoom){
				if(global._tntZoomTimer > 0){
					global._tntZoomTimer --;
					if(global._tntZoomState == 0){
						global._cameraZoom = 0.72;
						global._camZoomSpd = 0.06;
					} else if(global._tntZoomState == 1){
						global._cameraZoom = global._defCamZoom;
						global._camZoomSpd = 0.5;
					}
				} else {
					global._tntZoomState = 0;
					global._mashinst = noone;
					global._tntZoom = false;
				}
			}
			
			if(global._delayspawn > 0){
				global._delayspawn --;
			}
		}
		
		//foreground/background scrolling
		if(_init){
			if(layer_exists("lv_parallaxfg")){
				var elements = layer_get_all_elements(layer_get_id("lv_parallaxfg"));
				for(var i = 0; i < array_length(elements); i++){
					layer_sprite_x(elements[i], _fglayerx[i]+global._cameraX*global._fgScrollSpd);
				}
			}
			for(var l = 0; l < 2; l++){
				if(layer_exists("lv_parallaxbg"+string(l+1))){
					var elements = layer_get_all_elements(layer_get_id("lv_parallaxbg"+string(l+1)));
					for(var i = 0; i < array_length(elements); i++){
						layer_sprite_x(elements[i], _bglayerx[l][i]+global._cameraX*global._bgScrollSpd[l]);
					}
				}
			}
		}
	}
	
	//depth sorting and sound delay
	with(all){
		if(variable_instance_exists(self, "_sort")){
			if(_sort){
				depth = -(y-global._cameraY);
				if(variable_instance_exists(self, "_depthoffset")){
					depth = -((y-global._cameraY)+_depthoffset);
				}
			}
			if(variable_instance_exists(self, "_forcedepth")){
				if(_forcedepth <> 0){
					depth = _forcedepth;
				}
			}
		}
		
		if(global._buildver != HTML){
			if(!global._pause){
				if(variable_instance_exists(self, "_allsounds")){
					if(_allsounds != undefined && _allsounds != -1){
						if(ds_map_exists(_allsounds, "delay")){
							if(string_starts_with(audio_get_name(_allsounds[? "delay"][0]), "snd_dh_voice_")){
								ds_map_delete(_allsounds, "delay");
								ds_map_delete(_allsounds, "delay_cur");
							} else {
								if(string_starts_with(audio_get_name(_allsounds[? "delay"][0]), "snd_lanky_") ||
								audio_sound_length(_allsounds[? "delay"][0]) <= 1.5){
									if(_allsounds[? "delay"][1] > 0){
										_allsounds[? "delay"][1] --;
									} else {
										if(_allsounds[? "delay"][3] >= 1){
											if(ds_map_exists(_allsounds, "delay_cur") && _allsounds[? "delay_cur"] != undefined){
												audio_stop_sound(_allsounds[? "delay_cur"]);
											}
											_allsounds[? "delay_cur"] = sfx_play(_allsounds[? "delay"][0],_allsounds[? "delay"][2],false,true);
											_allsounds[? "delay"][1] = 12;
											_allsounds[? "delay"][2] *= 0.5;
											_allsounds[? "delay"][3] --;
										} else {
											ds_map_delete(_allsounds, "delay");
											ds_map_delete(_allsounds, "delay_cur");
										}
									}
								} else {
									ds_map_delete(_allsounds, "delay");
									ds_map_delete(_allsounds, "delay_cur");
								}
							}
						}
					}
				}
			}
		}
	}
	
	if(global._borderless_cdown > 0){
		global._borderless_cdown --;
	}
	
	//fullscreen
	if(global._buildver == WINDOWS){
		if(keyboard_check_pressed(vk_f4)){
			global._drawBlackScreen = 2;
			
			if(!global._full){
				global._full = true;
				global._borderless = window_get_borderless_fullscreen();
			} else {
				global._scrtype = 0;
				global._full = false;
			}
			
			if(global._full && !global._borderless){
				global._scrtype = 1;
			} else if(global._full && global._borderless){
				global._scrtype = 2;
			}
			scr_savevalue(global._scrtype,"Fullscreen",_settingsfile,"Video",true,true);
		}
		
		//borderless fullscreen
		if(global._full){
			if((global._borderless && !window_get_borderless_fullscreen()) || (!global._borderless && window_get_borderless_fullscreen())){
				window_enable_borderless_fullscreen(global._borderless);
			}
		} else {
			if(window_get_borderless_fullscreen()){
				global._borderless = false;
				window_enable_borderless_fullscreen(global._borderless);
			}
		}
		
		if(global._borderless_cdown <= 0){
			if(global._full && !window_get_fullscreen()){
				global._dowindow = false;
				window_set_fullscreen(true);
				display_reset(global._all_aa[global._aa_filter], global._vsync);
				scr_adjustguiscale();
				alarm_set(1,2);
			} else if(!global._full && window_get_fullscreen()){
				global._dowindow = false;
				window_set_fullscreen(false);
				display_reset(global._all_aa[global._aa_filter], global._vsync);
				scr_adjustguiscale();
				alarm_set(1,2);
			}
		}
	}
	if(global._buildver == HTML){
		if(!_htmladjust){
			alarm_set(0,1);
			_htmladjust = true;
		}
	}
	
	//restart
	if(global._debug){
		if(keyboard_check_pressed(vk_f2)){
			global._loadState = "start";
			with(obj_music){
				global.music_bus.effects[0] = undefined;
			}
			audio_stop_all();
			room_goto(room_first);
		}
	}
	
	global._padaxis[0][0] = gamepad_axis_value(global._padnum, gp_axislh);
	global._padaxis[0][1] = gamepad_axis_value(global._padnum, gp_axislv);
	
	global._padaxis[1][0] = gamepad_axis_value(global._padnum, gp_axisrh);
	global._padaxis[1][1] = gamepad_axis_value(global._padnum, gp_axisrv);

	if(global._pausebackcooldown > 0){
		global._pausebackcooldown --;
	} else if(global._pausebackcooldown < 0){
		global._pausebackcooldown = 0;
	}

	//pausing
	if(global._state == "game"){
		if(!global._winscreen && global._pausebackcooldown <= 0 && !global._pauseoptions){
			var maxind = 1;
			if(global._padfound){
				maxind = 2;
			}
			for(var inp = 0; inp < maxind; inp++){
				if(check_keypress(global._input[inp][? "pause"], inp)){
					var elements;
					if(layer_exists("lvbg1")){
						elements = layer_get_all_elements(layer_get_id("lvbg1"));
					} else {
						elements = [];
					}
					if(!global._pause){
						sfx_pause_all(true);
						for(var i = 0; i < array_length(elements); i++){
							layer_sprite_speed(elements[i], 0);
						}
						_curOpt = 0;
						
						global._storeEffect = global.music_bus.effects[0];
						if(global._cursong != -1){
							with(obj_pause){
								_muspos = audio_sound_get_track_position(global._cursong);
							}
							global._musicPos[? audio_get_name(global._cursong)] = audio_sound_get_track_position(global._cursong);
						}
						mus_stop();
						mus_play(mus_pause);
						global.music_bus.effects[0] = undefined;
					
						global._pause = true;
					} else {
						sfx_pause_all(false);
						for(var i = 0; i < array_length(elements); i++){
							layer_sprite_speed(elements[i], 1);
						}
					
						mus_stop();
						with(obj_music){
							_musicstart = true;
							_musicinit = false;
							_resumepos = true;
						}
					
						global._pause = false;
					}
				}
			}
		}
	}
	
	//other
	if(global._stopFog > 0){
		global._stopFog --;
	}
	
	//debug
	if(global._debug){
		if(keyboard_check_pressed(vk_tab)){
			global._showDebug ++;
			if(global._showDebug >= 3){
				global._showDebug = 0;
			}
		}
		
		if(keyboard_check(vk_shift)){
			if(keyboard_check_pressed(ord("1"))){
				audio_stop_all();
				room_goto(r_debug);
			}
		}
		
		if(keyboard_check(vk_alt)){
			if(keyboard_check_pressed(ord("Q"))){
				if(!global._showHitbox){
					global._showHitbox = true;
				} else {
					global._showHitbox = false;
				}
			}
			
			if(keyboard_check_pressed(ord("E"))){
				if(!global._freeRoam){
					global._freeRoam = true;
				} else {
					global._freeRoam = false;
				}
			}
			
			if(keyboard_check_pressed(ord("P"))){
				if(!global._debughidepause){
					global._debughidepause = true;
				} else {
					global._debughidepause = false;
				}
			}
			
			if(keyboard_check_pressed(ord("K"))){
				global._knockouts ++;
			}
			
			if(keyboard_check_pressed(ord("T"))){
				global._showTexGroupDebug = !global._showTexGroupDebug;
			}
			
			if(keyboard_check_pressed(ord("M"))){
				global._showMemoryDebug = !global._showMemoryDebug;
				if(global._showMemoryDebug){
					//count ds maps and sequence layers
					_dbg_mapcount = 0;
					for(var i = 0; i < 10000; i++){
						if(ds_exists(i, ds_type_map)){
							_dbg_mapcount++;
						}
					}
					_dbg_layercount = 0;
					if(variable_global_exists("_sequenceLayers")){
						if(global._sequenceLayers != -1){
							var seqlayers = ds_map_keys_to_array(global._sequenceLayers);
							_dbg_layercount = array_length(seqlayers);
						}
					}
				}
			}
		}
		
		if(keyboard_check(ord("T"))){
			global._tntjuice += 5;
			if(global._tntjuice >= global._tntjuice_max){
				global._tntjuice = global._tntjuice_max;
			}
			with(obj_game){
				ui_fade("tnt", 1);
			}
		}
		
		//battlezone maker
		if(global._state == "game"){
				if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("B"))){
				if(!global._bzmaker){
					global._bzmaker = true;
				} else {
					global._bzmaker = false;
				}
			}
		} else {
			global._bzmaker = false;
		}
		
		if(!global._pause && global._bzmaker && global._battlezone){
			if(global._battleobj != noone && instance_exists(global._battleobj)){
				if(array_length(global._battleobj._enemies) == 0){
					array_push(global._battleobj._enemies, []);
				}
				
				if(global._cameraZoom <> 0){
					_bzmousepos = [mouse_x,mouse_y];
				}
				
				if(!_bzpopup){
					//battlezone maker inputs
					if(keyboard_check_pressed(vk_add)){
						array_push(global._bzone_enemies, []);
					} else if(keyboard_check_pressed(vk_subtract)){
						if(array_length(global._bzone_enemies) > 1){
							array_pop(global._bzone_enemies);
						}
					}
					
					//hovering
					if(_hovertimer > 0){
						_hovertimer --;
					} else {
						_hover_enm = noone;
					}
				} else {
					if(_hover_enm != noone && instance_exists(_hover_enm)){
						_hover_enm._drag = false;
					}
					_hover_enm = noone;
					_hovertimer = 0;
				}
				
				if(instance_number_array(global._enemyArray) == 0 && mouse_check_button_pressed(mb_left)){
					if(_hover_enm != noone && instance_exists(_hover_enm)){
						_hover_enm._dragoffset = [_hover_enm.x-mouse_x,_hover_enm.y-mouse_y];
						_hover_enm._drag = true;
						_last_enm = _hover_enm;
					} else {
						if(!_bzpopup){
							//open spawn popup
							if(global._cameraZoom <> 0){
								_bz_mousestart = [(mouse_x-camera_get_view_x(global._camera))/global._cameraZoom, (mouse_y-camera_get_view_y(global._camera))/global._cameraZoom];
							}
							_bzone_enm = instance_create_depth(_bzmousepos[0],_bzmousepos[1], 0, obj_bzone_enemy);
							_last_enm = _bzone_enm;
							_popupopt = -1;
							_bzpopup = true;
						} else {
							if(_popupopt != -1){
								//spawn enemy
								if(_bzone_enm != noone && instance_exists(_bzone_enm)){
									var mask;
									if(global._bzenemies[_popupopt].masksprite == ""){
										mask = asset_get_index("spr_"+global._bzenemies[_popupopt].maskname+"_mask");
									} else {
										mask = asset_get_index(global._bzenemies[_popupopt].masksprite);
									}
									
									_bzone_enm._wave = global._battleobj._curwave;
									_bzone_enm._index = array_length(global._bzone_enemies[global._battleobj._curwave]);
									_bzone_enm.sprite_index = mask;
									_bzone_enm.mask_index = mask;
									_bzone_enm._disp_index = asset_get_index("spr_"+global._bzenemies[_popupopt].maskname+"_idle");
									_bzone_enm._alts = global._bzenemies[_popupopt].alts;
									if(!is_array(global._bzenemies[_popupopt].disp)){
										if(global._bzenemies[_popupopt].disp != ""){
											_bzone_enm._disp_index = asset_get_index(global._bzenemies[_popupopt].disp);
										}
									} else {
										_bzone_enm._disp_index = asset_get_index(global._bzenemies[_popupopt].disp[0]);
										_bzone_enm._imgindex = global._bzenemies[_popupopt].disp[1];
									}
									
									_bzone_enm._codename = global._bzenemies[_popupopt].maskname;
									if(global._bzenemies[_popupopt].codename != ""){
										_bzone_enm._codename = global._bzenemies[_popupopt].codename;
									}
									
									var temparray = [];
									array_push(temparray,"c"); //dir
									
									var posarray = [];
				
									array_push(posarray,(global._battleobj._bzSize[0]/2)+(_bzone_enm.x-global._battleobj.x));
									array_push(posarray,(global._battleobj._bzSize[1]/2)+(_bzone_enm.y-global._battleobj.y));
									
									array_push(temparray,posarray); //pos
									
									array_push(temparray, 0); //order
									
									if(!global._bzenemies[_popupopt].obj){
										array_push(temparray, [global._bzenemies[_popupopt].maskname,-1]);
									} else {
										array_push(temparray, [global._bzenemies[_popupopt].maskname,"obj",-1]);
									}
									
									array_push(global._bzone_enemies[global._battleobj._curwave], temparray);
									
									_bzpopup = false;
								}
							} else {
								//cancel
								instance_destroy(_bzone_enm.id);
								_bzone_enm = noone;
								_bzpopup = false;
							}
						}
					}
				} else if(mouse_check_button_pressed(mb_right)){
					//destroy spawned enemy_or
					if(!_bzpopup && _hover_enm != noone && instance_exists(_hover_enm)){
						if(!_hover_enm._die){
							global._bzone_enemies[global._battleobj._curwave][_hover_enm._index] = [];
							instance_destroy(_hover_enm);
							_hover_enm = noone;
							_last_enm = noone;
							_hovertimer = 0;
						}
					}
				}
				if(!mouse_check_button(mb_left)){
					with(obj_bzone_enemy){
						_drag = false;
					}
				}
				
				//change alt
				if(mouse_wheel_up()){
					if(_last_enm != noone && instance_exists(_last_enm) && _last_enm._alts){
						if(!_last_enm._die){
							_last_enm._enmtype ++;
							if(_last_enm._enmtype > 1){
								_last_enm._enmtype = -1;
							}
							_last_enm._colorsinit = false;
						
							with(_last_enm){
								if(array_length(global._bzone_enemies[global._battleobj._curwave][_index][3]) == 2){
									global._bzone_enemies[global._battleobj._curwave][_index][3][1] = _enmtype;
								} else if(array_length(global._bzone_enemies[global._battleobj._curwave][_index][3]) == 3){
									global._bzone_enemies[global._battleobj._curwave][_index][3][2] = _enmtype;
								}
							}
						}
					}
				} else if(mouse_wheel_down()){
					if(_last_enm != noone && instance_exists(_last_enm) && _last_enm._alts){
						if(!_last_enm._die){
							_last_enm._enmtype --;
							if(_last_enm._enmtype < -1){
								_last_enm._enmtype = 1;
							}
							_last_enm._colorsinit = false;
						
							with(_last_enm){
								if(array_length(global._bzone_enemies[global._battleobj._curwave][_index][3]) == 2){
									global._bzone_enemies[global._battleobj._curwave][_index][3][1] = _enmtype;
								} else if(array_length(global._bzone_enemies[global._battleobj._curwave][_index][3]) == 3){
									global._bzone_enemies[global._battleobj._curwave][_index][3][2] = _enmtype;
								}
							}
						}
					}
				}
				
				if(keyboard_check_pressed(ord("Q"))){
					if(_last_enm != noone && instance_exists(_last_enm)){
						if(!_last_enm._die){
							_last_enm._order --;
							if(_last_enm._order < 0){
								_last_enm._order = 0;
							}
							with(_last_enm){
								global._bzone_enemies[global._battleobj._curwave][_index][2] = _order;
							}
						}
					}
				} else if(keyboard_check_pressed(ord("W"))){
					if(_last_enm != noone && instance_exists(_last_enm)){
						if(!_last_enm._die){
							_last_enm._order ++;
							if(_last_enm._order > 999){
								_last_enm._order = 999;
							}
							with(_last_enm){
								global._bzone_enemies[global._battleobj._curwave][_index][2] = _order;
							}
						}
					}
				}
				
				if(keyboard_check_pressed(ord("R"))){
					if(_last_enm != noone && instance_exists(_last_enm)){
						if(!_last_enm._die){
							_last_enm._spawntype --;
							if(_last_enm._spawntype < 0){
								_last_enm._spawntype = 0;
							}
							with(_last_enm){
								global._bzone_enemies[global._battleobj._curwave][_index][5] = _spawntype;
							}
						}
					}
				} else if(keyboard_check_pressed(ord("T"))){
					if(_last_enm != noone && instance_exists(_last_enm)){
						if(!_last_enm._die){
							_last_enm._spawntype ++;
							with(_last_enm){
								global._bzone_enemies[global._battleobj._curwave][_index][5] = _spawntype;
							}
						}
					}
				}
				
				if(keyboard_check_pressed(ord("Y"))){
					if(_last_enm != noone && instance_exists(_last_enm)){
						if(!_last_enm._die){
							_last_enm._startFade = !_last_enm._startFade;
							with(_last_enm){
								global._bzone_enemies[global._battleobj._curwave][_index][4] = _startFade;
							}
						}
					}
				}
				
				if(keyboard_check_pressed(vk_enter)){
					if(!_bzpopup && !global._bzactive){
						//activate all enemies
						global._battleobj._enemies = [];
						for(var r = 0; r < array_length(global._bzone_enemies); r++){
							global._battleobj._enemies[r] =	global._bzone_enemies[r];
						}
						with(obj_bzone_enemy){
							_die = true;
						}
						global._battleobj._waveinit = false;
						global._bzactive = true;
					}
				}
				
				//log spawn information
				if(keyboard_check_pressed(vk_shift)){
					if(!global._bzactive){
						show_debug_message("--- BATTLEZONE SPAWN INFORMATION "+ string(global._timer) +" ---");
						show_debug_message("_enemies = [");
						for(var i = 0; i < array_length(global._bzone_enemies); i++){
							//waves
							if(array_length(global._bzone_enemies[i]) > 0){
								show_debug_message("	[");
								for(var o = 0; o < array_length(global._bzone_enemies[i]); o++){
									//enemies
									if(array_length(global._bzone_enemies[i][o]) > 0){
										show_debug_message("		"+string(global._bzone_enemies[i][o])+",");
									}
								}
								show_debug_message("	],");
							}
						}
						show_debug_message("]");
						show_debug_message("--- ---");
					}
				}
			}
		}
	}
	
	if(global._fadeout){
		global._fadeout_alp += 0.02;
		
		ui_fade("dh", 0);
		ui_fade("tnt", 0);
		
		if(global._fadeout_alp >= 1.6){
			if(global._tutorial){
				audio_stop_all();
				global._loadState = "tomenu";
				room_goto(r_loading);
			}
		}
	}
	
	if(variable_global_exists("_speedruntimer")){
		if(!global._pause){
			global._speedruntimer ++;
		}
		
		if(global._location == 1){
			if(global._speedruntimer <= 23194){ //6 min 26 sec
				global._easteregg_lank = true;
			} else {
				global._easteregg_lank = false;
			}
		}
	}
}