{
	if(!_init){
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
	
	_on = false;
	
	if(_displayselect){
		if(!global._menumouse){
			global._forcecustorstop = 2;
		}
		
		if(!_input_active){
			_input_timer ++;
			if(_input_timer >= 60){
				_input_active = true;
			}
		}
		
		//static code
		_statictimer ++;
		if(!_staticsnd){
			mus_stop();
			sfx_play(snd_noise_persist, 1, true);
			_staticsnd = true;
		}
		switch(_staticact){
			case 0:
				_staticscale += 0.1;
				if(_staticscale >= 2.5){
					_staticact = 1;
				}
			break;
			case 1:
				_staticscale += 0.04;
				if(_staticscale >= 2.8){
					_statictimer = 0;
					_staticact = 2;
				}
			break;
			case 2:
				if(_statictimer >= 8){
					_staticact = 3;
				}
			break;
			case 3:
				_showstages = true;
				_staticscale -= 0.3;
				if(_staticscale <= 0){
					sfx_stop(snd_noise_persist);
					mus_play(mus_st_select);
					_statictimer = 0;
					_staticact = -1;
				}
			break;
		}
		_staticind += 0.28;
		
		if(_staticact == -1 || _staticact >= 2){
			_bg_alp += 0.016;
			if(_bg_alp >= 0.28){
				_bg_alp = 0.28;
			}
			
			_other_alp += 0.08;
			if(_other_alp >= 1){
				_other_alp = 1;
			}
		}
		
		//stages
		
		_stageframeind += 0.07;
		
		if(_end){
			_endtimer ++;
			if(_endtimer >= 50){
				global._backtomenu = false;
				with(obj_screen_tr){
					scr_setgamevals();
					
					global._menuminigame = false;
					
					_show = true;
					_type = "out";
					switch(other._stages[other._curoption].stage){
						case "tutorial":
							global._menututorial = true;
							global._loadState = "stage";
						break;
						case "stage2":
							global._menututorial = false;
							global._loadState = "briefing";
							global._location = 1;
						break;
					}
					_roomto = r_loading;
				}
			}
		}
		
		if(_back){
			_backtimer ++;
			if(_backtimer >= 30){
				_displayselect = false;
				
				_input_active = false;
				_input_timer = 0;
				
				_back = false;
				_backtimer = 0;
				
				_showstages = false;
				
				_bg_alp = 0;
				_other_alp = 0;
				
				_staticact = 0;
				_statictimer = 0;
				_staticind = 0;
				_staticscale = 0;
				_staticsnd = false;
				
				_curoption = 0;
				
				sfx_stop(snd_noise_persist);
				
				with(obj_groovymenu){
					mus_play(mus_menu);
					audio_sound_set_track_position(global._cursong, _savemuspos);
					
					_displaymenu = true;
					
					_enter = false
					_enterinit = false;
					_enteract = 0;
					_entertimer = 0;
					_enterscale = [1,1];
					_enterangle = 0;
					_enteroffset = [0,0];
					_enteramp = 0;
	
					_begin = false;
					_begintimer = 0;
	
					_sqr_size = 0;
				}
			}
		}
		
		//input
		if(_input_active && !_end && !_back){
			if(global._menumouse){
				if((mouse_x != _mouseprev[0] || mouse_y != _mouseprev[1]) || mouse_check_button_pressed(mb_left)){
					_mouseactive = true;
					_mouseprev = [mouse_x,mouse_y];
				} else {
					_mouseactive = false;
				}
			} else {
				_mouseactive = false;
			}
		
			if(check_keypress(global._input[global._inptype][? "menu_up"], global._inptype) || check_keypress(global._input[global._inptype][? "up"], global._inptype)){
				_curoption --;
				if(_curoption < 0){
					_curoption = 1;
				}
			} else if(check_keypress(global._input[global._inptype][? "menu_down"], global._inptype) || check_keypress(global._input[global._inptype][? "down"], global._inptype)){
				_curoption ++;
				if(_curoption > 1){
					_curoption = 0;
				}
			}
			
			if(check_keypress(global._input[global._inptype][? "menu_confirm"], global._inptype) || check_keypress(global._input[global._inptype][? "confirm"], global._inptype) || check_keypress(global._input[global._inptype][? "jump"], global._inptype) || (global._menumouse && _optionhovered && mouse_check_button_pressed(mb_left))){
				mus_stop();
				sfx_play(snd_retry);
				_end = true;
			}
			
			if(check_keypress(global._input[global._inptype][? "menu_back"], global._inptype) || check_keypress(global._input[global._inptype][? "pause"], global._inptype) || (global._menumouse && mouse_check_button_pressed(mb_right))){
				mus_stop();
				sfx_play(snd_noise_persist, 1, true);
				_back = true;
			}
			
			_on = true;
			if(_action != ""){
				switch(_action){
					case "backbutton":
						mus_stop();
						sfx_play(snd_noise_persist, 1, true);
						_back = true;
					break;
				}
				_action = "";
			}
		}
	}
}