{
	if(!global._pause){
		if(!_init){
			global._stageentrance = false;
		
			sfx_play(snd_tape3_intro, 0.65);
		
			_init = true;
		}
	
		if(global._cursong != -1 && audio_is_playing(global._cursong)){
			_mus_pos = audio_sound_get_track_position(global._cursong);
		}
		if(_mus_init && !_mus_stop){
			if(!audio_is_playing(mus_briefing)){
				play_music();
			}
		}
	
		with(obj_dialogue){
			_drawYTo = _pos[1];
			_drawY = _drawYTo;
			_pitchmult = other._pitchmult
		}
	
		if((_scene == 0 && _tv_act >= 1) || _scene > 0){
			_skipall_timer ++;
			switch(_skipall_act){
				case 1:
					_skipall_x = ease_out(_skipall_xstart, 0, 50);
					if(_skipall_timer >= 50){
						_skipall_act = 2;
						_skipall_timer = 0;
					}
				break;
				case 2:
					if(_skipall_timer >= 400){
						_skipall_act = 3;
						_skipall_timer = 0;
					}
				break;
				case 3:
					_skipall_x = ease_in(0, _skipall_xstart, 60);
					if(_skipall_timer >= 50){
						_skipall_act = 0;
						_skipall_timer = 0;
					}
				break;
			}
		
			/*if(!_skip && check_keypress(global._input[global._inptype][? "pause"], global._inptype)){
				with(obj_dialogue){
					instance_destroy();
				}
				with(obj_music){
					global.music_bus.effects[0] = undefined;
				}
				mus_stop();
				sfx_stop_all();
				sfx_play(snd_gate_open);
				_caller_appear = false;
				_scene = 3;
			
				_skipall_act = 3;
				_skipall_timer = 0;
			
				_skip = true;
			}*/
		}
	
		switch(_scene){
			case 0:
				//tv intro
				if(!global._dialogue){
					_tv_timer ++;
				}
				
				if(_tv_amp > 0){
					_tv_offset = sin(random(480))*_tv_amp;
					_tv_amp --;
				} else {
					_tv_amp = 0;
				}
				
				switch(_tv_act){
					case 0:
						if(_tv_timer >= 165){
							sfx_stop(snd_tape3_intro);
							sfx_play(snd_noise_persist, 0.32, true);
							_tv_timer = 0;
							_tv_act = 1;
						}
					break;
					case 1:
						//static screen
						_tv_frame += 0.2;
					
						if(_tv_timer >= 80 && !_tv_punch[0]){
							_tv_amp = 36;
							_tv_punch[0] = true;
							sfx_play(snd_slambong1);
						}
					
						if(_tv_timer >= 120 && !_tv_talk1){
							scr_startdialogue("dg_enddemo", "d", 0, false, 0);
							_tv_talk1 = true;
						}
						
						if(_tv_timer >= 150 && !_tv_punch[1]){
							_tv_amp = 30;
							_tv_punch[1] = true;
							sfx_play(snd_slambong2);
						}
						
						if(_tv_timer >= 210 && !_tv_punch[2]){
							_tv_amp = 37;
							_tv_punch[2] = true;
							sfx_play(snd_slambong3);
						}
						
						if(_tv_timer >= 245 && !_tv_punch[3]){
							_tv_amp = 42;
							_tv_punch[3] = true;
							sfx_stop(snd_noise_persist);
							sfx_play(snd_slambong4);
							sfx_play(snd_badhead_crash2);
							
							_tv_frame = 0;
							_tv_timer = 0;
							_tv_act = 2;
						}
					break;
					case 2:
						//insert tape screen
						_tv_frame += 0.04;
					
						if(_tv_timer >= 90 && !_tv_talk2){
							scr_startdialogue("dg_enddemo", "d", 0, false, 1);
							_tv_talk2 = true;
						}
					
						if(_tv_timer >= 180){
							sfx_play(snd_tape);
							_tv_timer = 0;
							_tv_act = 3;
						}
					break;
					case 3:
						//black screen
						if(_tv_timer >= 125){
							_scene = 1;
						}
					break;
				}
			break;
			case 1:
				//pick up the phone, jackass!
				if(!global._dialogue){
					_scene1_timer ++;
				}
			
				if(!_mus){
					sfx_play(mus_hellish);
					audio_sound_gain(mus_hellish, 0.5, 0);
				
					_mus = true;
				}
			
				switch(_scene1_act){
					case 0:
						if(_scene1_timer >= 120){
							audio_sound_gain(mus_hellish, 0, 2600);
							sfx_play(snd_nomios_ringtone, 1, true);
							_scene1_timer = 0;
							_scene1_act = 1;
							_phonering_state = true;
						}
					break;
					case 1:
						_phonering_timer ++;
						if(!_phonering_state){
							if(_phonering_timer >= 110){
								_phonering_timer = 0;
								_phonering_state = !_phonering_state;
							}
						} else {
							if(_phonering_timer >= 60){
								_phonering_timer = 0;
								_phonering_state = !_phonering_state;
							}
						}
						if(_scene1_timer >= 150){
							//move hand to the phone
							_handframe += 0.17;
						
							var handspd = 8;
							if(_handpos >= 580){
								handspd = 4;
							}
							if(_handpos >= 650){
								handspd = 2;
							}
							if(_handpos >= 680){
								handspd = 0;
							
								_scene1_timer = 0;
								_scene1_act = 2;
								_handframe = 0;
								sfx_play(snd_mine_throw, 0.7);
							}
						
							_handpos += handspd;
						}
					break;
					case 2:
						_handframe += 0.4;
						if(_handframe >= 6){
							_showphone = false;
						}
						if(_handframe >= 7){
							if(!_handzip){
								sfx_stop(snd_nomios_ringtone);
								sfx_play(snd_lanky_zip);
								_handzip = true;
							}
						}
						if(_handframe >= 9){
							_handframe = 9;
							_handpos -= 90;
							if(_handpos <= -600){
								_nomio_frame = 0;
								_scene1_timer = 0;
								_scene1_act = 3;
							}
						}
					break;
					case 3:
						_scrollpos += 120;
						if(_scrollpos >= WIDTH-_squareoffset){
							_scrollpos = WIDTH;
							_scene = 2;
						}
					break;
				}
			break;
			case 2:
				//nomio's call
				if(!global._dialogue){
					_scene2_timer ++;
				}
			
				with(obj_dialogue){
					if(_diagstate == 2 && _curchar < string_length(_curtext)+1 && _textarray[_curpg][1] == "nomio"){
						other._nomio_talktimer = 16;
					}
				}
			
				if(_nomio_talktimer <= 0){
					_nomio_mouthframe = 0;
					_nomio_mouthsprite = spr_tape3_nomio1_mouth1;
					if(_scene2_act == 1 || _scene2_act == 4){
						_nomio_mouthsprite = spr_tape3_nomio2_mouth1;
					}
					_nomio_mouthoffset = 0;
				} else {
					if(_nomio_mouthsprite != -1){
						if(_nomio_talktimer % 3 == 0){
							_nomio_mouthframe = irandom_range(0,sprite_get_info(_nomio_mouthsprite).num_subimages-1);
						}
					}
					_nomio_mouthsprite = spr_tape3_nomio1_mouth2;
					if(_scene2_act == 1 || _scene2_act == 4){
						_nomio_mouthsprite = spr_tape3_nomio2_mouth2;
					}
					_nomio_mouthoffset = 45;
				
					_nomio_talktimer --;
				}
			
				switch(_scene2_act){
					case 0:
						//nomio
						if(_scene2_timer >= 60 && !_scene2_talk1){
							scr_startdialogue("dg_enddemo", "d", 0, false, 2);
							_scene2_talk1 = true;
						}
					
						if(_scene2_timer >= 70){
							if(!_caller_appear){
								_mus_init = true;
							}
							_caller_appear = true;
						}
					
						if(_scene2_timer >= 90 && !_scene2_talk2){
							scr_startdialogue("dg_enddemo", "d", 0, false, 3);
							_scene2_talk2 = true;
						}
					
						if(_scene2_timer >= 125){
							_scene2_timer = 0;
							_scene2_act = 1;
						}
					break;
					case 1:
						//bored
						_nomio_sprite = spr_tape3_nomio2;
						_pitchmult = 0.4;
						if(_scene2_timer < 5){
							_nomio_scaley = ease_out(1, 1.2, 8);
						}
						if(_scene2_timer >= 5){
							_nomio_scaley = ease_out_elastic(1.16, 1, 12, 0.8);
						}
					
						if(_scene2_timer >= 90 && !_scene2_talk3){
							scr_startdialogue("dg_enddemo", "d", 0, false, 4);
							_scene2_talk3 = true;
						}
					
						if(_scene2_timer >= 145){
							sfx_play(snd_eyepop);
							_nomio_frame = 0;
							_scene2_timer = 0;
							_scene2_act = 2;
						}
					break;
					case 2:
						//wowza
						_nomio_sprite = spr_tape3_nomio3;
						_nomio_showmouth = false;
						if(_nomio_frame >= 3){
							_nomio_frame = 1;
						}
						if(_scene2_timer >= 100){
							sfx_play(snd_nomio_pissed);
							_nomio_frame = 0;
							_scene2_timer = 0;
							_scene2_act = 3;
						}
					break;
					case 3:
						//pissed off
						_nomio_sprite = spr_tape3_pissed_nomio;
					
						_nomio_handoffset = sin(random(480))*_nomio_handamp;
						_nomio_handamp += 0.08;
						if(_nomio_handamp >= 5){
							_nomio_handamp = 5;
						}
						if(_nomio_frame >= 19){
							_nomio_frame = 17;
						}
					
						if(_scene2_timer >= 225){
							sfx_stop(snd_nomio_pissed);
							_nomio_frame = 0;
							_scene2_timer = 0;
							_scene2_act = 4;
						}
					break;
					case 4:
						//on it
						_nomio_sprite = spr_tape3_nomio2;
						_nomio_showmouth = true;
					
						if(_scene2_timer < 5){
							_nomio_scaley = ease_out(1, 1.2, 8);
						}
						if(_scene2_timer >= 5){
							_nomio_scaley = ease_out_elastic(1.16, 1, 12, 0.8);
						}
					
						if(_scene2_timer >= 40 && !_scene2_talk4){
							scr_startdialogue("dg_enddemo", "d", 0, false, 5);
							_scene2_talk4 = true;
						}
					
						if(_scene2_talk4){
							_skip = true;
						
							_endtimer ++;
							if(_endtimer >= 180){
								with(obj_dialogue){
									instance_destroy();
								}
								with(obj_music){
									global.music_bus.effects[0] = undefined;
								}
								_mus_stop = true;
								mus_stop();
								sfx_play(snd_gate_open);
								_caller_appear = false;
								_scene = 3;
							}
						}
					break;
				}
			break;
			case 3:
				with(obj_pause){
					_canpause = false;
				}
				
				_scene3_timer ++;
				if(_scene3_timer >= 190){
					_scene3_alp -= 0.009;
					if(_scene3_alp <= -0.45){
						global._loadState = "enddemo";
						room_goto(r_loading);
					}
				}
			break;
		}
	
		if(_caller_appear){
			if(_caller_static > 0){
				_caller_static --;
			}
			_callerx = lerp(_callerx, WIDTH-116, 0.2);
		}
	
		if(_scene > 0){
			_nomio_frame += 0.14;
			_sky_frame += 0.03;
			if(_caller_static > 0){
				_callerframe += 0.35;
			} else {
				_callerframe += 0.09;
			}
		}
	}
}