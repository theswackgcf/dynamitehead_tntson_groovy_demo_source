{
	if(_startTimer > 0){
		_startTimer --;
	} else {
		if(!_colorsinit){
			if(ds_map_exists(global._enemyColors, _codename)){
				if(_enmtype != -1){
					_rep = _enmtypes[_enmtype][0];
					makecolors("def",_rep,_codename);
				}
			}
			
			_colorsinit = true;
		}
	
		event_inherited();
	
		if(_mt_init && _shadowsinit){
			if(ds_map_exists(global._gameshadows,_occupy_id)){
				global._gameshadows[? _occupy_id][? "draw"] = true;
				global._gameshadows[? _occupy_id][? "x"] = x+(sprite_width/3.5);
				global._gameshadows[? _occupy_id][? "y"] = y+48;
				if(global._dialogue && _fridge){
					global._gameshadows[? _occupy_id][? "draw"] = false;
				}
			}
		}
	
		if(!global._pause){
			if(_mt_act > 0){
				_mt_active_timer ++;
			}
			
			if(global._dialogue && _fridge){
				visible = false;
				_freeze = 2;
			}
			
			if(_freeze <= 0){
				_scale2[0] = lerp(_scale2[0],_mt_scaleto[0],0.18);
				_scale2[1] = lerp(_scale2[1],_mt_scaleto[1],0.18);
				image_angle = _mt_angle*_curdir;
				if(!_mt_init){
					if(place_meeting(x,y,obj_event)){
						var event = instance_place(x,y,obj_event);
						if(instance_exists(event) && event._event == "fridge_air"){
							_fridge = true;
						}
					}
					
					visible = false;
					
					x = _spawnpos[0];
				
					var offs = 710;
					var offs2 = 160;
				
					if(_spawndir == "r"){
						x += offs;
					} else if(_spawndir == "l"){
						x -= offs;
					}
					_mt_startposx = x + offs2*_curdir;
				
					if(!_fridge){
						var near = instance_create_depth(-WIDTH,-HEIGHT,-6000,obj_gui_enemynear);
						near._parentobj = self;
						near._sequence = false;
						near._dir = _spawndir
						near._codename = "st2_enm2_mtcycle";
						near._enmtype = _enmtype;
						near._hpcolor = _hpcolor[_enmtype+1];
						near._maxcolors = _maxcolors;
						near._mult_colorinArray = _mult_colorinArray;
						near._mult_coloroutArray = _mult_coloroutArray;
						near._mult_tolrArray = _mult_tolrArray;
						near._mult_blendArray =_mult_blendArray;
					}
				
					_mt_init = true;
				} else {
					visible = true;
					_mt_timer ++;
					if(_mt_act < 2){
						_dispoffset[1] = sin(_mt_timer*1.5)*5;
					}
					x += _mt_spd;
				
					//sound effect
					if(!sfx_isplaying(snd_mtcycle_loop)){
						sfx_play_proximity(snd_mtcycle_loop, 0.62);
						sfx_pitch(snd_mtcycle_loop, random_range(0.72,1));
					}
				
					switch(_mt_act){
						case 0:
							x = lerp(x, _mt_startposx, 0.03);
							if(_mt_timer >= 60){
								_mt_timer = 0;
								_mt_act = 1;
							}
						break;
						case 1:
							_mt_scaleto[0] = 1.1;
							_mt_scaleto[1] = 0.85;
							if(_mt_timer >= 24){
								_mt_timer = 0;
								_mt_act = 2;
								_mt_spd = 2*_curdir;
							
								sfx_play_proximity(snd_mtcycle_go);
							}
						break;
						case 2:
							_activetimer ++;
							if(!_enemyspawned && _activetimer >= 50){
								_active = true;
							}
							_dispoffset[1] = 0;
							_mt_spd += _mt_accel*_curdir;
							if(abs(_mt_spd) >= _mt_maxspd){
								_mt_spd = _mt_maxspd*_curdir;
							}
						
							_mt_exhausttime ++;
							if(_mt_exhausttime >= random_range(6,8)){
								var p = instance_create_depth(x+(-250*_curdir), y+56, depth+8, obj_particle);
								p._type = "exhaust"+string(choose(1,2,3));
								p._move = true;
								p._xspd = 9.2*_curdir;
								p._yspd = 0;
								p._angle = 0;
								p._curdir = _curdir;
								p._scale = random_range(1.2,1.62);
								p._forcedepth = depth+8;
								p._adddepth = 0;
							
								_mt_exhausttime = 0;
							}
						
							//angle
							if(!_mt_angleback){
								_mt_angle += 4;
								if(_mt_angle >= 50){
									_mt_angleback = true;
								}
							} else {
								_mt_angle -= 6;
								if(_mt_angle <= 38){
									_mt_angle = 38;
								}
							}
							
							_mt_scaleto[10] = 1;
							_mt_scaleto[1] = 1;
						break;
					}
				
					if(_enemyspawned){
						sprite_index = _noenmindex;
					}
					if(_fridge){
						if(!_tip_active){
							with(obj_tipbox){
								if(_prompt == "tutr_jump"){
									_active = true;
								}
							}
							_tip_active = true;
						}
						
						_active = !global._dialogue;
						_shielded = true;
						sprite_index = spr_fridge_mtcycle;
					}
				
					//dying
					var borders = [global._cameraX - 320,global._cameraX + WIDTH + 320];
					if(_battlezone && _bzobj != noone && instance_exists(_bzobj)){
						borders = [_bzobj.bbox_left - 320,_bzobj.bbox_right + 320];
					}
					
					if((_curdir == DIR_L && x <= borders[0]) || (_curdir == DIR_R && x >= borders[1])){
						if(!_fridge){
							if(!_enemyspawned && _spawnenemy){
								spawnenemy(false, x+(-640*_curdir), y);
							}
							with(obj_camera){
								_ampX = 18;
								_ampY = 18;
							}
					
							var p = instance_create_depth(x+(-320*_curdir), global._cameraY+floor(HEIGHT/2)+64, depth+8, obj_particle);
							p._type = "explosion_screenside";
							p._curdir = _curdir;
							p._scale = 1.3;
							p._adddepth = 1500;
					
							if(_enminst != noone && instance_exists(_enminst)){
								with(_enminst){
									sfx_play_proximity(snd_explosion2, 0.68);
								}
							}
							dead();
						} else {
							_mt_init = false;
							_xspd = 0;
							_activetimer = 0;
							_mt_accel = 0.3;
							_mt_spd = 0;
							_mt_act = 0;
							_mt_timer = 0;
							_mt_scaleto = [1,1];
							_scale2 = [1,1];
							_mt_angle = 0;
							_mt_angleback = false;
						}
					}
				}
				
				if(_fridge){
					var maxnum = 60;
					if(_mt_active_timer < maxnum){
						_mt_alpha_to = 0.4;
					} else {
						_mt_alpha_to = 1;
					}
					
					_mt_alpha = lerp(_mt_alpha, _mt_alpha_to, 0.12);
					image_alpha = _mt_alpha;
					
					if(_mt_active_timer >= maxnum){
						_active = true;
					} else {
						_active = false;
					}
				}
			}
		}	
	}
}