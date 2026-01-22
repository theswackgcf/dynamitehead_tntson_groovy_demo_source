function scr_draw_options_btn(){
	if(!_pausebtn){
		if(_optionsobj._show && _optionsobj._state == _state){
			_on = false;
			if(_optionsobj._curopt[_layer] = _opt){
				_on = true;
			}
			
			var xoffset;
			var color;
			var alpha;
		
			if(_on){
				scr_textrender_wave_y(global._menuSineAmp, global._menuSineSpd);
				color = global._menuColorYes;
				xoffset = global._menubuttonsin;
				if(_state != "main"){
					color = #FFFFFF;
					xoffset = 0;
					alpha = 1;
				}
				_optionsobj._curbutton = self;
			
				if(_action != ""){
					switch(_action){
						//decrease volume action
						case "leftvol":
							switch(_opt){
								case 1:
									var dispstr = "Master";
									global._masterVolume -= 0.05;
									global._masterVolume = clamp(global._masterVolume, 0, 1);
									if(global._masterVolume > 0 && global._masterVolume < 1){
										with(_optionsobj){
											sfx_stop_array(_menuobj._sndarray);
											sfx_play_choose(_menuobj._sndarray);
										}
										voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
									}
									audio_sound_gain(global._cursong, global._curSongGain, 0);
										
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._masterVolume > 0){
											global._storeSliders[? dispstr] = global._masterVolume;
										}
									}
										
									scr_savevalue(global._masterVolume, dispstr, _inifile, "Audio", true, true);
								break;
								case 2:
									var dispstr = "Sound Effects";
									global._sfxVolume -= 0.05;
									global._sfxVolume = clamp(global._sfxVolume, 0, 1);
									if(global._sfxVolume > 0 && global._sfxVolume < 1){
										with(_optionsobj){
											sfx_stop_array(_menuobj._sndarray);
											sfx_play_choose(_menuobj._sndarray);
										}
									}
										
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._sfxVolume > 0){
											global._storeSliders[? dispstr] = global._sfxVolume;
										}
									}
										
									scr_savevalue(global._sfxVolume, dispstr, _inifile, "Audio", true, true);
								break;
								case 3:
									var dispstr = "Voice";
									global._voiceVolume -= 0.05;
									global._voiceVolume = clamp(global._voiceVolume, 0, 1);
									if(global._voiceVolume > 0 && global._voiceVolume < 1){
										voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
									}
										
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._voiceVolume > 0){
											global._storeSliders[? dispstr] = global._voiceVolume;
										}
									}
										
									scr_savevalue(global._voiceVolume, dispstr, _inifile, "Audio", true, true);
								break;
								case 4:
									var dispstr = "Music";
									global._musVolume -= 0.05;
									global._musVolume = clamp(global._musVolume, 0, 1);
									audio_sound_gain(global._cursong, global._curSongGain, 0);
										
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._musVolume > 0){
											global._storeSliders[? dispstr] = global._musVolume;
										}
									}
										
									scr_savevalue(global._musVolume, dispstr, _inifile, "Audio", true, true);
								break;
							}
						break;
						//increase volume action
						case "rightvol":
							switch(_opt){
								case 1:
									var dispstr = "Master";
									global._masterVolume += 0.05;
									global._masterVolume = clamp(global._masterVolume, 0, 1);
									if(global._masterVolume > 0 && global._masterVolume < 1){
										with(_optionsobj){
											sfx_stop_array(_menuobj._sndarray);
											sfx_play_choose(_menuobj._sndarray);
										}
										voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
									}
									audio_sound_gain(global._cursong, global._curSongGain, 0);
										
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._masterVolume > 0){
											global._storeSliders[? dispstr] = global._masterVolume;
										}
									}
										
									scr_savevalue(global._masterVolume, dispstr, _inifile, "Audio", true, true);
								break;
								case 2:
									var dispstr = "Sound Effects";
									global._sfxVolume += 0.05;
									global._sfxVolume = clamp(global._sfxVolume, 0, 1);
									if(global._sfxVolume > 0 && global._sfxVolume < 1){
										with(_optionsobj){
											sfx_stop_array(_menuobj._sndarray);
											sfx_play_choose(_menuobj._sndarray);
										}
									}
										
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._sfxVolume > 0){
											global._storeSliders[? dispstr] = global._sfxVolume;
										}
									}
										
									scr_savevalue(global._sfxVolume, dispstr, _inifile, "Audio", true, true);
								break;
								case 3:
									var dispstr = "Voice";
									global._voiceVolume += 0.05;
									global._voiceVolume = clamp(global._voiceVolume, 0, 1);
									if(global._voiceVolume > 0 && global._voiceVolume < 1){
										voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
									}
										
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._voiceVolume > 0){
											global._storeSliders[? dispstr] = global._voiceVolume;
										}
									}
										
									scr_savevalue(global._voiceVolume, dispstr, _inifile, "Audio", true, true);
								break;
								case 4:
									var dispstr = "Music";
									global._musVolume += 0.05;
									global._musVolume = clamp(global._musVolume, 0, 1);
									audio_sound_gain(global._cursong, global._curSongGain, 0);
										
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._musVolume > 0){
											global._storeSliders[? dispstr] = global._musVolume;
										}
									}
										
									scr_savevalue(global._musVolume, dispstr, _inifile, "Audio", true, true);
								break;
							}
						break;
						//change screentype left
						case "left-scr":
							var dispstr = "Fullscreen";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._scrtype --;
							if(global._scrtype < 0){
								global._scrtype = 2;
							}
								
							switch(global._scrtype){
								case 0:
									global._full = false;
									global._borderless = false;
								break;
								case 1:
									global._full = true;
									global._borderless = false;
									window_set_fullscreen(false);
									global._borderless_cdown = 4;
								break;
								case 2:
									global._full = true;
									global._borderless = true;
									window_set_fullscreen(false);
									global._borderless_cdown = 4;
								break;
							}
								
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._scrtype > 0){
									global._storeSliders[? dispstr] = global._scrtype;
								}
							}
						
							scr_savevalue(global._scrtype, dispstr, _inifile, "Video", true, true);
						break;
						//decrease resolution
						case "left-res":
							var dispstr = "Resolution";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._curres --;
							if(global._curres < 0){
								global._curres = array_length(global._res)-1;
							}
							global._setdisp = false;
						
							scr_adjustguiscale();
								
							global._forcecustorstop = 30;
								
							with(obj_game){
								global._dowindow = false;
								alarm_set(1, 2);
							}
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._curres > 0){
									global._storeSliders[? dispstr] = global._curres;
								}
							}
						
							scr_savevalue(global._curres, dispstr, _inifile, "Video", true, true);
						break;
						//change screentype right
						case "right-scr":
							var dispstr = "Fullscreen";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._scrtype --;
							if(global._scrtype < 0){
								global._scrtype = 2;
							}
								
							switch(global._scrtype){
								case 0:
									global._full = false;
									global._borderless = false;
								break;
								case 1:
									global._full = true;
									global._borderless = false;
									window_set_fullscreen(false);
									global._borderless_cdown = 4;
								break;
								case 2:
									global._full = true;
									global._borderless = true;
									window_set_fullscreen(false);
									global._borderless_cdown = 4;
								break;
							}
								
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._scrtype > 0){
									global._storeSliders[? dispstr] = global._scrtype;
								}
							}
						
							scr_savevalue(global._scrtype, dispstr, _inifile, "Video", true, true);
						break;
						//increase resolution
						case "right-res":
							var dispstr = "Resolution";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._curres ++;
							if(global._curres > array_length(global._res)-1){
								global._curres = 0;
							}
							global._setdisp = false;
						
							scr_adjustguiscale();
								
							global._forcecustorstop = 30;
								
							with(obj_game){
								global._dowindow = false;
								alarm_set(1, 2);
							}
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._curres > 0){
									global._storeSliders[? dispstr] = global._curres;
								}
							}
						
							scr_savevalue(global._curres, dispstr, _inifile, "Video", true, true);
						break;
						//decrease anti-aliasing
						case "left-aa":
							var dispstr = "Anti-Aliasing";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._aa_filter --;
							if(global._aa_filter < 0){
								global._aa_filter = array_length(global._all_aa)-1;
							}
							display_reset(0, global._vsync);
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._aa_filter > 0){
									global._storeSliders[? dispstr] = global._aa_filter;
								}
							}
						
							scr_savevalue(global._aa_filter, dispstr, _inifile, "Video", true, true);
						break;
						//increase anti-aliasing
						case "right-aa":
							var dispstr = "Anti-Aliasing";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._aa_filter ++;
							if(global._aa_filter > array_length(global._all_aa)-1){
								global._aa_filter = 0;
							}
							display_reset(0, global._vsync);
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._aa_filter > 0){
									global._storeSliders[? dispstr] = global._aa_filter;
								}
							}
						
							scr_savevalue(global._aa_filter, dispstr, _inifile, "Video", true, true);
						break;
						//decrease color blending
						case "left-blend":
							var dispstr = "Color Blending";
							global._colorblending -= 0.05;
							if(global._colorblending < 0){
								global._colorblending = 0;
							} else {
								with(_optionsobj){
									sfx_stop_array(_menuobj._sndarray);
									sfx_play_choose(_menuobj._sndarray);
								}
							}
							with(all){
								if(variable_instance_exists(self.id,"_colorsinit")){
									_colorsinit = false;
								}
							}
								
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._colorblending > 0){
									global._storeSliders[? dispstr] = global._colorblending;
								}
							}
						
							scr_savevalue(global._colorblending, dispstr, _inifile, "Video", true, true);
						break;
						//increase color blending
						case "right-blend":
							var dispstr = "Color Blending";
							global._colorblending += 0.05;
							if(global._colorblending > 1){
								global._colorblending = 1;
							} else {
								with(_optionsobj){
									sfx_stop_array(_menuobj._sndarray);
									sfx_play_choose(_menuobj._sndarray);
								}
							}
							with(all){
								if(variable_instance_exists(self.id,"_colorsinit")){
									_colorsinit = false;
								}
							}
								
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._colorblending > 0){
									global._storeSliders[? dispstr] = global._colorblending;
								}
							}
						
							scr_savevalue(global._colorblending, dispstr, _inifile, "Video", true, true);
						break;
						//decrease screenshake
						case "left-shake":
							var dispstr = "Screenshake";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._shakeval --;
							if(global._shakeval < 0){
								global._shakeval = array_length(global._shakevals)-1;
							}
							with(obj_camera){
								_ampX = 16;
								_ampY = 16;
							}
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._shakeval > 0){
									global._storeSliders[? dispstr] = global._shakeval;
								}
							}
						
							scr_savevalue(global._shakeval, dispstr, _inifile, "Video", true, true);
						break;
						//increase screenshake
						case "right-shake":
							var dispstr = "Screenshake";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._shakeval ++;
							if(global._shakeval > array_length(global._shakevals)-1){
								global._shakeval = 0;
							}
							with(obj_camera){
								_ampX = 16;
								_ampY = 16;
							}
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._shakeval > 0){
									global._storeSliders[? dispstr] = global._shakeval;
								}
							}
						
							scr_savevalue(global._shakeval, dispstr, _inifile, "Video", true, true);
						break;
							
						//decrease freeze effect
						case "left-freeze":
							var dispstr = "Freeze Frame Intensity";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._freezeval --;
							if(global._freezeval < 0){
								global._freezeval = array_length(global._freezevals)-1;
							}
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._freezeval > 0){
									global._storeSliders[? dispstr] = global._freezeval;
								}
							}
						
							scr_savevalue(global._freezeval, dispstr, _inifile, "Game", true, true);
						break;
						//increase freeze effect
						case "right-freeze":
							var dispstr = "Freeze Frame Intensity";
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							global._freezeval ++;
							if(global._freezeval > array_length(global._freezevals)-1){
								global._freezeval = 0;
							}
								
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._freezeval > 0){
									global._storeSliders[? dispstr] = global._freezeval;
								}
							}
								
							scr_savevalue(global._shakeval, dispstr, _inifile, "Game", true, true);
						break;
							
						//change input
						case "change-inp":
							with(_optionsobj){
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
							}
							if(global._inptype == 0){
								scr_gamepadasync("discovered");
							} else if(global._inptype == 1){
								scr_gamepadasync("lost");
							}
						break;
						//decrease deadzone
						case "left-dz":
							var dispstr = "Gamepad Deadzone";
							if(global._sensitivity > 0.05 && global._sensitivity < 0.95){
								with(_optionsobj){
									sfx_stop_array(_menuobj._sndarray);
									sfx_play_choose(_menuobj._sndarray);
								}
							}
							global._sensitivity -= 0.05;
							global._sensitivity = clamp(global._sensitivity, 0.05, 0.95);
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._sensitivity > 0){
									global._storeSliders[? dispstr] = global._sensitivity;
								}
							}
						
							scr_savevalue(global._sensitivity, dispstr, _inifile, "Controls", true, true);
						break;
						//increase deadzone
						case "right-dz":
							var dispstr = "Gamepad Deadzone";
							if(global._sensitivity > 0.05 && global._sensitivity < 0.95){
								with(_optionsobj){
									sfx_stop_array(_menuobj._sndarray);
									sfx_play_choose(_menuobj._sndarray);
								}
							}
							global._sensitivity += 0.05;
							global._sensitivity = clamp(global._sensitivity, 0.05, 0.95);
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._sensitivity > 0){
									global._storeSliders[? dispstr] = global._sensitivity;
								}
							}
						
							scr_savevalue(global._sensitivity, dispstr, _inifile, "Controls", true, true);
						break;
						//decrease rumble
						case "left-rmbl":
							var dispstr = "Rumble Intensity";
							if(global._rumble > 0 && global._rumble < 1){
								with(_optionsobj){
									sfx_stop_array(_menuobj._sndarray);
									sfx_play_choose(_menuobj._sndarray);
								}
									
								global._pad_vibrate = 4;
							}
							
							global._rumble -= 0.05;
							global._rumble = clamp(global._rumble, 0, 1);
						
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._rumble > 0){
									global._storeSliders[? dispstr] = global._rumble;
								}
							}
						
							scr_savevalue(global._rumble, dispstr, _inifile, "Controls", true, true);
						break;
						//increase rumble
						case "right-rmbl":
							var dispstr = "Rumble Intensity";
							if(global._rumble > 0 && global._rumble < 1){
								with(_optionsobj){
									sfx_stop_array(_menuobj._sndarray);
									sfx_play_choose(_menuobj._sndarray);
								}
									
								global._pad_vibrate = 4;
							}
							
							global._rumble += 0.05;
							global._rumble = clamp(global._rumble, 0, 1);
								
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._rumble > 0){
									global._storeSliders[? dispstr] = global._rumble;
								}
							}
								
							scr_savevalue(global._rumble, dispstr, _inifile, "Controls", true, true);
						break;
					}
					_action = "";
				}
			} else {
				scr_textrender_wave_y(0, 0);
				color = global._menuColorNo;
				xoffset = 0;
				if(_state != "main"){
					color = #656565;
					alpha = 0.7;
				}
			}
		
			_ypos = _starty + _optionsobj._offsetYLerp;
		
			if(!_optionsobj._getinput){
				if(global._tntmenuAct == 0 && global._inactivecursor < global._inactivecursortime && _optionsobj._mouseactive && _optionsobj._timer >= 1 && !_optionsobj._enter && _optionsobj._state == _state && diff(_optionsobj._offsetY, _optionsobj._offsetYLerp) <= 16){
					if(!_hover){
						if(scr_mousehover(_bbox[0]+_stretchleft,_bbox[1],_bbox[2]+_stretchright,_bbox[3]+_stretchbottom, true)){
							_hover = true;
							_optionsobj._prevopt[_layer] = _optionsobj._curopt[_layer];
							_optionsobj._curopt[_layer] = _opt;
							with(_optionsobj){
								_curind = other._id;
								_keyup = 8;
								_keydown = 8;
							}
						}
					} else {
						if(!scr_mousehover(_bbox[0]+_stretchleft,_bbox[1],_bbox[2]+_stretchright,_bbox[3]+_stretchbottom, true)){
							_hover = false;
						}
					}
					if(_hover && mouse_check_button_pressed(mb_left)){
						//confirm
						with(_optionsobj){
							//_mouselect = 2;
							checkmenus();
						}
					}
				}
			}
		
			//debug
			/*draw_set_color(#00FF00);
			draw_rectangle(_bbox[0]+_stretchleft,_bbox[1],_bbox[2]+_stretchright,_bbox[3]+_stretchbottom, false);
			draw_set_color(#FFFFFF);*/
		
			if(_id == "scr" || _id == "vsync" || _id == "filter" || _id == "unfocused_mute"){
				xoffset = -28;
				_stretchleft = -32;
				_stretchright = 112;
				if(_id == "filter"){
					_stretchleft = -50;
					_stretchright = 132;
				}
			}
		
			if(_id == "scr"){
				xoffset = 0;
			}
			if(_id == "inptype"){
				xoffset = -18;
			}
		
			if(_id == "inp"){
				_stretchleft = -180;
				_stretchright = 180;
			}
				
			if(_id == "mouse" || _id == "kd" || _id == "tips"){
				xoffset = -42;
				_stretchright = 100;
			}
		
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			scr_textrender_switchfont("dh_font2");
			if(_state != "main"){
				scr_textrender_switchfont("dh_font2_big");
			}
		
			if(!_optionsobj._getinput){
				if(_btnonscreen){
					if(_id == "inp"){
						scr_textrender_type(_xpos+global._screenOffsetX+xoffset-140-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], _text, true, color);
						scr_textrender_type(_xpos+global._screenOffsetX+xoffset+200-_surfaceoffs[0], _ypos+global._screenOffsetY+24-_surfaceoffs[1], "keycode@"+string(_input)+"keycode", false, color, alpha);
					} else {
						scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], _text, true, color, 1, _maintextscale, _maintextscale);
					}
				}
			}
		
			if(!_optionsobj._getinput){
				switch(_id){
					case "vol":
						var vol = 0;
						switch(_opt){
							case 1:
								//master
								vol = clamp(global._masterVolume*10, 0, 10);
							break;
							case 2:
								//sfx
								vol = clamp(global._sfxVolume*10, 0, 10);
							break;
							case 3:
								//voice
								vol = clamp(global._voiceVolume*10, 0, 10);
							break;
							case 4:
								//music
								vol = clamp(global._musVolume*10, 0, 10);
							break;
						}
						if(_btnonscreen){
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], "keycode@LEFTkeycode             keycode@RIGHTkeycode", false, color, alpha);
							draw_sprite_ext(spr_menu_volume, vol, _xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+76-_surfaceoffs[1], 1, 1, 0, color, 1);
							scr_textrender_switchfont("dh_font2");
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+135-_surfaceoffs[1], string(round(vol*10))+"/100", true, color);
							scr_textrender_switchfont("dh_font2_big");
						}
					break;
					case "scr":
						if(_btnonscreen){
							var scrvalues = ["Windowed","Fullscreen","Borderless"];
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+110-_surfaceoffs[1], "keycode@LEFTkeycode              keycode@RIGHTkeycode", false, color, alpha);
							scr_textrender_switchfont("dh_font2");
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], scrvalues[global._scrtype], true, color, alpha, 1.5,1.5);
							scr_textrender_switchfont("dh_font2_big");
						}
					break;
					case "res":
						if(_btnonscreen){
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+110-_surfaceoffs[1], "keycode@LEFTkeycode             keycode@RIGHTkeycode", false, color, alpha);
							scr_textrender_switchfont("dh_font2");
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], string(global._res[global._curres][0])+"x"+string(global._res[global._curres][1]), true, color);
							scr_textrender_switchfont("dh_font2_big");
						}
					break;
					case "vsync":
						var getvsync;
						if(!global._vsync){
							getvsync = 0;
						} else {
							getvsync = 1;
						}
						if(_btnonscreen){
							draw_sprite_ext(spr_menu_checkbox, getvsync, _xpos+global._screenOffsetX+xoffset+190-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], 1.4, 1.4, 0, color, 1);
						}
					break;
					case "filter":
						var getfilter;
						if(!global._texfilter){
							getfilter = 0;
						} else {
							getfilter = 1;
						}
						if(_btnonscreen){
							draw_sprite_ext(spr_menu_checkbox, getfilter, _xpos+global._screenOffsetX+xoffset+295-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], 1.4, 1.4, 0, color, 1);
						}
					break;
					case "unfocused_mute":
						var getmute;
						if(!global._unfocusedmute){
							getmute = 0;
						} else {
							getmute = 1;
						}
						if(_btnonscreen){
							draw_sprite_ext(spr_menu_checkbox, getmute, _xpos+global._screenOffsetX+xoffset+330-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], 1.4, 1.4, 0, color, 1);
						}
					break;
					case "aa":
						if(_btnonscreen){
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+110-_surfaceoffs[1], "keycode@LEFTkeycode             keycode@RIGHTkeycode", false, color, alpha);
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], string(global._all_aa[global._aa_filter]), true, color);
						}
					break;
					case "blend":
						if(_btnonscreen){
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+110-_surfaceoffs[1], "keycode@LEFTkeycode             keycode@RIGHTkeycode", false, color, alpha);
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], string(clamp(global._colorblending,0,1)), true, color);
						}
					break;
					case "shake":
						if(_btnonscreen){
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+110-_surfaceoffs[1], "keycode@LEFTkeycode             keycode@RIGHTkeycode", false, color, alpha);
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], "x"+string(global._shakevals[global._shakeval]), true, color);
						}
					break;
			
					case "inptype":
						var inps = ["Keyboard", "Gamepad"];
						if(_btnonscreen){
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], inps[global._inptype], true, color);
						
							if(global._padfound){
								scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+110-_surfaceoffs[1], "keycode@LEFTkeycode                keycode@RIGHTkeycode", false, color, alpha);
							}
						}
					break;
					case "dz":
						if(_btnonscreen){
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+110-_surfaceoffs[1], "keycode@LEFTkeycode             keycode@RIGHTkeycode", false, color, alpha);
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], string(global._sensitivity), true, color);
						}
					break;
					case "rmbl":
						if(_btnonscreen){
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+110-_surfaceoffs[1], "keycode@LEFTkeycode             keycode@RIGHTkeycode", false, color, alpha);
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], string(global._rumble), true, color);
						}
					break;
						
					case "mouse":
						var getmouse;
						if(!global._menumouse){
							getmouse = 0;
						} else {
							getmouse = 1;
						}
						if(_btnonscreen){
							draw_sprite_ext(spr_menu_checkbox, getmouse, _xpos+global._screenOffsetX+xoffset+312-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], 1.4, 1.4, 0, color, 1);
						}
					break;
					case "kd":
						var getkd;
						if(!global._kdeffect){
							getkd = 0;
						} else {
							getkd = 1;
						}
						if(_btnonscreen){
							draw_sprite_ext(spr_menu_checkbox, getkd, _xpos+global._screenOffsetX+xoffset+362-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], 1.4, 1.4, 0, color, 1);
						}
					break;
					case "tips":
						var gettips;
						if(!global._showtips){
							gettips = 0;
						} else {
							gettips = 1;
						}
						if(_btnonscreen){
							draw_sprite_ext(spr_menu_checkbox, gettips, _xpos+global._screenOffsetX+xoffset+232-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], 1.4, 1.4, 0, color, 1);
						}
					break;
					case "freeze":
						if(_btnonscreen){
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+110-_surfaceoffs[1], "keycode@LEFTkeycode             keycode@RIGHTkeycode", false, color, alpha);
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY+96-_surfaceoffs[1], "x"+string(global._freezevals[global._freezeval]), true, color);
						}
					break;
				}
			}
		
			scr_textrender_halign("left");
			scr_textrender_valign("top");
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_wave_y(0, 0);
		}
	} else {
		if(_optionsobj._state == "main" || _optionsobj._state == "confirm"){
			_on = false;
			if(_optionsobj._state == "main" && _optionsobj._curOpt == _opt){
				_on = true;
			}
			if(_optionsobj._state == "confirm" && _optionsobj._curOpt2 == _opt){
				_on = true;
			}
		
			if(_optionsobj._state == _state){
				if(!global._debughidepause){
					var xoffset;
					var color;
					var alpha = 1;
		
					if(_on){
						scr_textrender_wave_y(global._menuSineAmp, global._menuSineSpd);
						color = global._menuColorYes;
						xoffset = global._menubuttonsin;
						_optionsobj._curbutton = self;
					} else {
						scr_textrender_wave_y(0, 0);
						color = global._menuColorNo;
						xoffset = 0;
					}
		
					if(_state == "main"){
						_xpos = floor(WIDTH/2)+_optionsobj._xoffset;
					}
		
					scr_textrender_switchfont("dh_font2");
					if(_state == "confirm"){
						scr_textrender_switchfont("dh_font2_big");
					}
					if(_btnonscreen){
						scr_textrender_halign("center");
						scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], string_upper(_text), true, color, alpha, _maintextscale, _maintextscale);
						scr_textrender_halign("left");
						scr_textrender_switchfont(global._defaultFont);
					}
		
					scr_textrender_wave_y(0, 0);
				}
		
				if(global._tntmenuAct == 0 && global._inactivecursor < global._inactivecursortime && !_optionsobj._enter && _optionsobj._state == _state){
					if(global._menumouse){
						if(!_hover){
							if(scr_mousehover(_bbox[0]+_stretchleft,_bbox[1],_bbox[2]+_stretchright,_bbox[3]+_stretchbottom, true)){
								_hover = true;
								if(_optionsobj._state == "main"){
									_optionsobj._prevOpt = _optionsobj._curOpt;
									_optionsobj._curOpt = _opt;
								} else if(_optionsobj._state == "confirm"){
									_optionsobj._prevOpt2 = _optionsobj._curOpt2;
									_optionsobj._curOpt2 = _opt;
								}
							}
						} else {
							if(!scr_mousehover(_bbox[0]+_stretchleft,_bbox[1],_bbox[2]+_stretchright,_bbox[3]+_stretchbottom, true)){
								_hover = false;
							}
						}
						if(_hover && mouse_check_button_pressed(mb_left)){
							//confirm
							with(_optionsobj){
								//_mouselect = 2;
								checkmenus();
							}
						}
					} else {
						_hover = false;
					}
				}
			}
		}
	}
}