{
	global._sticktimer = 1;
	
	_menutimer ++;
	
	if(!_init){
		var btn1 = instance_create_depth(0, 0, 0, obj_menuclickable);
		btn1._parentbtn = self;
		btn1._offsetx = 320;
		btn1._offsety = floor(HEIGHT/2);
		btn1._xsize = 85;
		btn1._ysize = 75;
		btn1._action = "leftcredits";
		btn1._canrapidfire = true;
	
		var btn2 = instance_create_depth(0, 0, 0, obj_menuclickable);
		btn2._parentbtn = self;
		btn2._offsetx = WIDTH-320;
		btn2._offsety = floor(HEIGHT/2);
		btn2._xsize = 85;
		btn2._ysize = 75;
		btn2._action = "rightcredits";
		btn2._canrapidfire = true;
		
		var btn3 = instance_create_depth(0, 0, 0, obj_menuclickable);
		btn3._parentbtn = self;
		btn3._offsetx = 32;
		btn3._offsety = 32;
		btn3._backbutton = true;
		btn3._ysize = 100;
		btn3._action = "backbutton";
		btn3._canrapidfire = false;
		
		_init = true;
	}
	
	if(_menustate == "credits"){
		_creditsLerp = -_creditsoffset[_curopt[1]];
		_creditscuroffset = lerp(_creditscuroffset, _creditsLerp, 0.12);
	} else {
		_creditsLerp = 0;
		_creditscuroffset = _creditsLerp
	}
	
	switch(_menustate){
		case "main":
			_action = "";
			_on = false;
			if(_menutimer % 2 == 0){
				_mouseprev = [mouse_x,mouse_y];
			}
			if(mouse_x <> _mouseprev[0] || mouse_y <> _mouseprev[1]){
				_mouseactive = true;
				_mouseprev = [mouse_x,mouse_y];
			}
		
			if(!_inputinit){
				_changedinput = false;
				
				var dsarray = ds_map_values_to_array(global._input[global._inptype]);
				var def_dsarray = ds_map_values_to_array(global._definput[global._inptype]);
				var change = false;
				for(var i = 0; i < array_length(dsarray); i++){
					if(dsarray[i] != def_dsarray[i]){
						change = true;
					}
				}
				
				if(change){
					_changedinput = true;
				}
				
				_inputinit = true;
			}
			if(_changedinput){
				if(global._inptype == 0){
					if(keyboard_check(vk_escape)){
						_changehold ++;
					} else {
						_changehold = 0;
					}
				} else if(global._inptype == 1){
					if(gamepad_button_check(global._padnum, gp_select)){
						_changehold ++;
					} else {
						_changehold = 0;
					}
				}
				if(_changehold >= 60){
					ini_open("settings.ini");
						
					var inp;
					if(global._inptype == 0){
						inp = "key_";
					} else if(global._inptype == 1){
						inp = "gp_";
					}
					var dsarray = ds_map_keys_to_array(global._input[global._inptype]);
					for(var i = 0; i < array_length(dsarray); i++){
						global._input[global._inptype][? dsarray[i]] = global._definput[global._inptype][? dsarray[i]];
						scr_savevalue(global._input[global._inptype][? dsarray[i]], inp+dsarray[i], "settings", "Controls", false, false);
					}
						
					ini_close();
					
					_changehold = 0;
					_changedinput = false;
					
					sfx_play(snd_explosion);
				}
			} else {
				_changehold = 0;
			}
		
			if(_prevopt[0] <> _curopt[0]){
				//option changed
				sfx_stop_array(_sndarray);
				sfx_play_choose(_sndarray);
				with(obj_menubtn){
					if(_tnt){
						_amp = 0.45;
					}
				}
				_prevopt[0] = _curopt[0];
			}
		break;
		case "credits":
			_on = true;
			if(_menutimer % 8 == 0){
				_creditsframe ++;
				if(_creditsframe >= 3){
					_creditsframe = 0;
				}
			}
			
			if(_prevopt[1] <> _curopt[1]){
				//option changed
				sfx_stop_array(_sndarray);
				sfx_play_choose(_sndarray);
				_prevopt[1] = _curopt[1];
			}
			
			_credits_arowoffs = 0;
			if(_curopt[1] == 4){
				_credits_arowoffs = 48;
			}
			
			if(_action != ""){
				switch(_action){
					case "leftcredits":
						_prevopt[1] = _curopt[1];
						_curopt[1] --;
						if(_curopt[1] < 0){
							_curopt[1] = 0;
						}
					break;
					case "rightcredits":
						_prevopt[1] = _curopt[1];
						_curopt[1] ++;
						if(_curopt[1] > array_length(_creditsinfo)-1){
							_curopt[1] = array_length(_creditsinfo)-1;
						}
					break;
					case "backbutton":
						sfx_stop_array(_sndarray);
						sfx_play_choose(_sndarray);
				
						_menustate = "main";
						_curopt[1] = 0;
						_prevopt[1] = 0;
					break;
				}
				_action = "";
			}
		break;
	}
	
	if(_menustate != "main"){
		_mouseactive = false;
	}
	
	if(!_enter && _menutimer >= 16){
		if(menu_keycheck("up") || menu_keycheck("menu_up")){
			switch(_menustate){
				case "main":
					_prevopt[0] = _curopt[0];
					_curopt[0] --;
					if(_curopt[0] < 0){
						_curopt[0] = 0;
					}
				break;
			}
		} else if(menu_keycheck("down") || menu_keycheck("menu_down")){
			switch(_menustate){
				case "main":
					_prevopt[0] = _curopt[0];
					_curopt[0] ++;
					if(_curopt[0] > array_length(_btninfo)-1){
						_curopt[0] = array_length(_btninfo)-1;
					}	
				break;
			}
		} else if(menu_keycheck("confirm") || menu_keycheck("menu_select")){
			switch(_menustate){
				case "main":
					checkmenus();
				break;
			}
		} else if(menu_keycheck("left") || menu_keycheck("menu_left")){
			switch(_menustate){
				case "credits":
					_prevopt[1] = _curopt[1];
					_curopt[1] --;
					if(_curopt[1] < 0){
						_curopt[1] = 0;
					}
				break;
			}
		} else if(menu_keycheck("right") || menu_keycheck("menu_right")){
			switch(_menustate){
				case "credits":
					_prevopt[1] = _curopt[1];
					_curopt[1] ++;
					if(_curopt[1] > array_length(_creditsinfo)-1){
						_curopt[1] = array_length(_creditsinfo)-1;
					}
				break;
			}
		} else if(menu_keycheck("pause") || menu_keycheck("menu_back") || mouse_check_button_pressed(mb_right)){
			switch(_menustate){
				case "credits":
					sfx_stop_array(_sndarray);
					sfx_play_choose(_sndarray);
				
					_menustate = "main";
					_curopt[1] = 0;
					_prevopt[1] = 0;
				break;
			}
		}
	}
	
	if(_transition){
		sfx_play(snd_explosion);
		with(obj_camera){
			_ampX = 12;
			_ampY = 12;
		}
		
		switch(_chosenmenu){
			case "play":
				//start
				with(obj_screen_tr){
					scr_setgamevals();
					
					_show = true;
					_type = "out";
					//global._loadState = "dialogue";
					//_roomto = r_loading;
					global._loadState = "stage";
					global._location = 1;
					_roomto = r_betatester;
				}
			break;
			case "tutorial":
				//tutorial
				with(obj_screen_tr){
					global._loadState = "stage";
					global._menututorial = true;
					_audiostop = true;
					_show = true;
					_type = "out";
					_roomto = r_loading;
				}
			break;
			case "setting":
				//open settings
				_menustate = "setting";
				_enter = false;
				with(obj_options){
					_show = true;
				}
			break;
			case "credits":
				//credits
				_menustate = "credits";
				_enter = false;
			break;
			case "quit":
				//quit game
				room_goto(r_quit);
			break;
		}
		_transition = false;
	}
	
	//rapid fire keys
	rapidfire("up");
	rapidfire("down");
	rapidfire("left");
	rapidfire("right");
	rapidfire("menu_up");
	rapidfire("menu_down");
	rapidfire("menu_left");
	rapidfire("menu_right");
}