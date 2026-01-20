{
	depth = 25;
	
	if(!_active){
		if(_starttimer > 0){
			_starttimer --; 
		} else {
			_active = true;
		}
	}
	
	//muffle music
	if(global._dialogue){
		_muffle = true;
	}
	
	if(_muffle){
		with(obj_music){
			if(global.music_bus.effects[0] == undefined){
				global.music_bus.effects[0] = _ef_muffled;
			}
		}
	}
	
	//skip
	if(!_end){
		if(check_keypress(global._input[global._inptype][? "pause"], global._inptype)){
			_active = true;
			_starttimer = 0;
			
			_endtimer = 999;
			_endalpha = 1;
			
			_input = false;
			_skip = true;
			_end = true;
			
			sfx_stop_all();
		}
	}

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
	
	if(_active){
		global._stageentrance = false;
		
		if(!_init){
			//load comic
		
			_comic = "stage2";
			script_execute(asset_get_index("scr_comics_"+_comic));
		
			_init = true;
		} else {
			//get panel data
			if(!_pageinit){
				_panels = [];
			
				var curpage = _comics[? _comic][? "page"+string(_curpage)];
				for(var i = 0; i < array_length(curpage[1]); i++){
					_panels[i] = {
						sprite: "spr_comics_"+_comic+"_"+curpage[0][1],
						panel: i,
						xx_start: 0,
						yy_start: 0,
						xx: 0,
						yy: 0,
						scale: 1,
						scale_start: 1,
						easetype: curpage[1][i].easetype,
						slidedur: curpage[1][i].slidedur,
						slidefrom: curpage[1][i].slidefrom,
						alpha: curpage[1][i].alpha,
						alpha_start: curpage[1][i].alpha,
						shake: curpage[1][i].shake,
						sfx: curpage[1][i].sfx,
						delay: curpage[1][i].delay,
						plusdepth: curpage[1][i].plusdepth,
						text_: curpage[1][i].text_,
					}
					//set starting position and size
					switch(_panels[i].slidefrom){
						case "":
							_panels[i].xx = -WIDTH;
							_panels[i].xx_start = _panels[i].xx;
						break;
						case "l":
							_panels[i].xx = -WIDTH;
							_panels[i].xx_start = _panels[i].xx;
						break;
						case "r":
							_panels[i].xx = WIDTH;
							_panels[i].xx_start = _panels[i].xx;
						break;
						case "u":
							_panels[i].yy = -HEIGHT;
							_panels[i].yy_start = _panels[i].yy;
						break;
						case "d":
							_panels[i].yy = HEIGHT;
							_panels[i].yy_start = _panels[i].yy;
						break;
						case "f":
							_panels[i].scale = 2;
							_panels[i].scale_start = _panels[i].scale;
						break;
						case "b":
							_panels[i].scale = 0;
							_panels[i].scale_start = _panels[i].scale;
						break;
					}
				}
			
				if(_skip){
					_curpage = ds_map_size(_comics[? _comic]);
					_curpanel = array_length(_panels)-1;
				}
				
				_pageinit = true;
			} else {
				_timer ++;
				
				//update panels
				var curpanel = _panels[_curpanel];
			
				//sfx
				if(!_skipdg && !_skip && curpanel.sfx != -1){
					sfx_play(curpanel.sfx[0],curpanel.sfx[1]);
					curpanel.sfx = -1;
				}
			
				if(curpanel.delay <= 0){
					//shaking
					if(curpanel.shake > 0){
						_shake_addX = sin(random(480))*curpanel.shake;
						_shake_addY = cos(random(480))*curpanel.shake;
						curpanel.shake --;
					} else {
						_shake_addX = 0;
						_shake_addY = 0;
					}
					if(curpanel.easetype != ""){
						if(curpanel.easetype != "out_elastic"){
							//any other ease
							if(curpanel.slidefrom != ""){
								_panels[_curpanel].xx = script_execute(asset_get_index("ease_"+curpanel.easetype), curpanel.xx_start, 0, curpanel.slidedur, "panelx");
								_panels[_curpanel].yy = script_execute(asset_get_index("ease_"+curpanel.easetype), curpanel.yy_start, 0, curpanel.slidedur, "panely");
								_panels[_curpanel].scale = script_execute(asset_get_index("ease_"+curpanel.easetype), curpanel.scale_start, 1, curpanel.slidedur, "panelscale");
							} else {
								_panels[_curpanel].xx = 0;
							}
							_panels[_curpanel].alpha = script_execute(asset_get_index("ease_"+curpanel.easetype), curpanel.alpha_start, 1, curpanel.slidedur, "panelalpha");
						} else {
							//account for damping
							if(curpanel.slidefrom != ""){
								_panels[_curpanel].xx = script_execute(asset_get_index("ease_"+curpanel.easetype), curpanel.xx_start, 0, curpanel.slidedur, 0.4, "panelx");
								_panels[_curpanel].yy = script_execute(asset_get_index("ease_"+curpanel.easetype), curpanel.yy_start, 0, curpanel.slidedur, 0.4, "panely");
								_panels[_curpanel].scale = script_execute(asset_get_index("ease_"+curpanel.easetype), curpanel.scale_start, 1, curpanel.slidedur, 0.4, "panelscale");
							} else {
								_panels[_curpanel].xx = 0;
							}
							_panels[_curpanel].alpha = script_execute(asset_get_index("ease_"+curpanel.easetype), curpanel.alpha_start, 1, curpanel.slidedur, 0.4, "panelalpha");
						}
					}
				} else {
					curpanel.delay --;
				}
				
				//next panel
				_gonext = false;
				if(curpanel.slidefrom != ""){
					switch(curpanel.slidefrom){
						case "l":
						case "r":
							if(diff_abs(curpanel.xx, 0) < 12){
								_gonext = true;
							}
						break;
						case "u":
						case "d":
							if(diff_abs(curpanel.yy, 0) < 12){
								_gonext = true;
							}
						break;
						case "f":
						case "b":
							if(diff_abs(curpanel.scale, 1) < 0.16){
								_gonext = true;
							}
						break;
					}
				} else {
					if(diff_abs(curpanel.alpha, 1) < 0.16){
						_gonext = true;
					}
				}
				if(curpanel.delay > 0){
					_gonext = false;
				}
				
				if(_gonext){
					_gonext_timer ++;
				}
				
				//end comic
				if(_curpanel >= array_length(_panels)-1){
					if(_curpage >= ds_map_size(_comics[? _comic])){
						_curpanel = array_length(_panels)-1;
						_input = false;
						_end = true;
					}
				}
		
				if(_end){
					_endtimer ++;
					if(_endtimer >= 90){
						_endalpha += 0.015;
						if(_endalpha >= 1){
							_endalpha = 1;
							
							if(!_dialogue){
								scr_startdialogue("dg_stage2", "c", 0);
								_dialogue = true;
							} else {
								if(!_skipdg && check_keypress(global._input[global._inptype][? "pause"], global._inptype)){
									_transition_act = -1;
									_skipdg = true;
									audio_stop_all();
									mus_stop();
									audio_play_sound(mus_stageintro, 0, false);
									audio_sound_gain(mus_stageintro, 0);
									audio_sound_gain(mus_stageintro, 1, 2000);
									_leit = asset_get_index("mus_stageintro_"+string(global._location+1));
									if(audio_exists(_leit)){
										audio_play_sound(_leit, 0, false);
										audio_sound_gain(_leit, 1, 2000);
									}
									with(obj_screen_tr){
										_show = true;
										_type = "out";
										_roomto = r_stageintro;
									}
								}
								if(!global._dialogue){
									_skipdg = true;
									if(_transition_act > 0){
										_transition_timer ++;
									}
									if(_transition_act >= 3){
										_tr_frame += 0.24;
										if(_transition_act == 3){
											if(_tr_frame >= 3){
												with(obj_screen_tr){
													_show = true;
													_type = "out";
													_roomto = r_stageintro;
												}
												
												_transition_timer = 0;
												_transition_act = 4;
											}
										}
										if(_tr_frame >= 7){
											_tr_frame = 7;
										}
									}
									switch(_transition_act){
										case 0:
											_muffle = false;
											global.music_bus.effects[0] = undefined;
											mus_stop();
											audio_play_sound(mus_stageintro, 0, false);
											audio_sound_gain(mus_stageintro, 1);
											var leit = asset_get_index("mus_stageintro_"+string(global._location+1));
											if(audio_exists(leit)){
												audio_play_sound(leit, 0, false);
												audio_sound_gain(leit, 1);
											}
											_transition_timer = 0;
											_transition_act = 1;
										break;
										case 1:
											if(_transition_timer >= 35){
												_transition_timer = 0;
												_transition_act = 2;
											}
										break;
										case 2:
											if(_splash_scale > 1){
												_splash_scale -= 0.16;
											} else {
												_splash_scale = 1;
											}
											if(_splash_amp > 0){
												_splash_amp --;
											} else {
												_splash_amp = 0;
												_splash_amp_y = 2;
											}
											
											if(_transition_timer >= 200){
												audio_play_sound(snd_surf_over, 0, false);
												_transition_timer = 0;
												_transition_act = 3;
											}
										break;
									}
								}
							}
						}
					}
				}
		
				if(_input && check_keypress(global._input[global._inptype][? "confirm"], global._inptype)){
					if(curpanel.delay > 0){
						curpanel.delay = 0;
						curpanel.easetype = "";
					}
					if(ds_map_exists(global._easings, "panelx")){
						global._easings[? "panelx"] = _panels[_curpanel].slidedur;
					}
					if(ds_map_exists(global._easings, "panely")){
						global._easings[? "panely"] = _panels[_curpanel].slidedur;
					}
					if(ds_map_exists(global._easings, "panelscale")){
						global._easings[? "panelscale"] = _panels[_curpanel].slidedur;
					}
					if(ds_map_exists(global._easings, "panelalpha")){
						global._easings[? "panelalpha"] = _panels[_curpanel].slidedur;
					}
					if(curpanel.slidefrom != ""){
						switch(curpanel.slidefrom){
							case "l":
							case "r":
								if(diff_abs(curpanel.xx, 0) >= 12){
									curpanel.xx = 0;
									curpanel.alpha = 1;
								} else {
									curpanel.xx = 0;
									curpanel.alpha = 1;
									updatepanel();
								}
							break;
							case "u":
							case "d":
								if(diff_abs(curpanel.yy, 0) >= 12){
									curpanel.yy = 0;
									curpanel.alpha = 1;
								} else {
									curpanel.yy = 0;
									curpanel.alpha = 1;
									updatepanel();
								}
							break;
							case "f":
							case "b":
								if(diff_abs(curpanel.scale, 1) >= 0.16){
									curpanel.scale = 1;
									curpanel.alpha = 1;
								} else {
									curpanel.scale = 1;
									curpanel.alpha = 1;
									updatepanel();
								}
							break;
						}
					} else {
						if(diff_abs(curpanel.alpha, 1) >= 0.16){
							curpanel.alpha = 1;
						} else {
							curpanel.alpha = 1;
							updatepanel();
						}
					}
				}
			}
		}
	}
}