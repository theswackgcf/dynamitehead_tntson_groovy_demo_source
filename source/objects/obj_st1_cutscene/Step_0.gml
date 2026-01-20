{
	//depth = 9995;
	if(!global._pause){
		if(_start){
			_timer ++;
			switch(_act){
				case 0:
					if(_timer >= 50){
						sfx_play(snd_whistle, 0.3);
						_timer = 0;
						_act = 1;
						_barreldraw = true;
						_barrelpos = [floor(WIDTH/2)-256,-140];
					}
				break;
				case 1:
					if(_barrelpos[1] >= floor(HEIGHT/2)){
						sfx_stop(snd_whistle);
						sfx_play(snd_barrelcrash, 0.4);
						with(obj_camera){
							_ampY = 20;
						}
						_barreldraw = false;
						_timer = 0;
						_act = 2;
					}
				break;
				case 2:
					if(_timer % 6 == 0){
						var spawnY;
						var depth2;
						if(_spawntype == SPAWN_NORMAL){
							spawnY = floor(HEIGHT/2)+96;
							depth2 = 9995;
						} else if(_spawntype == SPAWN_FALLPLANKS){
							spawnY = floor(HEIGHT/2)+164;
							depth2 = 9994;
						}
						var nuke = instance_create_depth(_spawnX+global._cameraX, spawnY+global._cameraY, depth2, obj_st1_nukesmall);
						nuke._forcedepth = depth2;
						if(_spawntype == SPAWN_NORMAL){
							nuke._scale = 0.6;
						}
						with(obj_camera){
							_ampX = 18;
							_ampY = 18;
						}
						sfx_stop(snd_explosion3);
						sfx_play(snd_explosion3);
						if(_spawntype == SPAWN_NORMAL){
							_spawnX += 96;
							if(_spawnX >= WIDTH){
								_spawntype = SPAWN_FALLPLANKS;
							}
						} else if(_spawntype == SPAWN_FALLPLANKS){
							_spawnX -= 96;
							if(_spawnX <= 0){
								sfx_stop(snd_explosion3);
								sfx_play(snd_nuclear);
								
								global._flashbang = 60;
								_timer = 0;
								_act = 3;
								_bignukedraw = true;
							}
						}
					}
				break;
				case 3:
					if(global._flashbang <= 25){
						with(obj_lighting){
							_colorTo[0] = other._defcolors[0];
							_colorTo[1] = other._defcolors[1];
							_draw = true;
						}
					}
				
					with(obj_camera){
						_ampY = 6;
					}
				
					_bignuketimer ++;
					if(_bignukeact == 0 && _bignuketimer >= 80){
						_bignukeact = 1;
						_bignuketimer = 0;
					}
					if(_bignukeact == 1 && _bignuketimer % 16 == 15){
						_bignukeframe ++;
						if(_bignukeframe >= sprite_get_info(spr_barrel_nuke2).num_subimages-1){
							with(obj_lighting){
								_colorTo[0] = [0,0,0];
								_colorTo[1] = [0,0,0];
								_draw = true;
							}
							_bignukedraw = false;
							_timer = 0;
							_act = 4;
						}
					}
					if(_bignukeact == 1 && _bignuketimer >= 50){
						_startspawn = true;
					}
				break;
				case 5:
					if(!_bignukedraw && instance_number(obj_nukenemy) <= 0){
						with(obj_barreltrigger){
							instance_destroy();
						}
						with(obj_enm1_n_mask){
							if(_idiot){
								killself();
							}
						}
					}
				break;
			}
			
			if(_startspawn){
				_enmtimer ++;
				if(_spawnenm < 4){
					if(_enmtimer % 20 == 10){
						var enm = instance_create_depth(random_range(380, WIDTH-380)+global._cameraX, HEIGHT+global._cameraY, depth, obj_nukenemy);
						enm._spd[0] = random_range(-2, 2);
						enm._spd[1] = -26;
						switch(_spawnenm){
							case 0:
								enm.image_index = 0;
							break;
							case 1:
								enm.image_index = 2;
							break;
							case 2:
								enm.image_index = 1;
							break;
							case 3:
								enm.image_index = 0;
							break;
						}
						_spawnenm ++;
					}
				}
				if(!_bignukedraw && _spawnenm >= 4){
					_timer = 0;
					_act = 5;
					_startspawn = false;
				}
			}
		}
	}
}