{
	if(!global._pause){
		image_speed = 1;
		
		_pos[0] = (WIDTH/2)+60;
		if(_scrdir == "u"){
			_pos[1] = 130;
		} else if(_scrdir == "d"){
			_pos[1] = HEIGHT-156;
		} else if(_scrdir == "c"){
			_pos[1] = floor(HEIGHT/2);
		}
		
		//boss popup
		if(_bossaction[0] && !_bossaction[1]){
			_scrdir = "d";
		}
		if(_bossaction[0] && _bossaction[1]){
			_scrdir = "c";
		}
		
		_diagfadereal = lerp(_diagfadereal, _diagfadeto, 0.16);
		
		global._dialogue = _show;
		
		//tutorial music fix
		if(global._tutorial && !global._stageentrance && instance_number(obj_startstar) == 0){
			if(_fix_cooldown <= 0){
				if(global._cursong == -1){
					with(obj_music){
						_musicstart = true;
						_musicinit = false;
					}
				} else {
					if(!audio_is_playing(global._cursong)){
						with(obj_music){
							_musicstart = true;
							_musicinit = false;
						}
					}
				}
				_fix_cooldown = 60;
			} else {
				_fix_cooldown --;
			}
		}
		
		if(!global._stageentrance){
			if(_show){
				if(_tips_active != ""){
					with(obj_tipbox){
						if(_prompt == other._tips_active){
							_active = true;
						}
					}
					_tips_active = "";
				}
				if(_stopmove){
					if(!_lockcamera){
						if(!global._battlezone){
							//create borders
							var pos = [[global._cameraX,global._cameraY+((HEIGHT*global._defCamZoom)/2)],[global._cameraX+(WIDTH*global._defCamZoom),global._cameraY+((HEIGHT*global._defCamZoom)/2)]];
							var sX = sprite_get_width(spr_battleborder);
							var sY = sprite_get_height(spr_battleborder);
							var size = [[1, HEIGHT/(sY/2)],[1, HEIGHT/(sY/2)]];
							var bds = ["l","r"];
							for(var i = 0; i < 2; i++){
								var b = instance_create_depth(pos[i][0], pos[i][1], 0, obj_battleborder);
								b.image_xscale = size[i][0];
								b.image_yscale = size[i][1];
								b._side = bds[i];
								_borders[i] = b.id;
							}
					
							_lockobj = instance_create_depth(global._cameraX+((WIDTH*global._defCamZoom)/2),global._cameraY+((HEIGHT*global._defCamZoom)/2), 0, obj_dialoguelock);
					
							with(obj_camera){
								other._savecammode = _mode;
								if(other._lockobj != noone && instance_exists(other._lockobj)){
									_finalhitTarget = other._lockobj;
									_mode = 2;
								}
							}
						}
					
						_lockcamera = true;
					}
					if(_lockobj != noone && instance_exists(_lockobj)){
						if(_borders[0] != noone && instance_exists(_borders[0])){
							_borders[0].x = _borders[0]._startx + _lockobj._offsetX;
							_borders[0].y = _borders[0]._starty + _lockobj._offsetY;
						}
						if(_borders[1] != noone && instance_exists(_borders[1])){
							_borders[1].x = _borders[1]._startx + _lockobj._offsetX;
							_borders[1].y = _borders[1]._starty + _lockobj._offsetY;
						}
					}
				}
			
				if(_scrdir == "d"){
					with(obj_gui){
						ui_fade("dh",0);
						ui_fade("tnt",0);
					}
				}
				if(_scrdir == "u"){
					with(obj_gui){
						ui_fade("boss",0);
						ui_fade("enemy",0);
					}
				}
			
				if(_diagstate == 0){
					_timer ++;
				}
			
				_sintimer ++;
				_drawX = _pos[0];
				_drawYTo = _pos[1];
				_drawY = (_drawY + (_drawYTo - _drawY) * 0.2) + (sin(_sintimer/42)*2);
			
				if(_diag_init && !_fx){
					if(_curpg <= array_length(_textarray)-1 && string_starts_with(_textarray[_curpg][1], "fx_")){
						switch(_textarray[_curpg][1]){
							case "fx_static":
								_fx = true;
								_noise = 60;
								sfx_stop(snd_noise);
								sfx_play(snd_noise_persist, 1, true);
							break;
						}
					}
				}
			
				if(_fx && _noise > 0){
					_curhead = -1;
				}
			
				switch(_diagstate){
					case 0:
						if(!_diag_init && _timer >= _starttimer){
							script_execute(asset_get_index("scr_"+_scrindex), _diag_act);
							_diag_init = true;
							_diagstate = 1;
						}
					break;
					case 1:
						sprite_index = spr_diag_popup;
						if(image_index >= image_number-1){
							sfx_play(snd_noise);
							_noise = 12;
							_diagstate = 2;
				
							_curtext = scr_wordwrap(_textarray[_curpg][0], _wrap, "\n", false);
							_keysArray = scr_dialogue_setkeys(_curtext, _keysArray);
							_typetext = "";
							_curchar = 1;
						}
					break;
					case 2:
						sprite_index = spr_diag;
						if(_textarray[_curpg][1] != "???"){
							_curhead = asset_get_index("spr_diag_heads_"+_textarray[_curpg][1]);
						} else {
							_curhead = -1;
						}
						if(!_fx && _noise <= 0){
							_canSkip = _textarray[_curpg][2];
				
							_diagtimer ++;
					
							if(_diagtimer % 6 == 0){
								if(_curhead != -1){
									_headframe = round(random_range(0, sprite_get_info(_curhead).num_subimages-1));
								}
								_scaleXTo = random_range(0.3, 1.2);
								_scaleYTo = random_range(0.3, 1.2);
								if(_curchar < string_length(_curtext)+1){
									switch(_textarray[_curpg][1]){
										case "dh":
											sfx_play_choose([snd_diag_dh1,snd_diag_dh2,snd_diag_dh3,snd_diag_dh4]);
										break;
										case "dialm":
											sfx_play_choose([snd_diag_dialm1,snd_diag_dialm2,snd_diag_dialm3,snd_diag_dialm4]);
										break;
										case "lanky":
											sfx_play_choose([snd_diag_lanky1,snd_diag_lanky2,snd_diag_lanky3,snd_diag_lanky4], 0.8);
										break;
										case "nomio":
											sfx_play_choose([snd_diag_nomio1,snd_diag_nomio2,snd_diag_nomio3,snd_diag_nomio4], 0.65);
											sfx_pitch(snd_diag_nomio1, random_range(1.32,1.55)*_pitchmult);
											sfx_pitch(snd_diag_nomio2, random_range(1.32,1.55)*_pitchmult);
											sfx_pitch(snd_diag_nomio3, random_range(1.32,1.55)*_pitchmult);
											sfx_pitch(snd_diag_nomio4, random_range(1.32,1.55)*_pitchmult);
										break;
									}
								}
							}
							if(_diagtimer % 1 == 0){
								if(_curchar < string_length(_curtext)+1){
									_typetext = scr_textrender_typewrite(_curtext, _typetext, _curchar, _keysArray)[0];
									_curchar = scr_textrender_typewrite(_curtext, _typetext, _curchar, _keysArray)[1];
								}
							}
						
							if(_curchar >= string_length(_curtext)+1){
								_headframe = 0;
								_scaleXTo = _defScale;
								_scaleYTo = _defScale;
							}
				
							_scaleX = _scaleX + (_scaleXTo - _scaleX) * 0.5;
							_scaleY = _scaleY + (_scaleYTo - _scaleY) * 0.5;

							if(_canSkip){
								if(check_keypress(global._input[global._inptype][? "confirm"], global._inptype)){
									if(_curchar < string_length(_curtext)+1){
										//show full text if wasnt done typing
										_curchar = string_length(_curtext)+1;
										_typetext = _curtext;
									} else {
										//next paragraph
										_curpg ++;
						
										if(_curpg < array_length(_textarray)){
											if(_textarray[_curpg-1][1] <> _textarray[_curpg][1]){
												sfx_play(snd_noise);
												_noise = 12;
											}
						
											setPg();
										} else {
											//end dialogue
											image_index = 0;
											_diagstate = 3;
											_timer = 0;
											_diagend = true;
										}
									}
								}
							}
						}
						
						if(_fx && _noise <= 0){
							//next paragraph
							_curpg ++;
						
							if(_curpg < array_length(_textarray)){
								if(_textarray[_curpg-1][1] <> _textarray[_curpg][1]){
									sfx_stop(snd_noise_persist);
									_noise = 0;
								}
						
								setPg();
							} else {
								//end dialogue
								image_index = 0;
								_diagstate = 3;
								_timer = 0;
								_diagend = true;
							}
							
							_fx = false;
						}
					break;
					case 3:
						sprite_index = spr_diag_popout;
						if(image_index >= image_number-1){
							_diagstate = 0;
							_show = false;
						}
					break;
				}
			
				//partially hide dialogue when dh collides with it
				with(obj_dh_mask){
					if(other._scrdir == "d" && (y-global._cameraY)-_height >= HEIGHT-220){
						other._diagfadeto = 0.55;
					} else if(other._scrdir == "u" && (y-global._cameraY)-_height <= 365){
						other._diagfadeto = 0.55;
					} else {
						other._diagfadeto = 1;
					}
				}
			
				//static noise
				if(_noise > 0){
					_noisetimer ++;
					if(_noisetimer % 4 == 0){
						_noiseframe ++;
						if(_noiseframe >= 3){
							_noiseframe = 0;
						}
					}
					_noise --;
				} else {
					_noisetimer = 0;
					_noiseframe = 0;
				}
			} else {
				if(_stopmove){
					if(!global._battlezone){
						with(obj_camera){
							_finalhitTarget = noone;
							_mode = other._savecammode;
						}
				
						if(_borders[0] != noone && instance_exists(_borders[0])){
							instance_destroy(_borders[0].id);
						}
						if(_borders[1] != noone && instance_exists(_borders[1])){
							instance_destroy(_borders[1].id);
						}
				
						if(_lockobj != noone && instance_exists(_lockobj)){
							instance_destroy(_lockobj.id);
						}
					}
					
					_lockcamera = false;
					_savecammode = 0;
				
					_stopmove = false;
				}
			}
		}
	} else {
		image_speed = 0;
	}
}