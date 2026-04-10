{
	if(global._pausebackcooldown > 0){
		global._pausebackcooldown --;
	} else if(global._pausebackcooldown < 0){
		global._pausebackcooldown = 0;
	}
	
	if(!_state_init){
		if(global._state != "game"){
			array_delete(_pauseOpts, 1, 2);
		}
		
		if(global._state == "minigame"){
			_pauseOpts = [
				[_pausetitles.resume,"id_resume",0,PAUSE_RESUME],
				["","id_restart",2,PAUSE_RSTART],
				[_pausetitles.settings,"id_settings",3,PAUSE_OPT],
				[_pausetitles.menu,"id_menu",4,PAUSE_QUIT],
			];
			switch(global._minigame){
				case "whack":
					_pauseOpts[1][0] = _pausetitles.restart_whack;
				break;
				case "lode":
					_pauseOpts[1][0] = _pausetitles.restart_lode;
				break;
			}
		}
		
		if(global._state == "comics" || global._state == "enddemo"){
			_pauseOpts = [
				[_pausetitles.resume,"id_resume",0,PAUSE_RESUME],
				[_pausetitles.skip, "id_skip",5,PAUSE_SURF],
				[_pausetitles.settings,"id_settings",3,PAUSE_OPT],
				[_pausetitles.menu,"id_menu",4,PAUSE_QUIT],
			];
		}
		
		
		for(var i = 0; i < array_length(_pauseOpts); i++){
			var btnsize = 72;
			_btn = instance_create_depth(0, 0, 0, obj_optbtn);
			_btn._pausebtn = true;
			_btn._xpos = floor(WIDTH/2)-WIDTH;
			_btn._ypos = ((floor(HEIGHT/2)+70)-((btnsize*0.5)*(array_length(_pauseOpts)-1))) + _yposoffset;
			_btn._starty = _btn._ypos;
			_btn._maintextscale = 1.25;
			_yposoffset += btnsize;
			_btn._text = _pauseOpts[i][0];
			_btn._id = _pauseOpts[i][1];
			_btn._opt = i;
			_btn._optionsobj = self;
			_btn._state = "main";
			_btn._layer = 0;
		}
	
		for(var i = 0; i < 2; i++){
			_btn = instance_create_depth(0, 0, 0, obj_optbtn);
			_btn._pausebtn = true;
			if(i == 0){
				_btn._xpos = floor(WIDTH/2)-128;
				_btn._text = "YES";
			} else {
				_btn._xpos = floor(WIDTH/2)+128;
				_btn._text = "NO";
			}
			_btn._ypos = floor(HEIGHT/2);
			_btn._starty = _btn._ypos;
			_btn._id = "confirm";
			_btn._opt = i;
			_btn._optionsobj = self;
			_btn._state = "confirm";
		}
		
		
		_state_init = true;
	}

	//pausing
	var canpause = false;
	var pausestate = ["game","comics","enddemo"];
	for(var p = 0; p < array_length(pausestate); p++){
		if(global._state == pausestate[p]){
			canpause = true;
		}
	}
	if(global._state == "minigame" && !global._minigame_nopause){
		canpause = true;
	}
	if(!_canpause){
		canpause = false;
	}
	
	_init_timer ++;
	
	if(canpause){
		if(!global._winscreen && global._pausebackcooldown <= 0 && !global._pauseoptions){
			var maxind = 1;
			if(global._padfound){
				maxind = 2;
			}
			for(var inp = 0; inp < maxind; inp++){
				if(check_keypress(global._input[inp][? "pause"], inp) || (!window_has_focus() && _init_timer >= 24 && !global._pause)){
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
							if(!global._forceStopMusic){
								_musicstart = true;
								_musicinit = false;
								_resumepos = true;
							}
						}
					
						global._pause = false;
					}
				}
			}
		}
	}
	
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
						_confirmbtn = _pauseOpts[_curOpt][1];
						_prevOpt2 = 0;
						_curOpt2 = 0;
						_state = "confirm";
					break;
					case "restart_stage":
						_confirmtitle = _pauseOpts[_curOpt][0];
						_confirmbtn = _pauseOpts[_curOpt][1];
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
						_confirmbtn = _pauseOpts[_curOpt][1];
						_prevOpt2 = 0;
						_curOpt2 = 0;
						_state = "confirm";
					break;
					
					case "skip_all":
						_canpause = false;
						
						mus_stop();
						sfx_pause_all(false);
					
						global._pauseReturn = true;
						global._pause = false;
					
						switch(global._state){
							case "comics":
								with(obj_comics){
									_transition_act = -1;
									_skipdg = true;
							
									_skipall_act = 0;
									_skipall_timer = 0;
							
									audio_stop_all();
									mus_stop();
									
									global._stageintro_theme = audio_play_sound(mus_stageintro, 0, false);
									audio_sound_gain(global._stageintro_theme, 0);
									audio_sound_gain(global._stageintro_theme, 1, 2000);
									var leitaudio = asset_get_index("mus_stageintro_"+string(global._location+1));
									if(audio_exists(leitaudio)){
										global._stageintro_leit = audio_play_sound(leitaudio, 0, false);
										audio_sound_gain(global._stageintro_leit, 1);
									}
								}
						
								with(obj_screen_tr){
									_show = true;
									_type = "out";
									_roomto = r_stageintro;
								}
							break;
							
							case "enddemo":
								with(obj_dialogue){
									instance_destroy();
								}
								with(obj_music){
									global.music_bus.effects[0] = undefined;
								}
								with(obj_tape3){
									sfx_stop_all();
									sfx_play(snd_gate_open);
									_caller_appear = false;
									_scene = 3;
			
									_skipall_act = 3;
									_skipall_timer = 0;
			
									_skip = true;
								}
							break;
						}
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
						
						if(global._state == "minigame" && global._minigame == "lode"){
							global._lode_lives --;
							
							global._lode_deletedStuff = ds_map_create();
							global._lode_score = global._lode_score_store;
							global._lode_tnt = global._lode_tnt_store;
							global._lode_spawnstuff = false;
						}
						
						audio_stop_all();
						room_restart();
					break;
					case "confirm_menu":
						with(obj_music){
							global.music_bus.effects[0] = undefined;
						}
						audio_stop_all();
						
						if(global._state != "enddemo"){
							if(global._state == "minigame"){
								global._menuminigame = true;
								global._lode_stage = 0;
							} else {
								global._menuminigame = false;
							}
							global._loadState = "tomenu";
							room_goto(r_loading);
						} else {
							global._loadState = "enddemo";
							room_goto(r_loading);
						}
					break;
				}
				global._tntmenuAct = 0;
				_enter = false;
			}
		}
	} else {
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