{
	depth = -10999;
	
	if(global._pause){
		_menutimer ++;
		
		global._sticktimer = 1;
		
		_picspos = lerp(_picspos, 0, 0.5);
		_xoffset = lerp(_xoffset, -256, 0.3);
		
		if(_state == "main"){
			if(_prevOpt <> _curOpt){
				//option changed
				sfx_stop_array(_sndarray);
				sfx_play_choose(_sndarray);
				_picspos = 64;
				_prevOpt = _curOpt;
			}
		} else if(_state == "confirm"){
			if(_prevOpt2 <> _curOpt2){
				//option changed
				sfx_stop_array(_sndarray);
				sfx_play_choose(_sndarray);
				_prevOpt2 = _curOpt2;
			}
		}
		
		if(global._tntmenuAct == 0){
			if(!_enter && _state == "main"){
				if(menu_keycheck("up") || menu_keycheck("menu_up")){
					_prevOpt = _curOpt;
					_curOpt --;
					global._menubuttontimer = 0;
					if(_curOpt < 0){
						_curOpt = array_length(_pauseOpts)-1;
					}
				} else if(menu_keycheck("down") || menu_keycheck("menu_down")){
					_prevOpt = _curOpt;
					_curOpt ++;
					global._menubuttontimer = 0;
					if(_curOpt > array_length(_pauseOpts)-1){
						_curOpt = 0;
					}
				}
				
				var maxind = 1;
				if(global._padfound){
					maxind = 2;
				}
				for(var i = 0; i < maxind; i++){
					if(check_keypress(global._input[i][? "confirm"], i) || check_keypress(global._input[i][? "menu_select"], i)){
						checkmenus();
					}
				}
				
				rapidfire("up");
				rapidfire("down");
				rapidfire("menu_up");
				rapidfire("menu_down");
			} else if(!_enter && _state == "confirm"){
				if(menu_keycheck("left") || menu_keycheck("menu_left")){
					_prevOpt2 = _curOpt2;
					_curOpt2 --;
					global._menubuttontimer = 0;
					if(_curOpt2 < 0){
						_curOpt2 = 1;
					}
				} else if(menu_keycheck("right") || menu_keycheck("menu_right")){
					_prevOpt2 = _curOpt2;
					_curOpt2 ++;
					global._menubuttontimer = 0;
					if(_curOpt2 > 1){
						_curOpt2 = 0;
					}
				}
				
				var maxind = 1;
				if(global._padfound){
					maxind = 2;
				}
				for(var i = 0; i < maxind; i++){
					if(check_keypress(global._input[i][? "confirm"], i) || check_keypress(global._input[i][? "menu_select"], i)){
						checkmenus();
					}
				}
				
				rapidfire("left");
				rapidfire("right");
				rapidfire("menu_left");
				rapidfire("menu_right");
			}
		} else if(global._tntmenuAct == 2){
			if(_enter){
				with(obj_camera){
					_ampX = 15;
					_ampY = 15;
				}
				sfx_play(snd_explosion);
			
				switch(_tntmenustate){
					case "return":
						sfx_pause_all(false);
						var elements;
						if(layer_exists("lvbg1")){
							elements = layer_get_all_elements(layer_get_id("lvbg1"));
						} else {
							elements = [];
						}
						for(var i = 0; i < array_length(elements); i++){
							layer_sprite_speed(elements[i], 1);
						}
					
						mus_stop();
						with(obj_music){
							_musicinit = false;
							_resumepos = true;
						}
					
						global._pauseReturn = true;
						global._pause = false;
					break;
					case "restart_check":
						_confirmtitle = _pauseOpts[_curOpt][0];
						_prevOpt2 = 0;
						_curOpt2 = 0;
						_state = "confirm";
					break;
					case "restart_stage":
						_confirmtitle = _pauseOpts[_curOpt][0];
						_prevOpt2 = 0;
						_curOpt2 = 0;
						_state = "confirm";
					break;
					case "options":
						global._pauseoptions = true;
						_state = "options";
						with(obj_options){
							_show = true;
						}
					break;
					case "end":
						_confirmtitle = _pauseOpts[_curOpt][0];
						_prevOpt2 = 0;
						_curOpt2 = 0;
						_state = "confirm";
					break;
					case "confirm_no":
						_state = "main";
					break;
					case "confirm_check":
						global._saveMusPos = _muspos;
						audio_stop_all();
						room_restart();
					break;
					case "confirm_restart":
						scr_setgamevals();
						
						audio_stop_all();
						room_restart();
					break;
					case "confirm_menu":
						with(obj_music){
							global.music_bus.effects[0] = undefined;
						}
						audio_stop_all();
						global._loadState = "tomenu";
						room_goto(r_loading);
					break;
				}
				global._tntmenuAct = 0;
				_enter = false;
			}
		}
	} else {
		if(surface_exists(_gui_surface)){
			surface_free(_gui_surface);
		}
		if(surface_exists(_resizegui_surface)){
			surface_free(_resizegui_surface);
		}
		
		_state = "main";
		_enter = false;
		_xoffset = -WIDTH;
		_picspos = 64;
		_prevOpt = 0;
		_curOpt = 0;
		global._tntmenuAct = 0;
		global._tntmenuframe = 0;
	}
}