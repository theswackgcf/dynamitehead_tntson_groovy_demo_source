{
	if(!_init){
		switch(_dir){
			case "r":
				_boxspawnpos = [310,0];
			break;
			case "l":
				_boxspawnpos = [-310,0];
			break;
			case "d":
				_boxspawnpos = [0,310];
			break;
			case "u":
				_boxspawnpos = [0,-310];
			break;
		}
		_itembox = instance_create_depth(x+_boxspawnpos[0], y+_boxspawnpos[1], depth+1, obj_itembox);
		_itembox._boxonly = _boxonly;
		_itembox._dir = _dir;
		_itembox._parentobj = self.id;
		
		_init = true;
	}
	
	if(!_shadowsinit){
		//shadows
		global._gameshadows[? self.id] = ds_map_create();
		global._gameshadows[? self.id][? "draw"] = false;
		global._gameshadows[? self.id][? "x"] = x;
		global._gameshadows[? self.id][? "y"] = y;
		global._gameshadows[? self.id][? "scalex"] = 0;
		global._gameshadows[? self.id][? "scaley"] = 0;
		
		_shadowsinit = true;
	}
	
	if(_flyhigh && !_flyhigh_init){
		sfx_play_proximity(snd_whistle);
		
		_height = HEIGHT;
		_flyhigh_init = true;
	}
	
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				with(_itembox){
					instance_create_depth(x, y, 9000, obj_itemboxgone);
					instance_destroy();
				}
				instance_destroy();
			}
			_checkdelete = true;
		}
	}
	if(!global._pause){
		if(distance_to_point(global._cameraX+(WIDTH*0.5),global._cameraY+(HEIGHT*0.5)) <= WIDTH*2){
			_inview = true;
		} else {
			_inview = false;
		}
		
		var xscale = 1;
		if(_dir == "l"){
			xscale = -1;
		}
		
		if(_shadowsinit && !_boxonly){
			if(ds_map_exists(global._gameshadows,self.id)){
				global._gameshadows[? self.id][? "draw"] = true;
				global._gameshadows[? self.id][? "x"] = x+(12*xscale);
				global._gameshadows[? self.id][? "scalex"] = 0.3*_shadowmult;
				global._gameshadows[? self.id][? "scaley"] = 0.3*_shadowmult;
				if(!visible){
					global._gameshadows[? self.id][? "draw"] = false;
				}
			}
		}
		
		if(visible && _init){
			if(_flyhigh){
				_itembox._collidewith = "";
				_itembox._height_draw = _height;
				switch(_flyhigh_act){
					case 0:
						_height -= 180;
						if(_height <= 0){
							with(obj_dh_mask){
								if(_height == _groundlevel){
									_vspd = 16;
									_height += 4;
									_jump = true;
									_state = "shockwave";
									_shockwave = 50;
								}
							}
							
							with(obj_camera){
								_ampY = 28;
							}
							
							//particles
							for(var i = 0; i < 2; i++){
								var offset = [-56, 320];
								if(_boxonly){
									offset = [150, 320];
								}
								var p = instance_create_depth(x+offset[i], y+12, depth, obj_particle);
								p._move = true;
								if(i == 0){
									p._type = "run4";
									p._xspd = -14;
								} else if(i == 1){
									p._type = "run5";
									p._xspd = 14;
								}
							}
							
							sfx_stop(snd_whistle);
							sfx_play_proximity(snd_slam);
							
							_yspd = 10;
							_height = 0;
							_flyhigh_act = 1;
						}
					break;
					case 1:
						_height += _yspd;
						_yspd -= 0.5;
						if(_height < 0){
							with(obj_camera){
								_ampY = 9;
							}
							
							//particles
							for(var i = 0; i < 2; i++){
								var offset = [-56, 320];
								if(_boxonly){
									offset = [150, 320];
								}
								var p = instance_create_depth(x+offset[i], y+12, depth, obj_particle);
								p._move = true;
								if(i == 0){
									p._type = "run1";
									p._xspd = -9;
								} else if(i == 1){
									p._type = "run2";
									p._xspd = 9;
								}
							}
							
							_height = 0;
							_flyhigh = false;
							
							if(_itembox._trigger == 0 && _boxonly){
								_itembox._trigger = 1;
							}
						}
					break;
				}
			} else {
				if(_itembox != noone && instance_exists(_itembox)){
					_itembox._collidewith = _collidewith;
				}
			}
			if(!_boxonly){
				if(_trigger && _trigger_enm){
					sprite_index = spr_tnt_push;
					if(_freeze <= 0){
						_triggertimer ++;
						if(_triggertimer >= 6){
							//activate itembox
							if(_itembox._trigger == 0){
								_itembox._trigger = 1;
							}
							
							_deleteshadow = true;
							
							visible = false;
						}
					} else {
						_freeze -= 1;
					}
				}
			}
		}
	}
}