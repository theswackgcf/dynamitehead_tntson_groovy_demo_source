{
	var showup = true;
	if(global._state == "game"){
		showup = false;
		if(global._pause){
			showup = true;
		}
	}
	if(global._state == "minigame"){
		showup = false;
		if(global._pause){
			showup = true;
		}
	}
	
	if(showup){
		depth = -11001;
		if(!_init){
			if(_id == "vol"){
				var btn = instance_create_depth(0, 0, 0, obj_menuclickable);
				btn._parentbtn = self;
				btn._offsetx = -170;
				btn._offsety = 80;
				btn._xsize = 85;
				btn._ysize = 75;
				btn._action = "leftvol";
				btn._canrapidfire = true;
				
				btn = instance_create_depth(0, 0, 0, obj_menuclickable);
				btn._parentbtn = self;
				btn._offsetx = 192;
				btn._offsety = 80;
				btn._xsize = 85;
				btn._ysize = 75;
				btn._action = "rightvol";
				btn._canrapidfire = true;
			}
			if(_id == "scr" || _id == "res" || _id == "aa" || _id == "blend" || _id == "shake" || _id == "dz" || _id == "inptype" || _id == "rmbl" || _id == "freeze"){
				var btn = instance_create_depth(0, 0, 0, obj_menuclickable);
				btn._parentbtn = self;
				btn._offsetx = -170;
				btn._offsety = 95;
				btn._xsize = 85;
				btn._ysize = 75;
				btn._action = "left-"+_id;
				if(_id == "scr"){
					btn._offsetx = -207;
				}
				if(_id == "inptype"){
					btn._offsetx = -210;
					btn._action = "change-inp";
				}
				if(_id == "freeze"){
					btn._offsetx = -270;
					btn._xsize = 270;
				}
				btn._canrapidfire = true;
				
				btn = instance_create_depth(0, 0, 0, obj_menuclickable);
				btn._parentbtn = self;
				btn._offsetx = 192;
				btn._offsety = 95;
				btn._xsize = 85;
				btn._ysize = 75;
				btn._action = "right-"+_id;
				if(_id == "scr"){
					btn._offsetx = 229;
				}
				if(_id == "inptype"){
					btn._offsetx = 210;
					btn._action = "change-inp";
				}
				if(_id == "freeze"){
					btn._offsetx = 280;
					btn._xsize = 270;
				}
				btn._canrapidfire = true;
			}
		
			_init = true;
		}
	
		_showbtn = false;
		if(!_pausebtn && _optionsobj._show && _optionsobj._state == _state){
			_showbtn = true;
		}
		if(_pausebtn){
			if(_optionsobj._state == "main" || _optionsobj._state == "confirm"){
				if(_optionsobj._state == _state){
					_showbtn = true;
				}
			}
		}
	
		//only draw button if its on screen
		if(_dispbox[0] <= WIDTH && _dispbox[2] >= 0 && _dispbox[1] <= HEIGHT && _dispbox[3] >= 0){
			if(_showbtn){
				_btnonscreen = true;
			} else {
				_btnonscreen = false;
			}
		} else {
			_btnonscreen = false;
		}
		
		if(!_pausebtn){
			//options
			if(_optionsobj._show && _optionsobj._state == _state){
				_on = false;
				if(_optionsobj._curopt[_layer] = _opt){
					_on = true;
				}
			} else {
				_on = false;
			}
			
			if(_on){
				_optionsobj._curbutton = self;
			}
			
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
			
			_ypos = _starty + _optionsobj._offsetYLerp;
			
			//mouse input
			if(!_menubtn){
				if(!_optionsobj._getinput){
					if(global._tntmenuAct == 0 && global._inactivecursor < global._inactivecursortime && _getsize && _optionsobj._mouseactive && _optionsobj._timer >= 1 && !_optionsobj._enter && _optionsobj._state == _state && diff(_optionsobj._offsetY, _optionsobj._offsetYLerp) <= 16){
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
			} else {
				//menu btn
				if(global._tntmenuAct == 0 && global._inactivecursor < global._inactivecursortime && global._menumouse && _getsize && _optionsobj._state == _state){
					if(!_hover){
						if(scr_mousehover(_bbox[0]+_stretchleft,_bbox[1],_bbox[2]+_stretchright,_bbox[3]+_stretchbottom, true)){
							_hover = true;
							_optionsobj._prevopt[_layer] = _optionsobj._curopt[_layer];
							_optionsobj._curopt[_layer] = _opt;
						}
					} else {
						if(!scr_mousehover(_bbox[0]+_stretchleft,_bbox[1],_bbox[2]+_stretchright,_bbox[3]+_stretchbottom, true)){
							_hover = false;
						}
					}
					if(_hover && mouse_check_button_pressed(mb_left)){
						//confirm
						with(_optionsobj){
							checkmenus();
						}
					}
				}
			}
			
			//offsets
			if(_id == "scr" || _id == "vsync" || _id == "filter" || _id == "unfocused_mute"){
				_stretchleft = -32;
				_stretchright = 112;
				if(_id == "filter"){
					_stretchleft = -50;
					_stretchright = 132;
				}
			}
			
			if(_id == "inp"){
				_stretchleft = -180;
				_stretchright = 180;
			}
			
			if(_id == "mouse" || _id == "kd" || _id == "tips" || _id == "bird" || _id == "surfl" || _id == "bgsky"){
				_stretchright = 100;
			}
		} else {
			//pause
			if(_optionsobj._state == "main" || _optionsobj._state == "confirm"){
				_on = false;
				if(_optionsobj._state == "main" && _optionsobj._curOpt == _opt){
					_on = true;
				}
				if(_optionsobj._state == "confirm" && _optionsobj._curOpt2 == _opt){
					_on = true;
				}
				
				if(_optionsobj._state == _state && _getsize){
					//mouse input
					_unavailable = false;
					if(_id == "id_restart" && global._state == "minigame" && global._minigame == "lode" && global._pause_prevent_restart){
						_unavailable = true;
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
								if(!_unavailable){
									with(_optionsobj){
										//_mouselect = 2;
										checkmenus();
									}
								} else {
									with(obj_camera){
										_ampX = 10;
										_ampY = 10;
									}
									sfx_play_choose([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
								}
							}
						} else {
							_hover = false;
						}
					}
				}
			}
		}
		
		if(_lastbtn != -1 && _getsize){
			with(obj_options){
				if(_lastbtn[other._lastbtn] == 0){
					_lastbtn[other._lastbtn] = other._starty+_btnscrolloffset;
				}
			}
		}
	}
}