{	
	if(global._buildver == WINDOWS){
		window_set_size(global._res[global._curres][0],global._res[global._curres][1]);
	} else if(global._buildver == HTML){
		global._curres = 0;
		window_set_size(HTML_W,HTML_H);
	}
	if(!global._setdisp){
		display_reset(0, global._vsync);
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
	
	var mousestates = ["menu","game","minigame","comics"];
	for(var i = 0; i < array_length(mousestates); i++){
		if(global._pause && global._state == mousestates[i]){
			if(!global._menumouse){
				global._forcecustorstop = 2;
			}
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
		
		if(global._debug){
			instance_create_depth(0,0,0,obj_debug);
			instance_create_depth(0,0,0,obj_bz_maker);
		}
		
		switch(global._state){
			case "htmlinit":
				room_goto(r_gameintro);
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
					global._kills = 0;
					global._kills_prev = 0;
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
						with(obj_st2_rain){
							_rainactive = true;
						}
						with(obj_st2_rain_floor){
							_rainactive = true;
						}
						
						global._stageentrance = false;
					}
				} else {
					global._moneypickups.cur = global._moneypickups.prev;
					global._plusmoney.cur = global._plusmoney.prev;
					global._kills = global._kills_prev;
					global._stageentrance = false;
					ds_map_copy(global._deletedStuff, global._deletedStuffPrev);
				}
				global._deleteready = true;
			
				instance_create_depth(0,0,0,obj_gui);
				instance_create_depth(0,0,0,obj_pause);
				instance_create_depth(0,0,0,obj_prompts);
				instance_create_depth(0,0,0,obj_vsscreen);
				instance_create_depth(0,0,0,obj_bg);
				instance_create_depth(0,0,0,obj_fade);
				instance_create_depth(-WIDTH,-HEIGHT,0,obj_dialogue);
				instance_create_depth(0,0,0,obj_lighting);
				instance_create_depth(0,0,0,obj_kohit);
				instance_create_depth(0,0,0,obj_enm_manager);
				instance_create_depth(0,0,0,obj_layers);
				instance_create_depth(0,0,0,obj_groovylights);
				
				for(var l = 0; l < array_length(_layers_info); l++){
					if(layer_exists(_layers_info[l][0])){
						_store_layer_x[l] = layer_get_x(_layers_info[l][0]);
					}
				}
				if(layer_exists("lv_parallaxfg")){
					var elements = layer_get_all_elements(layer_get_id("lv_parallaxfg"));
					for(var i = 0; i < array_length(elements); i++){
						layer_sprite_x(elements[i], (layer_sprite_get_x(elements[i])/(-global._fgScrollSpd))*0.6);
					}
				}
			break;
			case "intro":
				instance_create_depth(0,0,0,obj_stageintro);
			break;
			case "dead":
				instance_create_depth(global._playerX,global._playerY,0,obj_dynamitedead);
				instance_create_depth(0,0,0,obj_lost);
			break;
			case "minigame":
				instance_create_depth(0,0,0,obj_pause);
			
				var obj_ = asset_get_index("obj_mg_"+global._minigame);
				if(object_exists(obj_)){
					instance_create_depth(0,0,0,obj_);
				}
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
				with(obj_gui){
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
			for(var l = 0; l < array_length(_layers_info); l++){
				if(layer_exists(_layers_info[l][0])){
					layer_x(_layers_info[l][0], _store_layer_x[l]+global._cameraX*_layers_info[l][1]);
				}
			}
		}
	}
	
	//main game events
	if(!global._pause){
		if(global._state == "game"){
			if(global._flashbang > 0){
				if(global._flashbang <= 30){
					_flashalp -= 0.08;
				}
				global._flashbang --;
			}
			
			//gamepads
			if(global._padtime > 0){
				global._padtime --;
				
				_gp_alp = 1;
				if(global._padtime <= 100){
					_gp_alp = global._padtime/100;
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
				display_reset(0, global._vsync);
				scr_adjustguiscale();
				alarm_set(1,2);
			} else if(!global._full && window_get_fullscreen()){
				global._dowindow = false;
				window_set_fullscreen(false);
				display_reset(0, global._vsync);
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
	
	global._padaxis[0][0] = gamepad_axis_value(global._padnum, gp_axislh);
	global._padaxis[0][1] = gamepad_axis_value(global._padnum, gp_axislv);
	
	global._padaxis[1][0] = gamepad_axis_value(global._padnum, gp_axisrh);
	global._padaxis[1][1] = gamepad_axis_value(global._padnum, gp_axisrv);

	//other
	if(global._stopFog > 0){
		global._stopFog --;
	}
	
	if(global._fadeout){
		global._fadeout_alp += 0.02;
		
		with(obj_gui){
			ui_fade("dh", 0);
			ui_fade("tnt", 0);
		}
		
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