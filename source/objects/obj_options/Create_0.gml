{
	_show = false;
	
	_init = false;
	_pause = false; 
	
	_timer = 0;
	_menutimer = 0;
	
	_inifile = "settings";
	
	_state = "main";
	_statenum = 0;
	_layer = 0;
	
	_mouseactive = false;
	_mouseprev = [mouse_x,mouse_y];
	
	_allsounds = ds_map_create();
	_actiontimer = ds_map_create();
	
	_curopt = [0];
	_prevopt = [0];
	_curind = "";
	
	_action = "";
	
	_allowsamekey = [["left","right","up","down","confirm","pause"],["menu_left","menu_right","menu_up","menu_down","menu_select","menu_back"]];
	
	_states = ["main","video","audio","game","control","return"];
	
	//[display name, id, width, key]
	
	_btns = [
		[
			["Video Settings",""],
			["Audio Settings",""],
			["Game Settings",""],
			["Controls",""],
			["Back","back"],
		],
		[
			["Back","video_back",70],
			["Display Mode","scr",150],
			["Resolution","res",150],
			["V-Sync","vsync",50],
			["Color Blending Quality","blend",150],
			["Interpolation","filter",50],
			["Screenshake Intensity","shake",150],
			["Reset All","video_reset"],
		],
		[
			["Back","audio_back"],
			["Master Volume","vol",190],
			["Sound Effects Volume","vol",190],
			["Voices Volume","vol",190],
			["Music Volume","vol",190],
			["Unfocused Mute","unfocused_mute"],
			["Reset All","audio_reset"],
		],
		[
			["Back","game_back"],
			["Mouse in Menu","mouse"],
			["Knockdown effect","kd"],
			["Show Tips","tips"],
			["Freeze Frame Intensity","freeze",150],
			["Reset All","game_reset"],
		],
		[
			["Back","input_back"],
			["Input Type","inptype",150],
			["Left","inp",50,"left"],
			["Right","inp",50,"right"],
			["Up","inp",50,"up"],
			["Down","inp",50,"down"],
			["Confirm","inp",50,"confirm"],
			["Jump","inp",50,"jump"],
			["Punch","inp",50,"punch"],
			["TNT Juice","inp",50,"tnt"],
			["Grabbing","inp",50,"grab"],
			["Crouch","inp",50,"crouch"],
			["Slide","inp",50,"slide"],
			["Shield","inp",50,"shield"],
			["Pose","inp",50,"taunt"],
			["Back/Pause","inp",50,"pause"],
			["Menu: Left","inp",50,"menu_left"],
			["Menu: Right","inp",50,"menu_right"],
			["Menu: Up","inp",50,"menu_up"],
			["Menu: Down","inp",50,"menu_down"],
			["Menu: Select","inp",50,"menu_select"],
			["Menu: Back","inp",50,"menu_back"],
			["Gamepad Deadzone","dz",150],
			["Rumble Intensity","rmbl",150],
			["Reset All","controls_reset"],
		]
	];
	
	_scrheight = 0;
	
	if(global._buildver == HTML){
		array_delete(_btns[1], 1, 4);
		array_delete(_btns[2], 5, 1);
		array_delete(_btns[3], 1, 1);
		array_delete(_btns[4], 1, 1);
		array_delete(_btns[4], 21, 2);
	}
	
	_btndesc = [
		[
			"",
			"",
			"",
			"",
			"",
		],
		[
			"",
			"Changes window type.  Hotkey: F4",
			"Adjusts game's display resolution.",
			"Toggles Vertical Synchronization.",
			"Changes how smooth color blending shaders apply in-game.",
			"If on, textures will appear smoother.",
			"",
			"",
		],
		[
			"",
			"Changes the volume of everything in the game.",
			"Changes the volume of all sound effects.",
			"Changes the volume of voices.",
			"Changes the volume of game's music.",
			"Mutes all the audio if the game's window becomes unfocused.",
			"",
		],
		[
			"",
			"Enables/Disables the use of mouse input in the menus.",
			"Enables/Disables the red visual effect upon knockdown/enemy KOs.",
			"This option does not affect tips that show up during tutorial.",
			"Adjusts how long the freeze effect lasts.",
			"",
		],
		[
			"",
			"Current input type. Connect/Disconnect a gamepad to change this.",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"Adjusts how sensitive gamepad's left and right stick are to player's input",
			"Adjusts gamepad's vibration. This option only affects XInput devices. (i.e. Xbox Gamepad)",
			"",
		]
	]
	
	if(global._buildver == HTML){
		array_delete(_btndesc[1], 1, 4);
		array_delete(_btndesc[2], 5, 1);
		array_delete(_btndesc[3], 1, 1);
		array_delete(_btndesc[4], 1, 1);
		array_delete(_btndesc[4], 21, 2);
	}
	
	_scrollopt = [0, 2, 2, 1, 3];
	
	_curbutton = noone;
	
	_offsetY = 0;
	_offsetYLerp = 0;
	
	_enter = false;
	
	_curkey = 0;
	_getinput = false;
	_getinputkey = ["",""];
	_inputcd = 0;
	_inpcheck = 0;
	_inpkeyboard = false;
	_inputfail = false;
	_inputassigned = 0;
	_axiskey = "";
	_axisreleased = true;
	
	_yposoffset = 0;
	
	_defbuttonsize = 90;
	_defposoffset = 64;
	_defstartpos = 270;
	
	_lastbtn = [];
	for(var j = 0; j < array_length(_btns); j++){
		_lastbtn[j] = 0;
	}
	
	_btnscrolloffset = -340;
	
	_scrollbar = instance_create_depth(0,0,0,obj_opt_scrollbar);
	_scrollbar._parentobj = self;
	
	_scrolldrag = 0;
	
	_scrollup = false;
	_scrolldown = false;
	
	_keyup = 0;
	_keydown = 0;
	
	for(var j = 0; j < array_length(_btns); j++){
		_yposoffset = 0;
		for(var i = 0; i < array_length(_btns[j]); i++){
			_btn = instance_create_depth(0, 0, 0, obj_optbtn);
			_btn._xpos = floor(WIDTH/2);
			_btn._ypos = _defstartpos + _yposoffset;
			_btn._starty = _btn._ypos;
			_yposoffset += _defposoffset;
			_btn._text = _btns[j][i][0];
			_btn._id = _btns[j][i][1];
			_btn._desc = _btndesc[j][i];
			_btn._opt = i;
			_btn._optionsobj = self;
			_btn._state = _states[j];
			_btn._layer = 0;
			if(j == 0){
				_btn._maintextscale = 1.25;
			}
			if(j > 0){
				_btn._ypos = 110 + _yposoffset;
				_btn._starty = _btn._ypos;
				if(array_length(_btns[j][i]) >= 3){
					_yposoffset += _btns[j][i][2];
					_btn._stretchbottom = max(0, _btns[j][i][2]-70);
					if(array_length(_btns[j][i]) == 4){
						_btn._input = _btns[j][i][3];
					}
				} else {
					_yposoffset += _defbuttonsize;
				}
				_btn._layer = 1;
			}
			
			if(i == array_length(_btns[j])-1){
				_btn._lastbtn = j;
			}
		}
	}
	
	_descobj = instance_create_depth(0,0,0,obj_menu_desc);
	_descobj._optionsobj = self;
	
	_menuobj = noone;
	
	_mouselect = 0;
	
	_tntmenustate = "";
	
	function check_keyboard() {
		if(keyboard_check_pressed(vk_anykey)){
			_inpkeyboard = true;
			_curkey = keyboard_key;
			if(_curkey == vk_delete){
				sfx_stop_array(_menuobj._sndarray);
				sfx_play_choose(_menuobj._sndarray);
								
				_inpcheck = 0;
				_getinput = false;
			} else {
				_inpcheck = 1;
			}
		}
	}
	
	function check_gamepad() {
		//check axis keys
		if(_axisreleased){
			for(var i = 0; i < 2; i++){
				if(global._padaxis[i][0] < -global._sensitivity){
					_inpkeyboard = false;
					_axiskey = "stick"+string(i+1)+"_l";
					_axisreleased = false;
				}
				if(global._padaxis[i][0] > global._sensitivity){
					_inpkeyboard = false;
					_axiskey = "stick"+string(i+1)+"_r";
					_axisreleased = false;
				}
				if(global._padaxis[i][1] < -global._sensitivity){
					_inpkeyboard = false;
					_axiskey = "stick"+string(i+1)+"_u";
					_axisreleased = false;
				}
				if(global._padaxis[i][1] > global._sensitivity){
					_inpkeyboard = false;
					_axiskey = "stick"+string(i+1)+"_d";
					_axisreleased = false;
				}
			}
		} else {
			for(var i = 0; i < 2; i++){
				if(global._padaxis[i][0] > -global._sensitivity && global._padaxis[i][0] < global._sensitivity && global._padaxis[i][1] > -global._sensitivity && global._padaxis[i][1] < global._sensitivity){
					_axisreleased = true;
				}
			}
		}
						
		if(_axiskey == ""){
			if(_curkey == 0){
				for(var i = 0; i < array_length(global._allgpinput); i++){
					if(gamepad_button_check_pressed(global._padnum, global._allgpinput[i])){
						_inpkeyboard = false;
						_curkey = global._allgpinput[i];
					}
				}
			} else {
				if(!_inpkeyboard){
					if(_curkey == gp_select){
						sfx_stop_array(_menuobj._sndarray);
						sfx_play_choose(_menuobj._sndarray);
								
						_inpcheck = 0;
						_getinput = false;
					} else {
						switch(global._inptype){
							case 0:
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
								
								_inpcheck = 0;
								_getinput = false;
							break;
							case 1:
								_inpcheck = 1;
							break;
						}
					}
				}
			}
		} else {
			switch(global._inptype){
				case 0:
					sfx_stop_array(_menuobj._sndarray);
					sfx_play_choose(_menuobj._sndarray);
								
					_inpcheck = 0;
					_getinput = false;
				break;
				case 1:
					_curkey = _axiskey;
					_axiskey = "";
					_inpcheck = 1;
				break;
			}
		}
	}
	
	_on = true;
	function main_back() {
		_show = false;
		global._drawBlackScreen = 0;
		with(_menuobj){
			_layer = 0;
			_menustate = "main";
			_inputinit = false;
		}
		if(_pause){
			with(obj_pause){
				_state = "main";
			}
			global._pauseoptions = false;
			global._pausebackcooldown = 4;
		}
	}
	
	function settings_back() {
		with(obj_opt_scrollbar){
			_visibtimer = 0;
		}
		
		sfx_stop_array(_menuobj._sndarray);
		sfx_play_choose(_menuobj._sndarray);
						
		_layer = 0;
		_state = "main";
		_mouseactive = false;
		for(var i = 0; i < array_length(_states); i++){
			if(_states[i] == _state){
				_statenum = i;
			}
		}
	}
	
	function checkmenus() {
		switch(_state){
			case "main":
				sfx_play(snd_tnt_pull);
		
				switch(_curopt[0]){
					case 0:
						_tntmenustate = "video";
					break;
					case 1:
						_tntmenustate = "audio";
					break;
					case 2:
						_tntmenustate = "game";
					break;
					case 3:
						_tntmenustate = "control";
					break;
					case 4:
						_tntmenustate = "return";
					break;
				}
		
				_enter = true;
				global._tntmenuAct = 1;
			break;
			case "video":
				if(_curbutton != noone && _curbutton._on && _mouselect <= 0){
					switch(_curbutton._id){
						case "video_back":
							settings_back();
						break;
						case "vsync":
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
					
							if(!global._vsync){
								global._vsync = true;
							} else {
								global._vsync = false;
							}
						
							display_reset(0, global._vsync);
						
							with(obj_menu_enabled){
								instance_destroy();
							}
							var enab = instance_create_depth(0, 0, 0, obj_menu_enabled);
							enab._xpos = _curbutton._xpos + 245;
							enab._ypos = _curbutton._ypos - 64;
							enab._startx = _curbutton._xpos + 245;
							enab._state = global._vsync;
						
							scr_savevalue(global._vsync,"V-Sync",_inifile,"Video",true,true);
						break;
						case "filter":
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
					
							if(!global._texfilter){
								global._texfilter = true;
							} else {
								global._texfilter = false;
							}
						
							gpu_set_texfilter(global._texfilter);
						
							with(obj_menu_enabled){
								instance_destroy();
							}
							var enab = instance_create_depth(0, 0, 0, obj_menu_enabled);
							enab._xpos = _curbutton._xpos + 345;
							enab._ypos = _curbutton._ypos - 64;
							enab._startx = _curbutton._xpos + 345;
							enab._state = global._texfilter;
						
							scr_savevalue(global._texfilter,"Interpolation",_inifile,"Video",true,true);
						break;
						case "video_reset":
							global._scrtype = global._defvalues[? "Fullscreen"];
							global._vsync = global._defvalues[? "V-Sync"];
							global._texfilter = global._defvalues[? "Interpolation"];
							global._shakeval = global._defvalues[? "Screenshake"];
							global._curres = global._defvalues[? "Resolution"];
							global._aa_filter = global._defvalues[? "Anti-Aliasing"];
							global._colorblending = global._defvalues[? "Color Blending"];
						
							global._storeSliders[? "Fullscreen"] = global._defvalues[? "Fullscreen"];
							global._storeSliders[? "Screenshake"] = global._defvalues[? "Screenshake"];
							global._storeSliders[? "Resolution"] = global._defvalues[? "Resolution"];
							global._storeSliders[? "Anti-Aliasing"] = global._defvalues[? "Anti-Aliasing"];
							global._storeSliders[? "Color Blending"] = global._defvalues[? "Color Blending"];
						
							display_reset(0, global._vsync);
							gpu_set_texfilter(global._texfilter);
							
							with(all){
								if(variable_instance_exists(self.id,"_colorsinit")){
									_colorsinit = false;
								}
							}
						
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
						
							scr_savevalue(global._scrtype,"Fullscreen",_inifile,"Video",true,false);
							scr_savevalue(global._vsync,"V-Sync",_inifile,"Video",false,false);
							scr_savevalue(global._texfilter,"Interpolation",_inifile,"Video",false,false);
							scr_savevalue(global._shakeval,"Screenshake",_inifile,"Video",false,false);
							scr_savevalue(global._curres,"Resolution",_inifile,"Video",false,false);
							scr_savevalue(global._aa_filter,"Anti-Aliasing",_inifile,"Video",false,false);
							scr_savevalue(global._colorblending,"Color Blending",_inifile,"Video",false,true);
						
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
						
							global._setdisp = false;
						
							scr_adjustguiscale();
							
							with(obj_game){
								global._dowindow = false;
								alarm_set(1, 2);
							}
						break;
						
						
						case "res":
							var dispstr = "Resolution";
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._curres > 0){
									global._curres = 0;
								} else {
									global._curres = global._storeSliders[? dispstr];
								}
								
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
								
								global._setdisp = false;
						
								scr_adjustguiscale();
								
								with(obj_game){
									global._dowindow = false;
									alarm_set(1, 2);
								}
								
								global._forcecustorstop = 30;
								
								scr_savevalue(global._curres, dispstr, _inifile, "Video", true, true);
							}
						break;
						case "aa":
							var dispstr = "Anti-Aliasing";
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._aa_filter > 0){
									global._aa_filter = 0;
								} else {
									global._aa_filter = global._storeSliders[? dispstr];
								}
								
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
								
								display_reset(0, global._vsync);
								
								scr_savevalue(global._aa_filter, dispstr, _inifile, "Video", true, true);
							}
						break;
						case "blend":
							var dispstr = "Color Blending";
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._colorblending > 0){
									global._colorblending = 0;
								} else {
									global._colorblending = global._storeSliders[? dispstr];
								}
								
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
								
								with(all){
									if(variable_instance_exists(self.id,"_colorsinit")){
										_colorsinit = false;
									}
								}
								
								scr_savevalue(global._colorblending, dispstr, _inifile, "Video", true, true);
							}
						break;
						case "shake":
							var dispstr = "Screenshake";
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._shakeval > 0){
									global._shakeval = 0;
								} else {
									global._shakeval = global._storeSliders[? dispstr];
								}
								
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
								
								with(obj_camera){
									_ampX = 16;
									_ampY = 16;
								}
								
								scr_savevalue(global._shakeval, dispstr, _inifile, "Video", true, true);
							}
						break;
					}
				}
			break;
			case "audio":
				if(_curbutton != noone && _curbutton._on && _mouselect <= 0){
					switch(_curbutton._id){
						case "audio_back":
							settings_back();
						break;
						case "vol":
							switch(_curbutton._opt){
								case 1:
									var dispstr = "Master";
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._masterVolume > 0){
											global._masterVolume = 0;
										} else {
											global._masterVolume = global._storeSliders[? dispstr];
										}
										
										sfx_stop_array(_menuobj._sndarray);
										sfx_play_choose(_menuobj._sndarray);
										voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
										audio_sound_gain(global._cursong, global._curSongGain, 0);
										
										scr_savevalue(global._masterVolume, dispstr, _inifile, "Audio", true, true);
									}
								break;
								case 2:
									var dispstr = "Sound Effects";
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._sfxVolume > 0){
											global._sfxVolume = 0;
										} else {
											global._sfxVolume = global._storeSliders[? dispstr];
										}
										
										sfx_stop_array(_menuobj._sndarray);
										sfx_play_choose(_menuobj._sndarray);
										
										scr_savevalue(global._sfxVolume, dispstr, _inifile, "Audio", true, true);
									}
								break;
								case 3:
									var dispstr = "Voice";
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._voiceVolume > 0){
											global._voiceVolume = 0;
										} else {
											global._voiceVolume = global._storeSliders[? dispstr];
										}
										
										voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
										
										scr_savevalue(global._voiceVolume, dispstr, _inifile, "Audio", true, true);
									}
								break;
								case 4:
									var dispstr = "Music";
									if(ds_map_exists(global._storeSliders, dispstr)){
										if(global._musVolume > 0){
											global._musVolume = 0;
										} else {
											global._musVolume = global._storeSliders[? dispstr];
										}
										
										audio_sound_gain(global._cursong, global._curSongGain, 0);
										
										scr_savevalue(global._musVolume, dispstr, _inifile, "Audio", true, true);
									}
								break;
							}
						break;
						case "unfocused_mute":
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
						
							if(!global._unfocusedmute){
								global._unfocusedmute = true;
							}
							else{
								global._unfocusedmute = false;
							}
						
							with(obj_menu_enabled){
								instance_destroy();
							}
							var enab = instance_create_depth(0, 0, 0, obj_menu_enabled);
							enab._xpos = _curbutton._xpos + 385;
							enab._ypos = _curbutton._ypos - 64;
							enab._startx = _curbutton._xpos + 385;
							enab._state = global._unfocusedmute;
						
							scr_savevalue(global._unfocusedmute,"Unfocused Mute",_inifile,"Audio",true,true);
						break;
						case "audio_reset":
							global._masterVolume = global._defvalues[? "Master"];
							global._sfxVolume = global._defvalues[? "Sound Effects"];
							global._voiceVolume = global._defvalues[? "Voice"];
							global._musVolume = global._defvalues[? "Music"];
							global._unfocusedmute = global._defvalues[? "Unfocused Mute"];
							audio_sound_gain(global._cursong, global._curSongGain, 0);
						
							global._storeSliders[? "Master"] = global._defvalues[? "Master"];
							global._storeSliders[? "Sound Effects"] = global._defvalues[? "Sound Effects"];
							global._storeSliders[? "Voice"] = global._defvalues[? "Voice"];
							global._storeSliders[? "Music"] = global._defvalues[? "Music"];
						
							global._pauseSoundGains = ds_map_create();
						
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
						
							scr_savevalue(global._masterVolume,"Master",_inifile,"Audio",true,false);
							scr_savevalue(global._sfxVolume,"Sound Effects",_inifile,"Audio",false,false);
							scr_savevalue(global._voiceVolume,"Voice",_inifile,"Audio",false,false);
							scr_savevalue(global._musVolume,"Music",_inifile,"Audio",false,false);
							scr_savevalue(global._unfocusedmute,"Unfocused Mute",_inifile,"Audio",false,true);
						break;
					}
				}
			break;
			case "game":
				if(_curbutton != noone && _curbutton._on && _mouselect <= 0){
					switch(_curbutton._id){
						case "game_back":
							settings_back();
						break;
						case "mouse":
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
							
							if(!global._menumouse){
								global._menumouse = true;
							} else {
								global._menumouse = false;
							}
							
							with(obj_menu_enabled){
								instance_destroy();
							}
							var enab = instance_create_depth(0, 0, 0, obj_menu_enabled);
							enab._xpos = _curbutton._xpos + 385;
							enab._ypos = _curbutton._ypos - 64;
							enab._startx = _curbutton._xpos + 385;
							enab._state = global._menumouse;
						
							scr_savevalue(global._menumouse,"Mouse in Menu",_inifile,"Game",true,true);
						break;
						case "kd":
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
							
							if(!global._kdeffect){
								global._kdeffect = true;
							} else {
								global._kdeffect = false;
							}
							
							with(obj_menu_enabled){
								instance_destroy();
							}
							var enab = instance_create_depth(0, 0, 0, obj_menu_enabled);
							enab._xpos = _curbutton._xpos + 420;
							enab._ypos = _curbutton._ypos - 64;
							enab._startx = _curbutton._xpos + 420;
							enab._state = global._kdeffect;
						
							scr_savevalue(global._kdeffect,"Knockdown effect",_inifile,"Game",true,true);
						break;
						case "tips":
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
							
							if(!global._showtips){
								global._showtips = true;
							} else {
								global._showtips = false;
							}
							
							with(obj_menu_enabled){
								instance_destroy();
							}
							var enab = instance_create_depth(0, 0, 0, obj_menu_enabled);
							enab._xpos = _curbutton._xpos + 295;
							enab._ypos = _curbutton._ypos - 64;
							enab._startx = _curbutton._xpos + 295;
							enab._state = global._showtips;
						
							scr_savevalue(global._showtips,"Show Tips",_inifile,"Game",true,true);
						break;
						case "freeze":
							var dispstr = "Freeze Frame Intensity";
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._freezeval > 0){
									global._freezeval = 0;
								} else {
									global._freezeval = global._storeSliders[? dispstr];
								}
								
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
								
								scr_savevalue(global._freezeval, dispstr, _inifile, "Game", true, true);
							}
						break;
						case "game_reset":
							global._menumouse = global._defvalues[? "Mouse in Menu"];
							global._kdeffect = global._defvalues[? "Knockdown effect"];
							global._showtips = global._defvalues[? "Show Tips"];
							global._freezeval = global._defvalues[? "Freeze Frame Intensity"];
						
							global._storeSliders[? "Freeze Frame Intensity"] = global._defvalues[? "Freeze Frame Intensity"];
						
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
						
							scr_savevalue(global._menumouse,"Mouse in Menu",_inifile,"Game",true,false);
							scr_savevalue(global._kdeffect,"Knockdown effect",_inifile,"Game",false,false);
							scr_savevalue(global._showtips,"Show Tips",_inifile,"Game",false,false);
							scr_savevalue(global._freezeval,"Freeze Frame Intensity",_inifile,"Game",false,true);
						break;
					}
				}
			break;
			case "control":
				if(_curbutton != noone && _curbutton._on && _mouselect <= 0){
					switch(_curbutton._id){
						case "input_back":
							settings_back();
						break;
						case "controls_reset":
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
						
							ini_open(_inifile+".ini");
						
							var inp;
							if(global._inptype == 0){
								inp = "key_";
							} else if(global._inptype == 1){
								inp = "gp_";
							}
							var dsarray = ds_map_keys_to_array(global._input[global._inptype]);
							for(var i = 0; i < array_length(dsarray); i++){
								global._input[global._inptype][? dsarray[i]] = global._definput[global._inptype][? dsarray[i]];
								scr_savevalue(global._input[global._inptype][? dsarray[i]], inp+dsarray[i], _inifile, "Controls", false, false);
							}
							global._sensitivity = global._defvalues[? "Gamepad Deadzone"];
							scr_savevalue(global._sensitivity, "Gamepad Deadzone", _inifile, "Controls", false, false);
							
							global._rumble = 1;
							scr_savevalue(global._rumble, "Rumble Intensity", _inifile, "Controls", false, false);
						
							global._storeSliders[? "Gamepad Deadzone"] = global._defvalues[? "Gamepad Deadzone"];
							global._storeSliders[? "Rumble Intensity"] = global._defvalues[? "Rumble Intensity"];
						
							ini_close();
						
							with(obj_dh_mask){
								setinput();
							}
						break;
						case "inp":
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
					
							_axiskey = "";
							_axisreleased = true;
							_inputcd = 4;
							_curkey = 0;
							_inputassigned = 0;
							_inputfail = false;
							_inpcheck = 0;
							_getinputkey = [_curbutton._input,_curbutton._text];
							_getinput = true;
						break;
						
						case "dz":
							var dispstr = "Gamepad Deadzone";
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._sensitivity > 0){
									global._sensitivity = 0;
								} else {
									global._sensitivity = global._storeSliders[? dispstr];
								}
								
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
										
								scr_savevalue(global._sensitivity, dispstr, _inifile, "Controls", true, true);
							}
						break;
						case "rmbl":
							var dispstr = "Rumble Intensity";
							if(ds_map_exists(global._storeSliders, dispstr)){
								if(global._rumble > 0){
									global._rumble = 0;
								} else {
									global._rumble = global._storeSliders[? dispstr];
								}
								
								sfx_stop_array(_menuobj._sndarray);
								sfx_play_choose(_menuobj._sndarray);
									
								global._pad_vibrate = 4;
									
								scr_savevalue(global._rumble, dispstr, _inifile, "Controls", true, true);
							}
						break;
					}
				}
			break;
		}
	}
	
	_dosurfacestuff = true;
	
	_gui_size = [WIDTH,HEIGHT];
	_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
	
	_resizegui_size = [1,1];
	_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
}