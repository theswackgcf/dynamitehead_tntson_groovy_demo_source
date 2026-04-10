{
	if(!_shadowsinit){
		//shadows
		global._gameshadows[? _occupy_id] = ds_map_create();
		global._gameshadows[? _occupy_id][? "draw"] = false;
		global._gameshadows[? _occupy_id][? "x"] = x;
		global._gameshadows[? _occupy_id][? "y"] = y;
		global._gameshadows[? _occupy_id][? "scalex"] = _shadsize[0];
		global._gameshadows[? _occupy_id][? "scaley"] = _shadsize[1];
		
		_shadowsinit = true;
	}
	
	visible = _visible;
	if(global._debug && !_visible){
		visible = global._showHitbox;
	}
	
	if(!global._pause){		
		if(_freeze <= 0){
			if(!_setspawndir){
				if(_spawndir == "l"){
					_curdir = DIR_R;
				} else if(_spawndir == "r"){
					_curdir = DIR_L;
				}
				
				_setspawndir = true;
			}
			
			image_xscale = _scale2[0]*_curdir;
			image_yscale = _scale2[1];
			
			image_speed = 1;
			x += _xspd*_curdir;
			
			if(_delay > 0){
				_delayed = true;
				
				_delay --;
				_active = false;
			} else {
				if(_delayed){
					_active = true;
					_delayed = false;
				}
			}
			
			if(_active){
				//getting hit
				if(_cangetdamage && place_meeting(x, y, obj_punchhitbox)){
					var atk_obj = instance_place(x,y,obj_punchhitbox);
					if(atk_obj._delay > 0) return;
					if(instance_exists(atk_obj)){
						var atk_parent = atk_obj._parentobj;
						if(instance_exists(atk_parent)){
							if((atk_obj._ptype == "pl" || atk_obj._ptype == "all") && atk_parent.id != self.id && diff_abs(atk_parent.y, y) <= 42 && diff_abs(atk_parent._height, _height) <= 210 && diff_abs(atk_obj._height, _height) <= 70){
								if(_freeze <= 0 && atk_parent._freeze <= 0){
									var accepthit = true;
									if(array_length(_canhit) > 0){
										accepthit = false;
										if(atk_obj._damage == ATK_NORM){
											if(atk_parent._attacktype == "idle" && array_contains(_canhit, "idle")){
												accepthit = true;
											}
										}
										for(var i = 0; i < array_length(_canhit); i++){
											if(atk_obj._damage == ATK_KO){
												if(atk_parent._attacktype == _canhit[i]){
													accepthit = true;
													break;
												}
											}
										}
									}
									
									if(!accepthit) return;
									
									var partc = instance_create_depth(x-64, y-64-_dispoffset[1], 0, obj_particle);
									partc._type = "fx6";
							
									atk_parent._freeze = global._freezeFrames.long_freeze;
									_freeze = global._freezeFrames.long_freeze;
									sfx_play_choose(global._punchsounds[0]);
								
									with(obj_camera){
										_ampX = 14;
										_ampY = 14;
									}
							
									global._pad_vibrate = 4
							
									if(variable_instance_exists(self.id, "_spawnenemy")){
										if(!_enemyspawned){
											if(!variable_instance_exists(self.id, "_fridge")){
												sprite_index = _noenmindex;
												spawnenemy(true);
												_enemyspawned = true;
												_active = false;
												
												var p = instance_create_depth(x-96,y-96,depth,obj_particle);
												p._type = "fx6";
													
												sfx_play_choose(global._kdsounds);
												
												with(obj_camera){
													_ampY = 24;
												}
												
												global._pad_vibrate = 12;
											} else {
												if(!_fridge){
													sprite_index = _noenmindex;
													spawnenemy(true);
													_enemyspawned = true;
													_active = false;
													
													var p = instance_create_depth(x-96,y-96,depth,obj_particle);
													p._type = "fx6";
													
													sfx_play_choose(global._kdsounds);
													
													with(obj_camera){
														_ampY = 24;
													}
													
													global._pad_vibrate = 12;
												} else {
													if(_active){
														with(obj_tipbox){
															if(_prompt == "tutr_jump"){
																_active = false;
															}
														}
														with(obj_camera){
															_ampY = 24;
														}
														
														atk_parent._state = "jump";
														atk_parent._runroll_dive = false;
														atk_parent._runroll = false;
														atk_parent._jump_enmhit = true;
													
														var p = instance_create_depth(x-96,y-96,depth,obj_particle);
														p._type = "vanish";
														sfx_play_proximity(snd_ghost);
														sfx_play_proximity(snd_finalko);
													
														global._pad_vibrate = 12;
													
														var mt = instance_create_depth(x,y,depth,obj_fridge_mtcycle);
														mt._curdir = _curdir;
														mt._mt_spd = _mt_spd;
														mt.image_angle = image_angle;
													
														instance_destroy();
													}
												}
											}
										}
									} else {
										dead();
									}
								}
							}
						}
					}
				}
				
				//dead
				if(_killoffscreen){
					if(_battlezone && _bzobj != noone && instance_exists(_bzobj)){
						if(x <= _bzobj.bbox_left - 256 || x >= _bzobj.bbox_right + 256){
							instance_destroy();
						}
					} else {
						if(x <= global._cameraX - 256 || x >= global._cameraX + WIDTH + 256){
							instance_destroy();
						}
					}
				}
				
				if(_temp){
					_deathtimer --;
					if(_deathtimer <= 0){
						instance_destroy();
					}
				}
				
				//prevent draining the entire shield in a single frame
				if(!_shielded){
					_shieldt = 0;
				}
				if(_shielded && !place_meeting(x,y,obj_dh_hurtbox)){
					_shieldt ++;
				}
				if(_shieldt >= 8){
					_shielded = false;
				}
			}
		} else {
			image_speed = 0;
			_freeze -= 1;
		}
	} else {
		image_speed = 0;
	}
}