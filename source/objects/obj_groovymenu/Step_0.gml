{
	//dh on beat
	var failsafe = false;
	if(global._cursong != -1){
		_songplaying = audio_is_playing(global._cursong);
		if(_songplaying){
			if(!_begin){
				if( (audio_sound_get_track_position(global._cursong))%(60/_bpm) <= 0.05 ){
					if(!_beat){
						_dhindex = 0;

						_beat = true;
					}
				}
			}
		} else {
			failsafe = true;
		}
	} else {
		failsafe = true;
	}
	
	_beatcount = 1-_beatcount_start+(floor((audio_sound_get_track_position(global._cursong) * _bpm) / 60)%4);
	
	if(failsafe){
		//failsafe
		_failsafe_timer += 1;
		if(_failsafe_timer >= 30){
			if(!_beat){
				_failsafe_timer = 0;
				_dhindex = 0;
				_beatcount ++;
				if(_beatcount >= 5){
					_beatcount = 1;
				}
				_beat = true;
			}
		}
		if(_begin){
			_failsafe_timer = 0;
		}
	}
	
	if(_displaymenu){
		_menutimer ++;
		
		if(!_init){
			var btn1 = instance_create_depth(0, 0, 0, obj_menuclickable);
			btn1._parentbtn = self;
			btn1._offsetx = 68;
			btn1._offsety = HEIGHT-96;
			btn1._xsize = 85;
			btn1._ysize = 75;
			btn1._action = "leftcredits";
			btn1._canrapidfire = true;
	
			var btn2 = instance_create_depth(0, 0, 0, obj_menuclickable);
			btn2._parentbtn = self;
			btn2._offsetx = WIDTH-70;
			btn2._offsety = HEIGHT-96;
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
			
			var btn4 = instance_create_depth(0, 0, 0, obj_menuclickable);
			btn4._parentbtn = self;
			btn4._offsetx = 232;
			btn4._offsety = floor(HEIGHT/2);
			btn4._xsize = 85;
			btn4._ysize = 75;
			btn4._action = "leftmanual";
			btn4._canrapidfire = true;
	
			var btn5 = instance_create_depth(0, 0, 0, obj_menuclickable);
			btn5._parentbtn = self;
			btn5._offsetx = WIDTH-256;
			btn5._offsety = floor(HEIGHT/2);
			btn5._xsize = 85;
			btn5._ysize = 75;
			btn5._action = "rightmanual";
			btn5._canrapidfire = true;
		
			if(global._buildver != HTML){
				//manual
				for(var i = 0; i < 99; i++){
					var file = "./manual/"+string(i+1)+".png";
					if(file_exists(file)){
						_manual_imgs[i] = sprite_add(file, 1, false, false, floor(_manual_dim[0]/2),floor(_manual_dim[1]/2));
					}
				}
			}
		
			_init = true;
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
	
		if(_menustate == "credits"){
			_creditsLerp = -_creditsoffset[_creditsoption];
			_creditscuroffset = lerp(_creditscuroffset, _creditsLerp, 0.12);
		} else {
			_creditsLerp = 0;
			_creditscuroffset = _creditsLerp
		}

		//intro
		_mainmenuoffset -= _mainmenuoffset_spd;
		switch(_introact){
			case 1:
				_mainmenuoffset_spd += 1.8;
				if(_mainmenuoffset_spd >= 95){
					_mainmenuoffset_spd = 95;
					_introact = 2;
				}
			break;
			case 2:
				if(_mainmenuoffset <= _lerppos){
					_mainmenuoffset = _lerppos;
					_mainmenuoffset_spd = 0;
					_introact = 3;
				}
			break;
			case 3:
				_mainmenuoffset = ease_out_elastic(_lerppos, 0, 100);
				_introtimer ++;
				if(_introtimer >= 30){
					_doinput = true;
					_introact = -1;
				}
			break;
		}
		
		//skip the pan down
		if(_introact >= 1){
			if((menu_keycheck("confirm") || menu_keycheck("menu_select")) || (global._menumouse && mouse_check_button_pressed(mb_left))){
				_mainmenuoffset = 0;
				_lerppos = 0;
				_inp_cd = 7;
				_doinput = true;
				_introact = -1;
			}
		}
		if(_inp_cd > 0){
			_inp_cd--;
		}
		
		if(_introact == -1 || _introact == 3){
			_mainmenuoffset = ease_out_elastic(_lerppos, 0, 100);
		}
		
		//skip intro if player is back to menu
		if(global._backtomenu){
			_skip_intro_on_start = true;
			_stageselect_start = true;
			
			global._backtomenu = false;
		}
		
		//if(global._cursong != -1 && ds_map_exists(global._loops, audio_get_name(global._cursong)) && audio_sound_get_track_position(global._cursong) <= global._loops[? audio_get_name(global._cursong)]+0.2){
			//_beatcount = _beatcount_start-1;
		//}
		
		if(_introact == 0 && _skip_intro_on_start){
			_introact = -1;
			_mainmenuoffset = 0;
			_lerppos = 0;
			_doinput = true;
			if(!_stageselect_start){
				mus_play(mus_menu);
			} else {
				_displaymenu = false;
				with(obj_stageselect){
					_displayselect = true;
				}
			}
		}
		
		_starttimer ++
		if(_starttimer >= 15 && _introact == 0 && _anykey_act == 0){
			if(global._menumouse){
				if(mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right) || mouse_check_button_pressed(mb_middle)){
					_starttimer = 0;
					_anykey_act = 1;
				}
			}
			
			if(keyboard_check_pressed(vk_anykey)){
				_starttimer = 0;
				_anykey_act = 1;
			}
			
			if(global._padfound){
				if(gamepad_anykey(global._padnum)){
					_starttimer = 0;
					_anykey_act = 1;
				}
			}
		}
		
		switch(_anykey_act){
			case 0:
				_anykey_alp = clamp(sin(_starttimer/18)+1.45,0,1);
			break;
			case 1:
				if(!_anykey_snd){
					sfx_play(snd_kd5);
					sfx_play(snd_finalko);
					
					_anykey_scale = 2.45;
					
					_anykey_snd = true;
				}
				if(_starttimer % 5 < 3){
					_anykey_alp = 0;
				} else {
					_anykey_alp = 1;
				}
				_anykey_timer ++;
				if(_anykey_timer >= 32){
					_beatcount = _beatcount_start;
					with(obj_music){
						mus_stop();
						if(!audio_is_playing(mus_menu)){
							mus_play(mus_menu);
						}
					}
					
					_anykey_act = 2;
					_introact = 1;
				}
			break;
			case 2:
				_anykey_alp = 0;
			break;
		}
		
		if(_anykey_scale > 1){
			_anykey_scale -= 0.12;
		}

		switch(_menustate){
			case "main":
				_on = false;
				_curoption = _btninfo[_option][0];
			
				if(_enteramp > 0){
					_enteramp --;
				} else {
					_enteramp = 0;
				}
			
				var spr = spr_groovymenu_dh_beat;
				if(_beatcount <> 1){
					spr = spr_groovymenu_dh_minibeat;
				}
				if(_begin){
					spr = spr_groovymenu_dh_enter_beat;
				}
				var framenum = sprite_get_info(spr).num_subimages-1;
				if(_beat && _dhindex >= framenum){
					_dhindex = 0;
					_beat = false;
				}
			
				if(!_begin){
					_dhsprite = spr_groovymenu_dh;
					if(_beat){
						if(_beatcount == 1){
							_dhsprite = spr_groovymenu_dh_beat;
						} else {
							_dhsprite = spr_groovymenu_dh_minibeat;
						}
					}
				} else {
					_dhsprite = spr_groovymenu_dh_enter;
					if(_beat){
						_dhsprite = spr_groovymenu_dh_enter_beat;
					}
				}
			
				_dhindex += _dhspd;
			
				if(global._menumouse){
					if((mouse_x != _mouseprev[0] || mouse_y != _mouseprev[1]) || mouse_check_button_pressed(mb_left)){
						_mouseactive = true;
						_mouseprev = [mouse_x,mouse_y];
					}
					else{
						_mouseactive = false;
					}
				} else {
					_mouseactive = false;
				}
			
				_tntframe++;
			
				if(!_enter){
					_enteract = 0;
					_entertimer = 0;
					_enterinit = false;
					_enterscale = [1,1];
					_enterangle = 0;
					_enteroffset = [0,0];
				
					if(_inp_cd <= 0 && _doinput){
						if(menu_keycheck("up") || menu_keycheck("menu_up")){
							if(_option != 0){
								_option--;
							}
							else{
								_option = array_length(_btninfo) - 1;
							}
						} else if(menu_keycheck("down") || menu_keycheck("menu_down")){
							if(_option != array_length(_btninfo) - 1){
								_option++;
							}
							else{
								_option = 0;
							}
						}
				
						if((menu_keycheck("confirm") || menu_keycheck("menu_select")) || (global._menumouse && _optionhovered && mouse_check_button_pressed(mb_left))){
							_tntframe = 0;
							_enter = true;
							sfx_play_choose([snd_kd1,snd_kd2,snd_kd3,snd_kd4,snd_kd5]);
						}
					}
				} else {
					_entertimer ++;
					switch(_enteract){
						case 0:
							_enterscale = [0.86, 1.11];
							_enterangle = 12;
							_enteroffset = [-64,22];
						break;
						case 1:
							_enterscale = [1.12, 0.92];
							_enterangle = -16;
							_enteroffset = [34,-16];
						break;
						case 2:
							_enterscale = [1.05, 0.97];
							_enterangle = 5;
							_enteroffset = [-76,22];
						break;
						case 3:
							_enterscale = [1.08, 0.95];
							_enterangle = 0;
							_enteroffset = [-38,22];
						break;
					}
				
					if(_entertimer >= 7){
						if(!_begin){
							_enteramp = 22;
							_enteract ++;
							_entertimer = 0;
						}
						if(_enteract >= 4){
							if(!_enterinit){
								_enterscale = [1, 1];
								_enterangle = 0;
								_enteroffset = [0,0];
								_enteramp = 0;
							
								sfx_play(snd_explosion);
								if(_curoption != "play"){
									sfx_play(snd_explosion);
									var snd = [snd_scream1,snd_scream2,snd_scream3,snd_scream4,snd_scream5,snd_scream6];
									var rand = irandom_range(0,array_length(snd)-1);
									sfx_play(snd[rand]);
									sfx_pitch(snd[rand], random_range(0.66,1.32));
								} else {
									sfx_play(snd_wall_close);
								}
							
								with(obj_camera){
									_ampX = 22;
									_ampY = 22;
								}
								switch(_curoption){
									case "play":
										//start
										_begin = true;
										_beat = true;
										_dhindex = 0;
										_enteramp = 24;
										with(obj_camera){
											_ampX = 0;
											_ampY = 38;
										}
										if(global._cursong != -1){
											_savemuspos = audio_sound_get_track_position(global._cursong);
										}
										mus_stop();
									break;
									case "setting":
										//open settings
										_menustate = "setting";
										_enter = false;
										with(obj_options){
											_show = true;
										}
									break;
									case "manual":
										//manual
										_menustate = "manual";
										_enter = false;
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
									
									case "login":
										_menustate = "main";
										_enter = false;
										
										//connect to the newgrounds API if this is a newgrounds build
										if(global._newgrounds){
											ng_connect(global._ng_api_key[0],global._ng_api_key[1]);
											ng_initialize_medals_and_scoreboard();
											ng_request_login();
											
											global._nglogin = true;
										}
									break;
								}
								_enterinit = true;
							}
						} else {
							if(_enteract < 4){
								sfx_play_choose([snd_menu_punch1,snd_menu_punch2,snd_menu_punch3,snd_menu_punch4,snd_menu_punch5], 1);
							}
						}
					}
				}
				_option = clamp(_option, 0, array_length(_btninfo) - 1);
			
				//option changed
				if(_prevoption != _option){
					sfx_stop_array(_sndarray);
					sfx_play_choose(_sndarray);
					_tntscalemult = 1.8;
				}
				_tntscalemult = lerp(_tntscalemult, 0, 0.15);
			
				_mouseprev = [mouse_x, mouse_y];
				_prevoption = _option;
			
				//begin
				if(_begin){
					_begintimer ++;
					if(_begintimer >= 60){
						_sqr_size += 0.1;
						if(_sqr_size >= 3.5){
							_displaymenu = false;
							with(obj_stageselect){
								_displayselect = true;
							}
						}	
					}
				}
				
				if(_introact == -1){
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
				}
			break;
			case "manual":
				_on = true;
				
				_manual_offset += _manual_spd;
				_manual_spd += 1.86;
				if(_manual_offset > 0){
					_manual_offset = 0;
					_manual_spd = 0;
				}
				
				if(menu_keycheck("pause") || menu_keycheck("menu_back") || (global._menumouse && mouse_check_button_pressed(mb_right))){
					sfx_stop_array(_sndarray);
					sfx_play_choose(_sndarray);
				
					_menustate = "main";
					_manual_page = 0;
					
					_manual_offset = 0;
					_manual_spd = 0;
				}
				
				if(menu_keycheck("left") || menu_keycheck("menu_left")){
					if(_manual_page > 0){
						_manual_page --;
					}
				} else if(menu_keycheck("right") || menu_keycheck("menu_right")){
					if(_manual_page < array_length(_manual_imgs)-1){
						_manual_page ++;
					}
				}
				
				if(_action != ""){
					switch(_action){
						case "leftmanual":
							if(_manual_page > 0){
								_manual_page --;
							}
						break;
						case "rightmanual":
							if(_manual_page < array_length(_manual_imgs)-1){
								_manual_page ++;
							}
						break;
						case "backbutton":
							sfx_stop_array(_sndarray);
							sfx_play_choose(_sndarray);
				
							_menustate = "main";
							_manual_page = 0;
							
							_manual_offset = 0;
							_manual_spd = 0;
						break;
					}
					_action = "";
				}
				
				if(_manual_page_prev != _manual_page){
					//option changed
					sfx_stop_array(_sndarray);
					sfx_play_choose(_sndarray);
					
					_manual_offset = 0;
					_manual_spd = _manual_jumpspd;
				}
			
				_manual_page_prev = _manual_page;
			break;
			case "credits":
				_on = true;
		
				if(global._timer % 8 == 0){
					_creditsframe ++;
					if(_creditsframe >= 3){
						_creditsframe = 0;
					}
				}
			
				if(menu_keycheck("right") || menu_keycheck("menu_right")){
					if(_creditsoption < array_length(_creditsinfo) - 1){
						_creditsoption++;
					}
				} else if(menu_keycheck("left") || menu_keycheck("menu_left")){
					if(_creditsoption > 0){
						_creditsoption--;
					}
				}
				if(menu_keycheck("pause") || menu_keycheck("menu_back") || (global._menumouse && mouse_check_button_pressed(mb_right))){
					sfx_stop_array(_sndarray);
					sfx_play_choose(_sndarray);
				
					_menustate = "main";
					_creditsoption = 0;
				}
			
				if(_action != ""){
					switch(_action){
						case "leftcredits":
							if(_creditsoption > 0){
								_creditsoption--;
							}
						break;
						case "rightcredits":
							if(_creditsoption < array_length(_creditsinfo) - 1){
								_creditsoption++;
							}
						break;
						case "backbutton":
							sfx_stop_array(_sndarray);
							sfx_play_choose(_sndarray);
				
							_menustate = "main";
							_creditsoption = 0;
						break;
					}
					_action = "";
				}
			
				if(_prevcreditsoption != _creditsoption){
					//option changed
					sfx_stop_array(_sndarray);
					sfx_play_choose(_sndarray);
				}
			
				_prevcreditsoption = _creditsoption;
			break;
		}
	
		if(_menustate != "main"){
			_mouseactive = false;
		}
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
	
	rapidfire("jump");
	rapidfire("menu_select");
	rapidfire("menu_confirm");
	
	rapidfire("punch");
	rapidfire("menu_back");
	rapidfire("pause");
}