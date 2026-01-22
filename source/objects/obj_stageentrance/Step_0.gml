{
	if(!global._pause){
		if(!_colorsinit){
			if(global._tutorial){
				_rep = "st0";
			} else {
				_rep = "st"+string(global._location+1);
			}
			makecolors("def",_rep);
		
			_colorsinit = true;
		}
		
		_starttimer ++;
		if(_starttimer >= _startval){
			if(global._stageentrance){
				if(global._debug){
					if(keyboard_check_pressed(vk_enter)){
						global._stageentrance = false;
						instance_destroy();
					}
				}
				
				var dh = instance_nearest(x,y,obj_dh_mask);
				if(dh != noone && instance_exists(dh)){
					dh._hptimer = 25;
				}
				with(obj_game){
					ui_fade("dh", 0);
					ui_fade("tnt", 0);
				}
				if(global._tutorial && _act < 1){
					sfx_play(snd_wantedamb);
					_act = 1;
					_ripped = true;
					_postershow = false;
					_poster = false;
					_timer = 40;
				}
			}
			_timer ++;
			if(_act >= 1){
				_posterscale += 0.0005;
				if(_posterscale >= 1){
					_posterscale = 1;
				}
			}
			switch(_act){
				case 0:
					if(_timer >= 40){
						_timer = 0;
						_act ++;
						sfx_play(snd_wantedamb);
						sfx_play(snd_wanted);
					}
				break;
				case 1:
					_postertimer ++;
					if(_postertimer >= 3){
						_postertimer = 0;
						_posterframe ++;
						if(_posterframe >= 3){
							_postershow = false;
						}
					}
				
					if(_timer >= 60){
						_timer = 0;
					
						if(!global._tutorial){
							_handshow = true;
							sfx_play_choose(global._swishsounds[0]);
						}
						voice_play_choose([snd_dh_voice_ready1,snd_dh_voice_ready2,snd_dh_voice_ready3,snd_dh_voice_ready4,snd_dh_voice_ready5,snd_dh_voice_ready6,snd_dh_voice_ready7], global._dhvoices, 1);
					
						_act ++;
					}
				break;
				case 2:
					_handtimer ++;
					if(_handtimer >= 3){
						_handtimer = 0;
						_handframe ++;
						if(_handframe >= 2){
							if(!_ripped){
								_ripped = true;
								sfx_play(snd_wantedrip);
							}
						}
						if(_handframe >= 4){
							_handshow = false;
						}
					}
					
					var time_ = 35;
					if(global._tutorial){
						time_ = 0;
					}
				
					if(_timer >= time_){
						_timer = 0;
					
						_dynamiteshow = true;
						_xvel = 18;
						_yvel = -32;
						sfx_play(snd_jump);
					
						with(obj_fade){
							_fadeTo = 1;
							_fadefgTo = 0;
							_fadeSpd = 1;
							_mode = 1;
						}
					
						_act ++;
					}
				break;
				case 3:
					_dynamitetimer ++;
					if(_dynamitetimer >= 2){
						_dynamitetimer = 0;
						_dynamiteframe ++;
						if(!_end_anim){
							if(_dynamiteframe >= 7){
								sfx_play(snd_swish1);
								sfx_pitch(snd_swish1, random_range(0.8,1.2));
								_dynamiteframe = 0;
							}
						} else {
							if(_dynamiteframe >= 11){
								_dynamiteframe = 5;
							}
						}
					}
				
					if(_dynamiteshow){
						var dh = instance_nearest(x,y,obj_dh_display);
						var dhmask = instance_nearest(x,y,obj_dh_mask);
						if(dh != noone && instance_exists(dh) && dhmask != noone && instance_exists(dhmask)){
							if(!_setdir){
								if(dh.x-global._cameraX < (WIDTH/2)-64){
									_dir = DIR_L;
									_xpos = WIDTH-_offset;
								} else {
									_dir = DIR_R;
								}
								_setdir = true;
							}
							_ypos += _yvel;
							_yvel += _grav;
							if(_yvel >= 2){
								if(!_end_anim && _dynamiteframe >= 6){
									_dynamitetimer = 0;
									_dynamiteframe = 0;
									_end_anim = true;
									sfx_stop(snd_swish1);
									sfx_play(snd_swish2);
								}
							}
							if(_yvel < 0){
								_xpos = lerp(_xpos, (dh.x-global._cameraX)+(_dhoffset[0]*_dir), 0.05);
								_scale -= 0.017;
							} else {
								_scale -= 0.08;
								_xpos += _xvel*_dir;
								_xvel -= 0.6;
								if(_scale < 0.52){
									_scale = 0.52;
								}
							}
						
							if(_yvel > -3){
								_poster = false;
							}
			
							if(_xvel <= 0){
								_xvel = 0;
							}
						
							if(_yvel > 0 && _ypos >= (dh.y-global._cameraY)+_dhoffset[1]){
								_ypos = (dh.y-global._cameraY)+_dhoffset[1];
								dh._beginspd = 9;
								
								depth = -6000;
								_showbg = false;
								_drawnorm = true;
								
								with(dhmask){
									_anim_tr_anim = "intro3";
									_anim_tr_init = false;
									_anim_transition = true;
								}
								_yvel = 0;
								_dynamiteshow = false;
								_timer = 0;
								_act ++;
							
								with(obj_st2_rain){
									_rainactive = true;
								}
								with(obj_st2_rain_floor){
									_rainactive = true;
								}
							
								sfx_play_choose([snd_dhthud,snd_dhthud2,snd_dhthud3]);
							
								global._speedruntimer = 0;
							
								with(obj_camera){
									_ampY = 12;
								}
							
								if(global._buildver == HTML){
									with(obj_startstar){
										instance_destroy();
									}
								}
							
								global._stageentrance = false;
							}
						}
					}
				break;
			}
		}
		
		if(!global._stageentrance){
			if(surface_exists(_gui_surface)){
				surface_free(_gui_surface);
			}
			if(surface_exists(_resizegui_surface)){
				surface_free(_resizegui_surface);
			}
		}
	}
}