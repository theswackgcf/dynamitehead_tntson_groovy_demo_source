{
	depth = -11000;
	
	if(!_init){
		var btn = instance_create_depth(0, 0, 0, obj_menuclickable);
		btn._main = true;
		btn._parentbtn = self;
		btn._offsetx = 32;
		btn._offsety = 32;
		btn._backbutton = true;
		btn._ysize = 100;
		btn._action = "backbutton";
		btn._canrapidfire = false;
		
		if(_pause){
			_menuobj = instance_create_depth(0, 0, 0, obj_dummymenu);
		}
		_init = true;
	}
	
	if(_mouselect > 0){
		_mouselect --;
	}
	
	if(_show){
		global._drawBlackScreen = 2;
		
		_timer ++;
		_menutimer ++;
		
		if(_menutimer % 2 == 0){
			_mouseprev = [mouse_x,mouse_y];
		}
		if(mouse_x <> _mouseprev[0] || mouse_y <> _mouseprev[1]){
			_mouseactive = true;
			_mouseprev = [mouse_x,mouse_y];
		}
		
		if(_prevopt[_layer] <> _curopt[_layer]){
			//option changed
			sfx_stop_array(_menuobj._sndarray);
			sfx_play_choose(_menuobj._sndarray);
			_prevopt[_layer] = _curopt[_layer];
		}
		
		//go back by clicking on the top left icon
		if(_action != ""){
			switch(_action){
				case "backbutton":
					if(_state != "main"){
						if(!_getinput){
							settings_back();
						} else {
							sfx_stop_array(_menuobj._sndarray);
							sfx_play_choose(_menuobj._sndarray);
								
							_inpcheck = 0;
							_getinput = false;
						}
					} else {
						sfx_stop_array(_menuobj._sndarray);
						sfx_play_choose(_menuobj._sndarray);
						main_back();
					}
				break;
			}
			_action = "";
		}
		
		if(global._tntmenuAct == 0){
			if(_timer >= 1 && !_enter && !_getinput && _inputcd <= 0){
				if(menu_keycheck("up") || menu_keycheck("menu_up") || _scrollup){
					_prevopt[_layer] = _curopt[_layer];
					_curopt[_layer] --;
					if(_curopt[_layer] < 0){
						_curopt[_layer] = array_length(_btns[_statenum])-1;
					}
					_curind = _btns[_statenum][_curopt[_layer]][1];
					
					if(!_scrollup && _scrolldrag <= 0){
						_keyup = 8;
						_mouseactive = false;
					} else {
						_scrollup = false;
					}
				} else if(menu_keycheck("down") || menu_keycheck("menu_down") || _scrolldown){
					_prevopt[_layer] = _curopt[_layer];
					_curopt[_layer] ++;
					if(_curopt[_layer] > array_length(_btns[_statenum])-1){
						_curopt[_layer] = 0;
					}
					_curind = _btns[_statenum][_curopt[_layer]][1];
					
					if(!_scrolldown && _scrolldrag <= 0){
						_keydown = 8;
						_mouseactive = false;
					} else {
						_scrolldown = false;
					}
				} else if(menu_keycheck("left") || menu_keycheck("menu_left")){
					if(_state == "audio" && _curind == "vol"){
						if(_curbutton != noone && _curbutton._on){
							_curbutton._action = "leftvol";
						}
					}
					if(_state == "video"){
						if(_curbutton != noone && _curbutton._on){
							var allowedid = ["scr","res","aa","blend","shake"];
							if(array_contains(allowedid, _curbutton._id)){
								_curbutton._action = "left-"+_curbutton._id;
							}
						}
					}
					if(_state == "game"){
						if(_curbutton != noone && _curbutton._on){
							var allowedid = ["freeze"];
							if(array_contains(allowedid, _curbutton._id)){
								_curbutton._action = "left-"+_curbutton._id;
							}
						}
					}
					if(global._buildver != HTML){
						if(_state == "control"){
							if(_curind == "inptype"){
								if(global._padfound && _curbutton != noone && _curbutton._on){
									_curbutton._action = "change-inp";
								}
							}
							if(_curind == "dz"){
								if(_curbutton != noone && _curbutton._on){
									_curbutton._action = "left-dz";
								}
							}
							if(_curind == "rmbl"){
								if(_curbutton != noone && _curbutton._on){
									_curbutton._action = "left-rmbl";
								}
							}
						}
					}
				} else if(menu_keycheck("right") || menu_keycheck("menu_right")){
					if(_state == "audio" && _curind == "vol"){
						if(_curbutton != noone && _curbutton._on){
							_curbutton._action = "rightvol";
						}
					}
					if(_state == "video"){
						if(_curbutton != noone && _curbutton._on){
							var allowedid = ["scr","res","aa","blend","shake"];
							if(array_contains(allowedid, _curbutton._id)){
								_curbutton._action = "right-"+_curbutton._id;
							}
						}
					}
					if(_state == "game"){
						if(_curbutton != noone && _curbutton._on){
							var allowedid = ["freeze"];
							if(array_contains(allowedid, _curbutton._id)){
								_curbutton._action = "right-"+_curbutton._id;
							}
						}
					}
					if(global._buildver != HTML){
						if(_state == "control"){
							if(_curind == "inptype"){
								if(global._padfound && _curbutton != noone && _curbutton._on){
									_curbutton._action = "change-inp";
								}
							}
							if(_curind == "dz"){
								if(_curbutton != noone && _curbutton._on){
									_curbutton._action = "right-dz";
								}
							}
							if(_curind == "rmbl"){
								if(_curbutton != noone && _curbutton._on){
									_curbutton._action = "right-rmbl";
								}
							}
						}
					}
				}
				
				if(menu_keycheck("confirm") || menu_keycheck("menu_select")){
					checkmenus();
				}
				if(menu_keycheck("pause") || menu_keycheck("menu_back") || (global._menumouse && mouse_check_button_pressed(mb_right))){
					sfx_stop_array(_menuobj._sndarray);
					sfx_play_choose(_menuobj._sndarray);
					if(_state != "main"){
						_layer = 0;
						_state = "main";
						_mouseactive = false;
						for(var i = 0; i < array_length(_states); i++){
							if(_states[i] == _state){
								_statenum = i;
							}
						}
					} else {
						if(!_pause){
							with(_menuobj){
								_menustate = "main";
								_inputinit = false;
							}
							_enter = false;
							_show = false;
							global._drawBlackScreen = 0;
							global._tntmenuAct = 0;
						} else {
							global._pauseoptions = false;
							global._pausebackcooldown = 4;
							with(obj_pause){
								_state = "main";
							}
							_enter = false;
							_show = false;
							global._drawBlackScreen = 0;
							global._tntmenuAct = 0;
						}
					}
				}
		
				rapidfire("up");
				rapidfire("down");
				rapidfire("left");
				rapidfire("right");
				rapidfire("menu_up");
				rapidfire("menu_down");
				rapidfire("menu_left");
				rapidfire("menu_right");
			}
		} else if(global._tntmenuAct == 2){
			if(_enter){
				with(obj_camera){
					_ampX = 12;
					_ampY = 12;
				}
				sfx_play(snd_explosion);
			
				if(_tntmenustate != "return"){
					_layer = 1;
					_prevopt[1] = 0;
					_curopt[1] = 0;
					_curind = "";
					_state = _tntmenustate;
					for(var i = 0; i < array_length(_states); i++){
						if(_states[i] == _state){
							_statenum = i;
						}
					}
				} else {
					main_back();
				}
				
				if(_curopt[0] < 4){
					_scrheight = _lastbtn[_statenum];
				}
			
				global._tntmenuAct = 0;
				_enter = false;
			}
		}
		
		if(_state == "main"){
			_offsetY = 0;
			_offsetYLerp = 0;
			_scrheight = 0;
			_curbutton = noone;
		} else {
			if(_keyup > 0 || _keydown > 0){
				if(_curopt[_layer] < _scrollopt[_statenum]){
					_offsetY = 0;
				} else {
					if(_curbutton != noone){
						_offsetY = -(_curbutton._starty+_btnscrolloffset);
					} else {
						_offsetY = 0;
					}
				}
			}
		}
		_offsetYLerp = lerp(_offsetYLerp, _offsetY, 0.12);
		
		if(_keyup > 0){
			_keyup --;
		} else if(_keydown > 0){
			_keydown --;
		}
		
		if(_scrolldrag > 0){
			_scrolldrag --;
		}
		
		if(_inputcd > 0){
			_inputcd --;
		} else if(_inputcd < 0){
			_inputcd = 0;
		}
		if(_getinput){
			switch(global._inptype){
				//keyboard
				case 0:
					if(_inputcd == 0){
						if(!global._padfound){
							check_keyboard();
						} else {
							check_keyboard();
							check_gamepad();
						}
					}
				break;
				//gamepad
				case 1:
					if(_inputcd == 0){
						check_gamepad();
					}
				break;
			}
			if(_inpcheck == 1){
				if(_inputfail){
					sfx_stop(snd_dh_ko);
					sfx_play(snd_dh_ko, global._testsndgain);
					_curkey = 0;
					_inputassigned = 90;
					_inpcheck = 0;
					_inputfail = false;
				} else {
					sfx_stop_array(_menuobj._sndarray);
					sfx_play_choose(_menuobj._sndarray);
					
					_inputcd = 4;
					_inputassigned = 0;
					global._input[global._inptype][? _getinputkey[0]] = _curkey;
					
					var inp;
					if(global._inptype == 0){
						inp = "key_";
					} else if(global._inptype == 1){
						inp = "gp_";
					}
					
					scr_savevalue(global._input[global._inptype][? _getinputkey[0]], inp+_getinputkey[0], _inifile, "Controls", true, true);
					
					with(obj_dh_mask){
						setinput();
					}
					
					_inpcheck = 0;
					_getinput = false;
				}
			}
		} else {
			_inpkeyboard = false;
		}
		
		if(_curbutton != noone){
			_descobj._desc = _curbutton._desc;
		}
		
		if(!global._menumouse){
			global._forcecustorstop = 2;
		}
	} else {
		_action = "";
		_layer = 0;
		_state = "main";
		for(var i = 0; i < array_length(_states); i++){
			if(_states[i] == _state){
				_statenum = i;
			}
		}
		_tntmenustate = "";
		_curopt = [0];
		_prevopt = [0];	
		_timer = 0;
	}
}