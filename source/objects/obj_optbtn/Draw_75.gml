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
		if(!_pausebtn){
			if(_layer == 1){
				_multpl = [1.6,1.15];
			}
		} else {
			if(_state == "confirm"){
				_multpl[0] = 1.5;
				_multpl[1] = 1.3;
			}
		}
		
		if(!_getwidth){
			_xsize = (scr_textrender_width(_text)*_multpl[0])+64;
			_ysize = (scr_textrender_height(_text)*_multpl[1])+32;
			
			_getwidth = true;
		}
	
		if(_getwidth){
			//left top right bottom
			_bbox = [_xpos - (_xsize/2), _ypos - (_ysize/2), _xpos + (_xsize/2), _ypos + (_ysize/2)];
	
			_scaleparam = [global._res[global._curres][0]/WIDTH,global._res[global._curres][1]/HEIGHT];
	
			_dispbox = [_bbox[0]-96,_bbox[1]-48,_bbox[2]+164,_bbox[3]+_stretchbottom+48];
			if(_id == "inp"){
				_dispbox[0] = _bbox[0]-196;
				_dispbox[2] = _bbox[2]+196;
			}
			_dispsize = [_dispbox[2]-_dispbox[0],_dispbox[3]-_dispbox[1]];
			_disppos = [_dispbox[0],_dispbox[1]];
				
			_getsize = true;
		}
		
		if(!_pausebtn){
			if(_optionsobj._show && _optionsobj._state == _state){
				if(global._debug && global._showHitbox){
					draw_set_alpha(0.45);
					draw_rectangle(_bbox[0]+_stretchleft,_bbox[1],_bbox[2]+_stretchright,_bbox[3]+_stretchbottom, false);
					draw_set_alpha(1);
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
				} else {
					scr_textrender_wave_y(0, 0);
					color = global._menuColorNo;
					xoffset = 0;
					if(_state != "main"){
						color = #656565;
						alpha = 0.7;
					}
				}
		
				//debug
				/*draw_set_color(#00FF00);
				draw_rectangle(_bbox[0]+_stretchleft,_bbox[1],_bbox[2]+_stretchright,_bbox[3]+_stretchbottom, false);
				draw_set_color(#FFFFFF);*/
		
				if(_id == "scr" || _id == "vsync" || _id == "filter" || _id == "unfocused_mute"){
					xoffset = -28;
				}
		
				if(_id == "scr"){
					xoffset = 0;
				}
				if(_id == "inptype"){
					xoffset = -18;
				}
				
				if(_id == "mouse" || _id == "kd" || _id == "tips" || _id == "bird" || _id == "surfl" || _id == "bgsky"){
					xoffset = -42;
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
						case "surfl":
							var getsurfl;
							if(!global._surflighting){
								getsurfl = 0;
							} else {
								getsurfl = 1;
							}
							if(_btnonscreen){
								draw_sprite_ext(spr_menu_checkbox, getsurfl, _xpos+global._screenOffsetX+xoffset+352-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], 1.4, 1.4, 0, color, 1);
							}
						break;
						case "bgsky":
							var getbgsky;
							if(!global._skyshader){
								getbgsky = 0;
							} else {
								getbgsky = 1;
							}
							if(_btnonscreen){
								draw_sprite_ext(spr_menu_checkbox, getbgsky, _xpos+global._screenOffsetX+xoffset+380-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], 1.4, 1.4, 0, color, 1);
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
						case "bird":
							var getbird;
							if(!global._birdmode){
								getbird = 0;
							} else {
								getbird = 1;
							}
							if(_btnonscreen){
								draw_sprite_ext(spr_menu_checkbox, getbird, _xpos+global._screenOffsetX+xoffset+262-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], 1.4, 1.4, 0, color, 1);
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
							if(_unavailable){
								color = c_black;
							}
							scr_textrender_type(_xpos+global._screenOffsetX+xoffset-_surfaceoffs[0], _ypos+global._screenOffsetY-_surfaceoffs[1], string_upper(_text), true, color, alpha, _maintextscale, _maintextscale);
							scr_textrender_halign("left");
							scr_textrender_switchfont(global._defaultFont);
						}
		
						scr_textrender_wave_y(0, 0);
					}
				} else {
					_on = false;
				}
			}
		}
	}
}