{
	if(global._bzmaker){
		_bztimer += 0.1;
	}
	
	if(!global._pause && global._bzmaker && global._battlezone){
		if(global._battleobj != noone && instance_exists(global._battleobj)){
			if(array_length(global._battleobj._enemies) == 0){
				array_push(global._battleobj._enemies, []);
			}
				
			if(global._cameraZoom <> 0){
				_bzmousepos = [mouse_x,mouse_y];
			}
				
			if(!_bzpopup){
				//battlezone maker inputs
				if(keyboard_check_pressed(vk_add)){
					array_push(global._bzone_enemies, []);
				} else if(keyboard_check_pressed(vk_subtract)){
					if(array_length(global._bzone_enemies) > 1){
						array_pop(global._bzone_enemies);
					}
				}
					
				//hovering
				if(_hovertimer > 0){
					_hovertimer --;
				} else {
					_hover_enm = noone;
				}
			} else {
				if(_hover_enm != noone && instance_exists(_hover_enm)){
					_hover_enm._drag = false;
				}
				_hover_enm = noone;
				_hovertimer = 0;
			}
				
			if(instance_number_array(global._enemyArray) == 0 && mouse_check_button_pressed(mb_left)){
				if(_hover_enm != noone && instance_exists(_hover_enm)){
					_hover_enm._dragoffset = [_hover_enm.x-mouse_x,_hover_enm.y-mouse_y];
					_hover_enm._drag = true;
					_last_enm = _hover_enm;
				} else {
					if(!_bzpopup){
						//open spawn popup
						if(global._cameraZoom <> 0){
							_bz_mousestart = [(mouse_x-camera_get_view_x(global._camera))/global._cameraZoom, (mouse_y-camera_get_view_y(global._camera))/global._cameraZoom];
						}
						_bzone_enm = instance_create_depth(_bzmousepos[0],_bzmousepos[1], 0, obj_bzone_enemy);
						_last_enm = _bzone_enm;
						_popupopt = -1;
						_bzpopup = true;
					} else {
						if(_popupopt != -1){
							//spawn enemy
							if(_bzone_enm != noone && instance_exists(_bzone_enm)){
								var mask;
								if(global._bzenemies[_popupopt].masksprite == ""){
									mask = asset_get_index("spr_"+global._bzenemies[_popupopt].maskname+"_mask");
								} else {
									mask = asset_get_index(global._bzenemies[_popupopt].masksprite);
								}
								
								if(global._battleobj._curwave > array_length(global._bzone_enemies)-1){
									global._battleobj._curwave = array_length(global._bzone_enemies)-1;
								}
								
								_bzone_enm._wave = global._battleobj._curwave;
								_bzone_enm._index = array_length(global._bzone_enemies[global._battleobj._curwave]);
								_bzone_enm.sprite_index = mask;
								_bzone_enm.mask_index = mask;
								_bzone_enm._disp_index = asset_get_index("spr_"+global._bzenemies[_popupopt].maskname+"_idle");
								_bzone_enm._alts = global._bzenemies[_popupopt].alts;
								if(!is_array(global._bzenemies[_popupopt].disp)){
									if(global._bzenemies[_popupopt].disp != ""){
										_bzone_enm._disp_index = asset_get_index(global._bzenemies[_popupopt].disp);
									}
								} else {
									_bzone_enm._disp_index = asset_get_index(global._bzenemies[_popupopt].disp[0]);
									_bzone_enm._imgindex = global._bzenemies[_popupopt].disp[1];
								}
									
								_bzone_enm._codename = global._bzenemies[_popupopt].maskname;
								if(global._bzenemies[_popupopt].codename != ""){
									_bzone_enm._codename = global._bzenemies[_popupopt].codename;
								}
									
								var temparray = [];
								array_push(temparray,"c"); //dir
									
								var posarray = [];
				
								array_push(posarray,(global._battleobj._bzSize[0]/2)+(_bzone_enm.x-global._battleobj.x));
								array_push(posarray,(global._battleobj._bzSize[1]/2)+(_bzone_enm.y-global._battleobj.y));
									
								array_push(temparray,posarray); //pos
									
								array_push(temparray, 0); //order
									
								if(!global._bzenemies[_popupopt].obj){
									array_push(temparray, [global._bzenemies[_popupopt].maskname,-1]);
								} else {
									array_push(temparray, [global._bzenemies[_popupopt].maskname,"obj",-1]);
								}
									
								array_push(global._bzone_enemies[global._battleobj._curwave], temparray);
									
								_bzpopup = false;
							}
						} else {
							//cancel
							instance_destroy(_bzone_enm.id);
							_bzone_enm = noone;
							_bzpopup = false;
						}
					}
				}
			} else if(mouse_check_button_pressed(mb_right)){
				//destroy spawned enemy_or
				if(!_bzpopup && _hover_enm != noone && instance_exists(_hover_enm)){
					if(!_hover_enm._die){
						global._bzone_enemies[global._battleobj._curwave][_hover_enm._index] = [];
						instance_destroy(_hover_enm);
						_hover_enm = noone;
						_last_enm = noone;
						_hovertimer = 0;
					}
				}
			}
			if(!mouse_check_button(mb_left)){
				with(obj_bzone_enemy){
					_drag = false;
				}
			}
				
			//change alt
			if(mouse_wheel_up()){
				if(_last_enm != noone && instance_exists(_last_enm) && _last_enm._alts){
					if(!_last_enm._die){
						_last_enm._enmtype ++;
						if(_last_enm._enmtype > 1){
							_last_enm._enmtype = -1;
						}
						_last_enm._colorsinit = false;
						
						with(_last_enm){
							if(array_length(global._bzone_enemies[global._battleobj._curwave][_index][3]) == 2){
								global._bzone_enemies[global._battleobj._curwave][_index][3][1] = _enmtype;
							} else if(array_length(global._bzone_enemies[global._battleobj._curwave][_index][3]) == 3){
								global._bzone_enemies[global._battleobj._curwave][_index][3][2] = _enmtype;
							}
						}
					}
				}
			} else if(mouse_wheel_down()){
				if(_last_enm != noone && instance_exists(_last_enm) && _last_enm._alts){
					if(!_last_enm._die){
						_last_enm._enmtype --;
						if(_last_enm._enmtype < -1){
							_last_enm._enmtype = 1;
						}
						_last_enm._colorsinit = false;
						
						with(_last_enm){
							if(array_length(global._bzone_enemies[global._battleobj._curwave][_index][3]) == 2){
								global._bzone_enemies[global._battleobj._curwave][_index][3][1] = _enmtype;
							} else if(array_length(global._bzone_enemies[global._battleobj._curwave][_index][3]) == 3){
								global._bzone_enemies[global._battleobj._curwave][_index][3][2] = _enmtype;
							}
						}
					}
				}
			}
				
			if(keyboard_check_pressed(ord("Q"))){
				if(_last_enm != noone && instance_exists(_last_enm)){
					if(!_last_enm._die){
						_last_enm._order --;
						if(_last_enm._order < 0){
							_last_enm._order = 0;
						}
						with(_last_enm){
							global._bzone_enemies[global._battleobj._curwave][_index][2] = _order;
						}
					}
				}
			} else if(keyboard_check_pressed(ord("W"))){
				if(_last_enm != noone && instance_exists(_last_enm)){
					if(!_last_enm._die){
						_last_enm._order ++;
						if(_last_enm._order > 999){
							_last_enm._order = 999;
						}
						with(_last_enm){
							global._bzone_enemies[global._battleobj._curwave][_index][2] = _order;
						}
					}
				}
			}
				
			if(keyboard_check_pressed(ord("R"))){
				if(_last_enm != noone && instance_exists(_last_enm)){
					if(!_last_enm._die){
						_last_enm._spawntype --;
						if(_last_enm._spawntype < 0){
							_last_enm._spawntype = 0;
						}
						with(_last_enm){
							global._bzone_enemies[global._battleobj._curwave][_index][5] = _spawntype;
						}
					}
				}
			} else if(keyboard_check_pressed(ord("T"))){
				if(_last_enm != noone && instance_exists(_last_enm)){
					if(!_last_enm._die){
						_last_enm._spawntype ++;
						with(_last_enm){
							global._bzone_enemies[global._battleobj._curwave][_index][5] = _spawntype;
						}
					}
				}
			}
				
			if(keyboard_check_pressed(ord("Y"))){
				if(_last_enm != noone && instance_exists(_last_enm)){
					if(!_last_enm._die){
						_last_enm._startFade = !_last_enm._startFade;
						with(_last_enm){
							global._bzone_enemies[global._battleobj._curwave][_index][4] = _startFade;
						}
					}
				}
			}
				
			if(keyboard_check_pressed(vk_enter)){
				if(!_bzpopup && !global._bzactive){
					//activate all enemies
					global._battleobj._enemies = [];
					for(var r = 0; r < array_length(global._bzone_enemies); r++){
						global._battleobj._enemies[r] =	global._bzone_enemies[r];
					}
					with(obj_bzone_enemy){
						_die = true;
					}
					global._battleobj._waveinit = false;
					global._bzactive = true;
				}
			}
				
			//log spawn information
			if(keyboard_check_pressed(vk_shift)){
				if(!global._bzactive){
					show_debug_message("--- BATTLEZONE SPAWN INFORMATION "+ string(global._timer) +" ---");
					show_debug_message("_enemies = [");
					for(var i = 0; i < array_length(global._bzone_enemies); i++){
						//waves
						if(array_length(global._bzone_enemies[i]) > 0){
							show_debug_message("	[");
							for(var o = 0; o < array_length(global._bzone_enemies[i]); o++){
								//enemies
								if(array_length(global._bzone_enemies[i][o]) > 0){
									show_debug_message("		"+string(global._bzone_enemies[i][o])+",");
								}
							}
							show_debug_message("	],");
						}
					}
					show_debug_message("]");
					show_debug_message("--- ---");
				}
			}
		}
	}
}