{
	if(!global._pause){
		if(global._winscreen){
			_addcash_spdmult = 2.2+((global._moneypickups.cur-1)*0.6);
				
			if(_addcash_amp > 0){
				_addcash_amp --;
			} else {
				_addcash_amp = 0;
			}
				
			if(global._knockouts <= 0){
				_hellyeah = true;
			}
		
			//slide things onto screen
			var spd = 0.15;
			_dhx = _dhx + (_dhslide-_dhx)*spd;
			if(_dhwinobj != noone && instance_exists(_dhwinobj)){
				_dhwinobj._posx = _dhx;
			}
			_winy = _winy + (_winslide-_winy)*spd;
		
			_bgwinobj._alpha = lerp(_bgwinobj._alpha, _alphato, 0.16);
			
			_wintime ++;
		
			if(!_hellyeah){
				switch(_winact){
					case 0:
						if(_wintime >= 0){
							_alphato = 0.7;
							_dhslide = 0;
							_winact ++;
						}
					break;
					case 1:
						if(_wintime >= 30){
							_winslide = 130;
							_bgwinobj._drawspot = true;
							_winact = 5;
						}
					break;
					case 5:
						if(_wintime >= 120){
							sfx_play(snd_cash);
							_textspacing[0] = 30;
							_textactive[0] = true;
							_textsize[0] = 2;
							_winact ++;
						}
					break;
					case 6:
						if(_wintime >= 200){
							//count extra cash
							if(!_addcash_draw){
								if(_addcash_total < global._moneypickups.cur){
									_addcash_randcur = irandom_range(0,array_length(_addcash_rand)-1);
		
									_addcash_draw = true;
									_addcash_scale = 3;
									_addcash_pos = [_addcash_rand[_addcash_randcur].xpos,HEIGHT+240];
									_addcash_spd = [_addcash_rand[_addcash_randcur].xspd,_addcash_rand[_addcash_randcur].yspd];
								
									_addcash_amnt = global._plusmoney.cur[_addcash_total];
										
									sfx_play_choose([snd_swish1,snd_swish2,snd_swish3]);
								} else {
									_wintime = 0;
									_textactive[1] = true;
									_textsize[1] = 2;
									_textspacing[1] = 30;
									_winact ++;
								}
							}
						}
					break;
					case 7:
						if(_wintime >= 40){
							_winact = 8;
						}
					break;
					case 9:
						if(_wintime >= 60){
							_confirmexit = true;
							_winact ++;
						}
					break;
				}
			
				if(_winact >= 6){
					if(_textspacing[0] > 0){
						_textspacing[0] -= 3;
					}
					if(_textspacing[0] <= 0){
						_textspacing[0] = 0;
					}
					for(var i = 0; i < array_length(_textsize); i++){
						if(_textactive[i]){
							if(_textsize[i] > 1){
								_textsize[i] -= 0.25;
							}
							if(_textsize[i] < 1){
								_textsize[i] = 1;
							}
						}
					}
				}
			
				if(_winact >= 7){
					if(_textspacing[1] > 0){
						_textspacing[1] -= 3;
					}
					if(_textspacing[1] <= 0){
						_textspacing[1] = 0;
					}
				
					//mess up music
					if(global._cursong != -1){
						_winpitchtimer --;
						if(_winpitchtimer <= 0){
							_pitchmod = clamp(clamp(_tempKO, 0, 10)*0.07, 0.2, 1.8);
							_pitchmodlerp = lerp(_pitchmodlerp,_pitchmod, 0.04);
							mus_pitch(random_range(1-_pitchmodlerp,1+_pitchmodlerp));
							_winpitchtimer = 90;
						}
					}
				}
			
				if(_winact == 8){
					_kotimer ++;
					if(_kotimer % 12 == 0){
						global._reward += global._badnums[global._location];
						sfx_play_choose(global._kdsounds);
						if(!ds_map_exists(_badnumb, _tempKO)){
							_badnumb[? _tempKO] = [floor(WIDTH/2)+430, 390, 1, string(global._badnums[global._location]), #FF1317];
						}
							
						global._pad_vibrate = 2;
					
						with(obj_windh){
							image_index = 0;
							_state = "hurt";
							_hurtanim = round(random_range(1,3));
							_punches ++;
						}
					
						_koHeight = 0;
						_koSpd = -7;
						_tempKO += 1;
						if(_tempKO >= global._knockouts || _tempKO >= 10){
							with(obj_windh){
								_ranking = true;
							}
							_wintime = 0;
							_winact = 9;
						}
					}
				}
			} else {
				//HELL YEAH!!!
				switch(_winact){
					case 0:
						if(_wintime >= 0){
							_alphato = 0.7;
							_dhslide = 0;
							_winact ++;
						}
					break;
					case 1:
						if(_wintime >= 30){
							_bgwinobj._drawspot = true;
							_winact ++;
						}
					break;
					case 2:
						if(_wintime >= 40){
							sfx_play(snd_charge);
							_dhwinobj.image_index = 0;
							_dhwinobj._state = "hellyeah1";
							_winact ++;
						}
					break;
					case 3:
						_lettertime ++;
						if(_lettertime % 10 == 0){
							if(_curletter < array_length(_spawnletter)){
								if(_spawnletter[_curletter] == 0){
									var letr = instance_create_depth(0, 0, 0, obj_winhellyeah);
									letr.image_index = _curletter;
									letr._xpos = _letrpos[_curletter][0]-64;
									letr._ypos = _letrpos[_curletter][1];
									_spawnletter[_curletter] = 1;
								}
							} else {
								_wintime = 0;
								_winact ++;
							}
							_curletter ++;
						}
					break;
					case 4:
						if(_wintime >= 30){
							sfx_play(snd_explosion2);
							with(obj_camera){
								_ampX = 20;
								_ampY = 20;
							}
								
							global._pad_vibrate = 16;
								
							_bgwinobj._drawspot = false;
							_bgwinobj._drawfire = true;
							_dhwinobj.image_index = 0;
							_dhwinobj._state = "hellyeah2";
							_dhwinobj._hellyeahexp = 1;
							
							_wintime = 0;
							_winact ++;
						}
					break;
					case 5:
						if(_wintime >= 25){
							sfx_play(snd_perfect);
							_wintime = 0;
							_winact ++;
						}
					break;
					case 6:
						if(_wintime >= 60){
							if(!_addcash_draw){
								if(_addcash_total < global._moneypickups.cur){
									_addcash_randcur = irandom_range(0,array_length(_addcash_rand)-1);
		
									_addcash_draw = true;
									_addcash_scale = 3;
									_addcash_pos = [_addcash_rand[_addcash_randcur].xpos,HEIGHT+240+260];
									_addcash_spd = [_addcash_rand[_addcash_randcur].xspd,_addcash_rand[_addcash_randcur].yspd];
								
									_addcash_amnt = global._plusmoney.cur[_addcash_total];
									
									sfx_play_choose([snd_swish1,snd_swish2,snd_swish3]);
								} else {
									_confirmexit = true;
									_winact ++;
								}
							}
						}
					break;
				}
			}
		
			if(_winact >= 6 || _hellyeah){
				//sub money
				for(var j = 0; j < ds_map_size(_badnumb); j++){
					if(ds_map_exists(_badnumb, j)){
						_badnumb[? j][1] -= 1.2;
						_badnumb[? j][2] -= 0.03;
						scr_textrender_type(_badnumb[? j][0], _badnumb[? j][1], _badnumb[? j][3], false, _badnumb[? j][4], _badnumb[? j][2]);
						if(_badnumb[? j][2] <= 0){
							ds_map_delete(_badnumb, j);
						}
					}
				}
				_koHeight += _koSpd;
				_koSpd += 0.7;
				if(_koHeight >= 0){
					_koSpd = 0;
					_koHeight = 0;
				}
			}
		
			if(_confirmexit && !_exit_enddemo){
				if(check_keypress(global._input[global._inptype][? "confirm"],global._inptype) || check_keypress(global._input[global._inptype][? "menu_select"],global._inptype)){							
					sfx_play(snd_comic_advance);
					mus_stop();
						
					//save money
					global._curmonyx += global._reward;
					with(obj_game){
						scr_savevalue(global._curmonyx, "Monyx", _gamesavefile, "", true, true);
					}
						
					with(obj_screen_tr){
						_show = true;
						_type = "out";
						global._loadState = "tapes";
						_roomto = r_loading;
					}
					_exit_enddemo = true;
				}
			}
		}
	
		if(_addcash_draw){
			//extra cash code
			_addcash_pos[0] += _addcash_spd[0]*_addcash_spdmult;
			_addcash_pos[1] += _addcash_spd[1]*_addcash_spdmult;
			_addcash_spd[1] += 0.4*_addcash_spdmult;
			_addcash_scale -= _addcash_rand[_addcash_randcur].scalespd*_addcash_spdmult;
					
			var maxheight = HEIGHT-320;
			var ypos = 390;
			if(_hellyeah){
				ypos = 570;
			}
					
			if(_addcash_spd[1] > 0 && _addcash_pos[1] >= maxheight){
				_badnumb = ds_map_create();
				_badnumb[? 0] = [floor(WIDTH/2)+430, ypos, 1, "+"+string(_addcash_amnt), #96ed1c];
						
				global._reward += _addcash_amnt;
						
				_addcash_amp = 14;
						
				sfx_play(snd_addcash);
				sfx_pitch(snd_addcash, random_range(0.9,1.1));
						
				_addcash_total ++;
				_addcash_draw = false;
			}
		}	
	}
}