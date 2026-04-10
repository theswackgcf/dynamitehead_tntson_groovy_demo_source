{
	if(!global._lode_editor && global._lode_playmode){
		_earned = clamp(global._lode_score - _lode_monyx, 0, 9999999);
		global._addmonyx = _earned;
		with(obj_pause){
			_curmonyx = global._lode_score;
			_totalmonyx = other._lode_monyx;
		}
	}
	
	if(global._lode_lives > 1){
		global._pause_prevent_restart = false;
	} else {
		global._pause_prevent_restart = true;
	}
	
	if(!global._pause && _tr_draw){
		if(!global._lode_editor){
			if(_tr_type == "in"){
				if(!sfx_isplaying(snd_lode_noise)){
					sfx_play(snd_lode_noise);
				}
				if(_tr_img >= 4){
					if(_tr_img >= 6){
						_tr_scale_spd[0] += 0.02;
						_tr_scale[0] -= _tr_scale_spd[0];
					}
					_tr_scale_spd[1] += 0.04;
					_tr_scale[1] -= _tr_scale_spd[1];
				}
				if(_tr_img < 4){
					_tr_scale[1] += 0.14;
				}
				
				if(_tr_scale[0] < 0){
					_tr_scale[0] = 0;
				}
				if(_tr_scale[1] < 0){
					_tr_scale[1] = 0;
				}
				if(_tr_img >= 4 && _tr_scale[1] <= 0.5){
					_tr_done = true;
				}
				if(_tr_scale[0] <= 0 && _tr_scale[1] <= 0){
					_tr_draw = false;
				}
				
				_tr_img += 0.2;
			} else if(_tr_type == "out"){
				_tr_alp += 0.1;
				if(_tr_alp >= 1.1){
					if(!_exit_tr){
						room_restart();
					} else {
						global._loadState = "tomenu";
						room_goto(r_loading);
					}
				}
			}
		} else {
			_tr_done = true;
			_tr_draw = false;
		}
	}
	
	if(!global._pause && !global._gameover_stopall){
		_bgtimer += 0.05;
		
		global._lode_spd = (global._lode_curloop+2)*0.33;
		global._lode_spd = clamp(global._lode_spd,1,2.5);
		
		if(!global._lode_editor && global._lode_playmode){
			if(!_init_howto){
				global._lode_howto = !global._lode_help;
				if(global._lode_howto){
					for(var i = 0; i < array_length(_howto_text); i++){
						_howto_text_wrapped[i] = scr_wordwrap(_howto_text[i],(_howto_size[0]-74)*3,"/n",false);
					}
					
					_howto_act = 1;
				}
				_init_howto = true;
			}
			
			var howto_center = _disp_dim[1]*0.5;
			
			switch(_howto_act){
				case 0:
					_howto_timer = 0;
				break;
				case 1:
					_howto_timer ++;
					if(_howto_timer >= 32){
						_howto_pos[1] -= 15;
						_howto_bg_alp += 0.02;
						if(_howto_bg_alp > 0.26){
							_howto_bg_alp = 0.26;
						}
						if(_howto_pos[1] <= howto_center-16){
							_howto_pos[1] = howto_center-16;
							_howto_act = 2;
						}
					}
				break;
				case 2:
					//navigating the how to screen
					_howto_pos[1] = lerp(_howto_pos[1],howto_center,0.18);
					if(_howto_page < array_length(_howto_text)-1){
						if(check_keypress(global._input[global._inptype][? "confirm"],global._inptype) || check_keypress(global._input[global._inptype][? "menu_select"],global._inptype)){
							sfx_play(snd_mg_popaway);
							_howto_act = 3;
						}
					}
					
					if(_howto_page > 0){
						if(check_keypress(global._input[global._inptype][? "left"],global._inptype) ||
						check_keypress(global._input[global._inptype][? "menu_left"],global._inptype)){
							sfx_play(snd_mg_popnext);
							_howto_page --;
						}
					}
					
					if(check_keypress(global._input[global._inptype][? "right"],global._inptype) ||
					check_keypress(global._input[global._inptype][? "menu_right"],global._inptype)){
						if(_howto_page < array_length(_howto_text)-1){
							sfx_play(snd_mg_popnext);
							_howto_page ++;
						} else {
							sfx_play(snd_mg_popaway);
							_howto_act = 3;
						}
					}
				break;
				case 3:
					_howto_pos[1] += 24;
					_howto_bg_alp -= 0.07;
					if(_howto_pos[1] >= _disp_dim[1]+(_howto_size[1]*0.5)){
						global._lode_howto = false;
						global._lode_help = true;
						_howto_act = 0;
					}
				break;
			}
		}
			
		if(_howto_act > 0){
			_howto_bbox = [
				floor(_howto_pos[0]-(_howto_size[0]*0.5)),
				floor(_howto_pos[1]-(_howto_size[1]*0.5)),
				floor(_howto_pos[0]+(_howto_size[0]*0.5)),
				floor(_howto_pos[1]+(_howto_size[1]*0.5)),
			];
		}
		
		//music
		if(global._cursong != -1){
			global._lode_muspitch = clamp(1+(global._lode_curloop*0.12),1,1.7);
			if(_gameover){
				if(global._lode_muspitch > 1){
					global._lode_muspitch -= 0.03;
				}
			}
			var bosspitch = 1;
			if(global._lode_boss){
				bosspitch = 0.14;
			}
			mus_pitch(clamp(_mus_spd*global._lode_muspitch*bosspitch, 0.1, 3.5));
		}
		
		var addoffset = [0,0];
		var dims = [global._stage_dims[0],global._stage_dims[1]];
		if(global._lode_editor){
			addoffset = [_editor_dispoffset[0],_editor_dispoffset[1]];
			dims = [_editor_dims[0],_editor_dims[1]];
		}
		
		//interpolate background
		var bg_horiz_offset = [sprite_get_width(spr_lode_bg1)-_disp_dim[0],sprite_get_width(spr_lode_bg2)-_disp_dim[0]];
		var bg_vert_offset = [sprite_get_height(spr_lode_bg1)-_disp_dim[1],sprite_get_height(spr_lode_bg2)-_disp_dim[1]];
		
		if(array_length(_stagedims_nooffset) > 0){
			if(_stagedims_nooffset[0] > _disp_dim[0]+(global._lode_tilesize*2)){
				//clamp position
				var offs = _stagedims_nooffset[0] - (_disp_dim[0]/2);
				if(offs < 0){
					offs = 0;
				} else if(offs+_disp_dim[0] > dims[0]+addoffset[0]){
					offs = (dims[0]+addoffset[0])-_disp_dim[0];
				}
		
				var centerpoint = offs*0.5;
		
				//-100% left, 0 % center, 100% right
				var percent = 0;
				if(centerpoint <> 0){
					percent = -((_offset[0]/centerpoint)-1);
				}
		
				for(var i = 0; i < array_length(_bgoffset); i++){
					_bgoffset[i][0] = ((bg_horiz_offset[i]*0.5)*percent);
				}
			}
			if(_stagedims_nooffset[1] > _disp_dim[1]+(global._lode_tilesize*2)){
				//clamp position
				var offs = _stagedims_nooffset[1] - (_disp_dim[1]/2);
				if(offs < 0){
					offs = 0;
				} else if(offs+_disp_dim[1] > dims[1]+addoffset[1]){
					offs = (dims[1]+addoffset[1])-_disp_dim[1];
				}
		
				var centerpoint = offs*0.5;
		
				//-100% top, 0 % center, 100% bottom
				var percent = 0;
				if(centerpoint <> 0){
					percent = -((_offset[1]/centerpoint)-1);
				}
		
				for(var i = 0; i < array_length(_bgoffset); i++){
					_bgoffset[i][1] = ((bg_vert_offset[i]*0.5)*percent);
				}
			}
		}
		
		if(_tr_exit_act > 0){
			_tr_exit_timer ++;
		}
		
		//next level transition
		switch(_tr_exit_act){
			case 1:
				if(_tr_exit_timer >= 38){
					_tr_exit_scale = 0;
					_tr_exit_timer = 0;
					_tr_exit_act = 2;
				}
			break;
			case 2:
				_tr_exit_scale_spd += 0.014;
					
				_tr_exit_scale += _tr_exit_scale_spd;
				if(_tr_exit_scale > 1){
					_tr_exit_scale = 1;
					_tr_exit_timer = 0;
					_tr_exit_act = 3;
				}
			break;
			case 3:
				if(_tr_exit_timer >= 24){
					//move to the next level
					
					if(global._lode_boss){
						mus_stop();
					}
					
					if(!global._lode_tutorial){
						global._lode_stage ++;
						if(global._lode_boss){
							global._lode_boss = false;
							global._lode_loopback = true;
						}
					}
					scr_lode_game_init(true);
					
					room_restart();
				}
			break;
		}
		
		if(!_tr_done){
			with(obj_lode_plr){
				_freeze = 6;
			}
			for(var i = 0; i < array_length(global._lode_collide_enemy); i++){
				with(global._lode_collide_enemy[i]){
					_freeze = 6;
				}
			}
			with(obj_lode_boulder){
				_freeze = 6;
			}
			with(obj_lode_stalactite){
				_freeze = 6;
			}
		}
		
		if(global._lode_editor){
			//level editor mode
			if(!_init){
				instance_create_depth(0,0,0,obj_lode_camera);
				
				if(!global._lode_testmode_load){
					//make empty stage
					for(var zz = 0; zz < 2; zz++){
						global._stage_layout[zz] = [];
						for(var yy = 0; yy < _editor_defsize[1]; yy++){
							global._stage_layout[zz][yy] = [];
							for(var xx = 0; xx < _editor_defsize[0]; xx++){
								global._stage_layout[zz][yy][xx] = 0;
							}
						}
					}
					
					global._sign_load_done = true;
				} else {
					global._cursong = -1;
					audio_stop_all();
					
					for(var i = 0; i < 2; i++){
						global._stage_layout[i] = [];
						for(var yy = 0; yy < array_length(global._lode_testlayout[i]); yy++){
							global._stage_layout[i][yy] = [];
							for(var xx = 0; xx < array_length(global._lode_testlayout[i][yy]); xx++){
								global._stage_layout[i][yy][xx] = global._lode_testlayout[i][yy][xx];
							}
						}
					}
					ds_map_copy(global._sign_layout,global._lode_testsigns);
					global._sign_load_done = true;
				}
				
				update_dimensions(false,[true,true]);
				
				global._lode_testmode_load = false;
		
				//add tiles to tile array
				for(var i = 0; i < 999; i++){
					if(ds_map_exists(_tileinfo, i)){
						var curtile = _tileinfo[? i];
						var spr = -1;
						if(curtile.editorspr == -1){
							spr = object_get_sprite(curtile.obj);
						} else {
							spr = curtile.editorspr;
						}
						
						var name = object_get_name(curtile.obj);
						if(curtile.obj == -1){
							if(curtile.tile){
								name = "bg tile";
							}
						}
						
						_editor_tiles[i] = {
							tile: i,
							tilename: name,
							sprite: spr,
							order: curtile.order,
						}
					} else {
						if(i > 0){
							break;
						} else {
							_editor_tiles[i] = {
								tile: 0,
								tilename: "air",
								sprite: -1,
								order: 0,
							}
						}
					}
				}
				
				array_sort(_editor_tiles, function(a,b) {
					return a.order - b.order;
				});
		
				_init = true;
			} else {
				if(!_editor_help){
					if(!_savepopup){
						var mult = [_disp_dim[0]/WIDTH,_disp_dim[1]/HEIGHT];
						_editor_mousepos[0] = _offset[0]+(mouse_x*mult[0])-_editor_dispoffset[0]-_stage_offset[0];
						_editor_mousepos[1] = _offset[1]+(mouse_y*mult[1])-_editor_dispoffset[1]-_stage_offset[1];
			
						_editor_mousetile[0] = floor(_editor_mousepos[0]/global._lode_tilesize);
						_editor_mousetile[1] = floor(_editor_mousepos[1]/global._lode_tilesize);
		
						if(_editor_tilemenu_timer > 0){
							_editor_tilemenu_timer --;
						} else {
							_editor_tilemenu_tile = -1;
						}
			
						if(_editor_place_cd > 0){
							_editor_place_cd --;
						}
			
						//moving camera around
						if(!keyboard_check(vk_shift)){
							if(!keyboard_check(vk_control)){
								var cam = instance_find(obj_lode_camera,0);
								if(instance_exists(cam)){
									var camspd = 8;
									if((keyboard_check(ord("A")) && keyboard_check(ord("D"))) || (!keyboard_check(ord("A")) && !keyboard_check(ord("D")))){
										cam._xspd = 0;
									} else if(keyboard_check(ord("A"))){
										cam._xspd = -camspd;
									} else if(keyboard_check(ord("D"))){
										cam._xspd = camspd;
									}
					
									if((keyboard_check(ord("W")) && keyboard_check(ord("S"))) || (!keyboard_check(ord("W")) && !keyboard_check(ord("S")))){
										cam._yspd = 0;
									} else if(keyboard_check(ord("W"))){
										cam._yspd = -camspd;
									} else if(keyboard_check(ord("S"))){
										cam._yspd = camspd;
									}
								}
							}
						} else {
							//resizing
							var updatearray = false;
							var update_dims_tiles = false;
							var update_which = [false,false];
					
							if(keyboard_check_pressed(ord("A"))){
								if(_editor_dims_tiles[0] > 1){
									_editor_dims_tiles[0] --;
									updatearray = true;
									update_dims_tiles = true;
								}
							} else if(keyboard_check_pressed(ord("D"))){
								if(_editor_dims_tiles[0] < 999){
									_editor_dims_tiles[0] ++;
									updatearray = true;
									update_dims_tiles = true;
								}
							}
							if(keyboard_check_pressed(ord("W"))){
								if(_editor_dims_tiles[1] > 1){
									_editor_dims_tiles[1] --;
									updatearray = true;
									update_dims_tiles = true;
								}
							} else if(keyboard_check_pressed(ord("S"))){
								if(_editor_dims_tiles[1] < 999){
									_editor_dims_tiles[1] ++;
									updatearray = true;
									update_dims_tiles = true;
								}
							}
					
							if(_editor_dims_tiles[0] > array_length(global._stage_layout[0][0])){
								for(var z = 0; z < array_length(global._stage_layout); z++){
									for(var i = 0; i < array_length(global._stage_layout[z]); i++){
										array_push(global._stage_layout[z][i], LTILE_AIR);
									}
								}
						
								updatearray = true;
								update_which = [true,false];
								update_dims_tiles = false;
								
							}
							if(_editor_dims_tiles[1] > array_length(global._stage_layout[0])){
								for(var z = 0; z < array_length(global._stage_layout); z++){
									var array = [];
									for(var i = 0; i < array_length(global._stage_layout[z][0]); i++){
										array_push(array,LTILE_AIR);
									}
									array_push(global._stage_layout[z], array);
								}
						
								updatearray = true;
								update_which = [false,true];
								update_dims_tiles = false;
							}
					
							if(updatearray){
								_centerset = false;
								
								delete_objects();
								place_objects();
						
								update_dimensions(update_dims_tiles,update_which);
							}
						}
			
						//layers
						if(keyboard_check_pressed(ord("1"))){
							_editor_curlayer = 0;
							
							_editor_tileselect_dsmap = ds_map_create();
							_editor_tileset_gottiles = false;
							_editor_tileselect = false;
						} else if(keyboard_check_pressed(ord("2"))){
							_editor_curlayer = 1;
							
							_editor_tileselect_dsmap = ds_map_create();
							_editor_tileset_gottiles = false;
							_editor_tileselect = false;
						}
		
						if(!_editor_tileselect){
							if(!_editor_tileset_gottiles){
								//placing/removing tiles
								if(_editor_mousetile[0] >= 0 && _editor_mousetile[1] >= 0){
									if(_editor_mousetile[0] <= array_length(global._stage_layout[0][0])-1 && _editor_mousetile[1] <= array_length(global._stage_layout[0])-1){
										if(!_editor_tilemenu){
											if(_editor_place_cd <= 0 && mouse_check_button(mb_left)){
												global._stage_layout[_editor_curlayer][_editor_mousetile[1]][_editor_mousetile[0]] = _editor_tile;
											} else if(mouse_check_button(mb_right)){
												global._stage_layout[_editor_curlayer][_editor_mousetile[1]][_editor_mousetile[0]] = LTILE_AIR;
											}
												
											if((_editor_place_cd <= 0 && mouse_check_button_released(mb_left)) || mouse_check_button_released(mb_right)){
												delete_objects();
												place_objects();
											}
										}
									}
								}
									
								_editor_gottiles_drag = false;
								_editor_gottiles_drag_pos = [_editor_mousetile[0],_editor_mousetile[1]];
								_editor_gottiles_drag_offset = [0,0];
								_editor_drag_prevoffset = [0,0];
									
								//found tiles to move
								if(ds_map_size(_editor_tileselect_dsmap) > 0){
									_editor_tileset_gottiles = true;
								}
							} else {
								//drag selected tiles around
								if(!_editor_gottiles_drag){
									if(mouse_check_button_pressed(mb_left)){
										_editor_gottiles_drag_pos = [_editor_mousetile[0],_editor_mousetile[1]];
											
										_editor_gottiles_drag = true;
									}
								} else {
									var temptile = [floor(_editor_mousepos[0]/global._lode_tilesize)+_editor_drag_prevoffset[0],floor(_editor_mousepos[1]/global._lode_tilesize)+_editor_drag_prevoffset[1]];
									_editor_gottiles_drag_offset[0] = temptile[0] - _editor_gottiles_drag_pos[0];
									_editor_gottiles_drag_offset[1] = temptile[1] - _editor_gottiles_drag_pos[1];
										
									if(!mouse_check_button(mb_left)){
										_editor_drag_prevoffset[0] = _editor_gottiles_drag_offset[0];
										_editor_drag_prevoffset[1] = _editor_gottiles_drag_offset[1];
										_editor_gottiles_drag = false;
									}
								}
									
								if(keyboard_check_pressed(vk_space)){
									//place all moved tiles on the grid
										
									var dskeys = ds_map_keys_to_array(_editor_tileselect_dsmap);
									for(var d = 0; d < array_length(dskeys); d++){
										var cur = _editor_tileselect_dsmap[? dskeys[d]];
										global._stage_layout[_editor_curlayer][cur[1]][cur[0]] = LTILE_AIR;
									}
									for(var d = 0; d < array_length(dskeys); d++){
										var cur = _editor_tileselect_dsmap[? dskeys[d]];
										var offsetpos = [
											cur[0]+_editor_gottiles_drag_offset[0],
											cur[1]+_editor_gottiles_drag_offset[1],
										];
										if(offsetpos[0] >= 0 && offsetpos[0] <= _editor_dims_tiles[0]){
											if(offsetpos[1] >= 0 && offsetpos[1] <= _editor_dims_tiles[1]){
												global._stage_layout[_editor_curlayer][offsetpos[1]][offsetpos[0]] = cur[2];
											}
										}
									}
										
									delete_objects();
									place_objects();
										
									_depthsort_timer = 99;
										
									_editor_tileselect_dsmap = ds_map_create();
									_editor_tileset_gottiles = false;
									_editor_tileselect = false;
								} else if(keyboard_check_pressed(vk_backspace)){
									//cancel selection
										
									_editor_tileselect_dsmap = ds_map_create();
									_editor_tileset_gottiles = false;
									_editor_tileselect = false;
								} else if(keyboard_check_pressed(vk_delete)){
									//delete all selected tiles
									var dskeys = ds_map_keys_to_array(_editor_tileselect_dsmap);
									for(var d = 0; d < array_length(dskeys); d++){
										var cur = _editor_tileselect_dsmap[? dskeys[d]];
										global._stage_layout[_editor_curlayer][cur[1]][cur[0]] = LTILE_AIR;
									}
										
									delete_objects();
									place_objects();
										
									_depthsort_timer = 99;
										
									_editor_tileselect_dsmap = ds_map_create();
									_editor_tileset_gottiles = false;
									_editor_tileselect = false;
								}
							}
								
							//selecting an area of tiles using the middle mouse
							if(mouse_check_button(mb_middle)){
								_editor_tileselect_dsmap = ds_map_create();
								_editor_tileset_gottiles = false;
									
								_editor_tileselect_size = [0,0];
								_editor_tileselect_pos = [_editor_mousetile[0],_editor_mousetile[1]];
								_editor_tileselect_mousepos = [_editor_mousetile[0],_editor_mousetile[1]];
								_editor_tileselect = true;
							}
						} else {
							if(!mouse_check_button(mb_middle)){
								_editor_tileselect = false;
								_editor_tileset_gottiles = false;
									
								_editor_tileselect_pos = [_editor_mousetile[0],_editor_mousetile[1]];
								_editor_tileselect_mousepos = [_editor_mousetile[0],_editor_mousetile[1]];
							}
						}
							
						//selecting all tiles
						if(!mouse_check_button(mb_middle) && keyboard_check(vk_control) && keyboard_check_pressed(ord("A"))){
							_editor_tileselect_dsmap = ds_map_create();
							_editor_tileset_gottiles = false;
							_editor_tileselect = true;
								
							_editor_gottiles_drag_offset = [0,0];
							_editor_tileselect_pos = [0,0];
							_editor_tileselect_mousepos = [_editor_dims_tiles[0],_editor_dims_tiles[1]];
						}
							
						
						if(_editor_tileselect){
							//clamp values
							_editor_tileselect_pos[0] = clamp(_editor_tileselect_pos[0], 0, _editor_dims_tiles[0]);
							_editor_tileselect_pos[1] = clamp(_editor_tileselect_pos[1], 0, _editor_dims_tiles[1]);
								
							_editor_tileselect_mousepos[0] = clamp(_editor_tileselect_mousepos[0], 0, _editor_dims_tiles[0]);
							_editor_tileselect_mousepos[1] = clamp(_editor_tileselect_mousepos[1], 0, _editor_dims_tiles[1]);

							_editor_tileselect_size = [
								max(1,diff_abs(_editor_tileselect_pos[0],_editor_tileselect_mousepos[0])),
								max(1,diff_abs(_editor_tileselect_pos[1],_editor_tileselect_mousepos[1])),
							];
							
							_editor_tileselect_mousepos[0] = _editor_mousetile[0];
							_editor_tileselect_mousepos[1] = _editor_mousetile[1];
								
							if(_editor_tileselect_mousepos[0] < _editor_tileselect_pos[0]){
								_editor_tileselect_size[0] *= -1;
							}
								
							if(_editor_tileselect_mousepos[1] < _editor_tileselect_pos[1]){
								_editor_tileselect_size[1] *= -1;
							}
						}
				
						if(!_editor_tileselect && keyboard_check_pressed(ord("E"))){
							_editor_tilemenu = true;
							_editor_boxpos = [-_offset[0]+_editor_mousepos[0]+_editor_dispoffset[0],-_offset[1]+_editor_mousepos[1]+_editor_dispoffset[1]];
						}
						if(_editor_tilemenu){
							//selecting tiles
							if(mouse_check_button_pressed(mb_left)){
								if(_editor_tilemenu_tile != -1){
									_editor_tile = _editor_tilemenu_tile;
									_editor_tilemenu_tile = -1;
								}
								_editor_place_cd = 12;
								_editor_tilemenu = false;
							}
						}
				
						//testing stage
						if(keyboard_check_pressed(vk_enter)){
							if(global._lode_deletedStuff != undefined && global._lode_deletedStuff != -1){
								ds_map_destroy(global._lode_deletedStuff);
							}
							scr_lode_game_init();
							
							global._lode_testsigns = ds_map_create();
							global._lode_testlayout = [];
							for(var i = 0; i < 2; i++){
								global._lode_testlayout[i] = [];
								for(var yy = 0; yy < _editor_dims_tiles[1]; yy++){
									global._lode_testlayout[i][yy] = [];
									for(var xx = 0; xx < _editor_dims_tiles[0]; xx++){
										global._lode_testlayout[i][yy][xx] = global._stage_layout[i][yy][xx];
									}
								}
							}
							
							ds_map_copy(global._lode_testsigns, global._sign_layout);
					
							global._lode_playmode = false;
							global._lode_testmode = true;
							global._lode_editor = false;
							room_restart();
						}
				
						//save level into .json
						if(keyboard_check(vk_control) && keyboard_check_pressed(ord("S"))){
							global._lode_testsigns = ds_map_create();
							global._lode_testlayout = [];
							for(var i = 0; i < 2; i++){
								global._lode_testlayout[i] = [];
								for(var yy = 0; yy < _editor_dims_tiles[1]; yy++){
									global._lode_testlayout[i][yy] = [];
									for(var xx = 0; xx < _editor_dims_tiles[0]; xx++){
										global._lode_testlayout[i][yy][xx] = global._stage_layout[i][yy][xx];
									}
								}
							}
							ds_map_copy(global._lode_testsigns,global._sign_layout);
					
							//assemble json array into a single string
							var strexport = json_stringify(global._lode_testlayout, false);
							var strexport_sign = json_encode(global._lode_testsigns);
							
							var finalstr = "{\"stage\":"+strexport+","+"\"signs\":"+strexport_sign+"}"
						
							var addtime = "-"+string(current_year)+"-"+string(current_month)+"-"+string(current_day)+"-"+string(current_hour)+"-"+string(current_minute)+"-"+string(current_second);
							var file = "dh_lodelevel_"+addtime+".json";
						
							//export string into a json and save to working directory
							var file_id = file_text_open_write(_dir+file);
							file_text_write_string(file_id, finalstr);
							file_text_close(file_id);
					
							//copy path and do popup
							clipboard_set_text(game_save_id+_dir);
					
							_popuptimer = 5;
							_savepopup = true;
						}
					
						//load level from .json
						if(keyboard_check(vk_control) && keyboard_check_pressed(ord("L"))){
							if(global._lode_deletedStuff != undefined && global._lode_deletedStuff != -1){
								ds_map_destroy(global._lode_deletedStuff);
							}
							scr_lode_game_init();
							
							var filter = "(*.json)|*.json";
							var file = get_open_filename(filter, "");
						
							if(file != ""){
								var curfile = file_text_open_read(file);
								var json_str = "";
							
								//read json file
								while(!file_text_eof(curfile)) {
									json_str += file_text_read_string(curfile);
									file_text_readln(curfile);
								}
								file_text_close(curfile);
							
								global._lode_testsigns = json_decode(json_stringify(json_parse(json_str).signs));
								global._lode_testlayout = json_parse(json_str).stage;
								global._lode_testmode_load = true;
								room_restart();
							}
						}
					} else {
						_popuptimer --;
						if(_popuptimer <= 0 && mouse_check_button_pressed(mb_left)){
							_editor_place_cd = 30;
							_savepopup = false;
						}
					}
				}
				
				if(keyboard_check_pressed(vk_f1)){
					//show/hide editor instructions
					_editor_help = !_editor_help;
				}
			}
		} else {
			//game mode
			if(!_init){
				instance_create_depth(0,0,0,obj_lode_camera);
				
				_editor_dispoffset = [0,0];
				
				//load layout
				if(global._lode_playmode){
					if(_stagesobj != noone && instance_exists(_stagesobj)){
						if(global._lode_stage == 0){
							scr_lode_game_init();
						}
						if(global._lode_loopback){
							global._lode_curloop ++;
							global._lode_stage = 1;
							global._lode_curboss ++;
							global._lode_loopback = false;
						}
						
						var stage_str = "tutorial";
						if(!global._lode_tutorial){
							stage_str = "stage"+string(global._lode_stage);
						}
						
						if(!ds_map_exists(global._lode_stages,stage_str)){
							//boss
							stage_str = "boss"+string(global._lode_curboss);
							if(!ds_map_exists(global._lode_stages,stage_str)){
								global._lode_curboss = 1;
								stage_str = "boss"+string(global._lode_curboss);
							}
						}
						var stage = global._lode_stages[? stage_str];
						var variant = irandom_range(0,array_length(stage)-1);;
						if(global._cur_variation != -1){
							variant = global._cur_variation;
						} else {
							global._cur_variation = variant;
						}
						
						var json_str = stage[variant];
						
						global._lode_testsigns = json_decode(json_stringify(json_str.signs));
						global._lode_testlayout = json_str.stage;
						
						load_stage();
					}
				} else {
					load_stage();
				}
		
				_init = true;
			}
			
			if(global._lode_tnt_hold_timer > 0){
				global._lode_tnt_hold_timer --;
			} else {
				global._lode_tnt_hold = 0;
			}
		}
		
		if(_init){
			if(!global._lode_boss){
				if(instance_number(obj_lode_soulboss) > 0){
					global._lode_boss = true;
				}
			}
			
			if(_scr_shake_x > 0){
				_scr_shake_x -= 0.4;
			} else {
				_scr_shake_x = 0;
			}
			if(_scr_shake_y > 0){
				_scr_shake_y -= 0.4;
			} else {
				_scr_shake_y = 0;
			}
			_scr_shake_offset[0] = sin(random(480))*(_scr_shake_x*global._shakevals[global._shakeval]);
			_scr_shake_offset[1] = cos(random(480))*(_scr_shake_y*global._shakevals[global._shakeval]);
			
			//scrolling
			if(_scrollobj != noone){
				_scrollinst = instance_find(_scrollobj,0);
				if(instance_exists(_scrollinst)){
					var addoffset = [0,0];
					var dims = [global._stage_dims[0],global._stage_dims[1]];
					if(global._lode_editor){
						addoffset = [_editor_dispoffset[0],_editor_dispoffset[1]];
						dims = [_editor_dims[0],_editor_dims[1]];
					}
					
					_stagedims_nooffset = [
						array_length(global._stage_layout[0][0])*global._lode_tilesize,
						array_length(global._stage_layout[0])*global._lode_tilesize
					];
					if(global._lode_editor){
						_stagedims_nooffset = [
							_editor_dims_tiles[0]*global._lode_tilesize,
							_editor_dims_tiles[1]*global._lode_tilesize
						];
					}
					
					//center stage on screen
					if(!_centerset){
						if(_stagedims_nooffset[0] < _disp_dim[0]){
							_editor_dispoffset[0] = 0;
							_stage_offset[0] = (_disp_dim[0]/2)-(_stagedims_nooffset[0]/2);
						} else {
							_editor_dispoffset[0] = _editor_dispoffset_init[0];
							_stage_offset[0] = 0;
						}
						if(_stagedims_nooffset[1] < _disp_dim[1]){
							_editor_dispoffset[1] = 0;
							_stage_offset[1] = (_disp_dim[1]/2)-(_stagedims_nooffset[1]/2);
						} else {
							_editor_dispoffset[1] = _editor_dispoffset_init[1];
							_stage_offset[1] = 0;
						}
						
						if(!global._lode_editor){
							_editor_dispoffset[0] = 0;
							_editor_dispoffset[1] = 0;
						}
						
						delete_objects();
						place_objects();
						
						_centerset = true;
					}
					
					//center on instance
					if(dims[0] > _disp_dim[0]){
						_offset[0] = _scrollinst.x - (_disp_dim[0]/2);
					
						//clamp position
						if(_offset[0] < 0){
							_offset[0] = 0;
						} else if(_offset[0]+_disp_dim[0] > dims[0]+addoffset[0]){
							_offset[0] = (dims[0]+addoffset[0])-_disp_dim[0];
						}
					}
				
					//center on instance
					if(dims[1] > _disp_dim[1]){
						_offset[1] = _scrollinst.y - (_disp_dim[1]/2);
					
						//clamp position
						if(_offset[1] < 0){
							_offset[1] = 0;
						} else if(_offset[1]+_disp_dim[1] > dims[1]+addoffset[1]){
							_offset[1] = (dims[1]+addoffset[1])-_disp_dim[1];
						}
					}
					
					if(global._lode_editor){
						//proper bounds
						if(_scrollinst.x < _disp_dim[0]/2){
							_scrollinst.x = _disp_dim[0]/2;
						}
						if(_scrollinst.y < _disp_dim[1]/2){
							_scrollinst.y = _disp_dim[1]/2;
						}
						
						var width = dims[0]+_editor_dispoffset[0];
						var height = dims[1]+_editor_dispoffset[1];
						
						if(_scrollinst.x > width-(_disp_dim[0]/2)){
							_scrollinst.x = width-(_disp_dim[0]/2);
						}
						if(_scrollinst.y > height-(_disp_dim[1]/2)){
							_scrollinst.y = height-(_disp_dim[1]/2);
						}
					}
					
					global._lode_camera_pos = [_offset[0]+(_disp_dim[0]/2),_offset[1]+(_disp_dim[1]/2)];
				}
			}
			
			var cull_offs = 128;
			
			global._lode_cullingoffset = [
				_offset[0],_offset[1],
			];
			
			global._lode_cullingbox = [
				-cull_offs,
				-cull_offs,
				_disp_dim[0]+cull_offs,
				_disp_dim[1]+cull_offs,
			];
		}
		
		//exit gate sign
		if(_exit_trigger){
			_exit_timer ++;
			switch(_exit_act){
				case 0:
					_exit_bottomalp += 0.03;
					if(_exit_bottomalp > 0.65){
						_exit_bottomalp = 0.65;
					}
					_exit_bottomy = lerp(_exit_bottomy, _disp_dim[1], 0.16);
					
					_exit_spacing --;
					if(_exit_spacing <= 0){
						_exit_timer = 0;
						_exit_act = 1;
					}
				break;
				case 1:
					_exit_bottomy = _disp_dim[1];
					if(_exit_timer >= 230){
						_exit_timer = 0;
						_exit_act = 2;
					}
				break;
				case 2:
					_exit_bottomalp -= 0.05;
					_exit_bottomy += 2;
					
					_exit_spacing += 7;
					if(_exit_spacing >= 640){
						_exit_trigger = false;
					}
				break;
			}
		} else {
			_exit_spacing = 48;
			_exit_timer = 0;
			_exit_act = 0;
			
			_exit_bottomy = _disp_dim[1]+sprite_get_height(spr_lode_gui_bottom);
			_exit_bottomalp = 0;
		}
	
		_depthsort_timer ++;
		if(_depthsort_timer >= 4){
			//depth sort
			_deptharray = [];
			var dskeys = ds_map_keys_to_array(_project);
			
			for(var i = 0; i < array_length(dskeys); i++){
				if(!array_contains(_deptharray, _project[? dskeys[i]].depth_)){
					array_push(_deptharray,_project[? dskeys[i]].depth_);
				}
			}
			array_sort(_deptharray, function(elm1, elm2){
				return elm1 - elm2;
			});
			
			_depthsort_timer = 0;
		}
		
		_lode_score_lerp = lerp(_lode_score_lerp, global._lode_score, 0.12);
		
		//collectable combos
		if(global._lode_collect_combo >= 10){
			global._lode_collect_combo = 10;
		}
		
		if(global._lode_collect_combo_timer > 0){
			global._lode_collect_combo_timer --;
		} else {
			global._lode_collect_combo = 1;
		}
		
		_tnt_lerp = lerp(_tnt_lerp,global._lode_tnt,0.1);
		
		_ui_alpha = lerp(_ui_alpha, _ui_alphaTo, 0.07);
		
		// ui cap
		global._lode_lives = clamp(global._lode_lives, 0, 9);
		global._lode_collect_cur = clamp(global._lode_collect_cur, 0, 99);
		global._lode_collect_max = clamp(global._lode_collect_max, 0, 99);
		global._lode_tnt = clamp(global._lode_tnt, 0, 100);
		global._lode_stage = clamp(global._lode_stage, 0, 99);
		global._lode_curboss = clamp(global._lode_curboss, 0, 99);
		global._lode_score = clamp(global._lode_score,0,9999999);
		_lode_score_lerp = clamp(_lode_score_lerp,0,9999999);
	}
	
	if(_gameover){
		minigame_lose_step(global._lode_score);
	}
	if(_over_exit && !_exit_tr){
		_tr_draw = true;
		_tr_type = "out";
		_tr_alp = 0;
		
		_exit_tr = true;
	}
	
	if(global._pause){
		mus_pitch(1);
	}
	
	if(!global._lode_playmode){
		if(global._lode_testmode && !global._pause && keyboard_check_pressed(vk_escape)){
			global._lode_testmode = false;
			global._lode_testmode_load = true;
			global._lode_editor = true;
			room_restart();
		}
	}
}