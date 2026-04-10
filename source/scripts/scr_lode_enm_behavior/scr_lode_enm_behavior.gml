function scr_lode_enm_behavior(){
	_init_timer ++;
	if(_init_timer >= 4 && !_cangetdamage){
		_cangetdamage = true;
	}
	
	if(!_spawnagain){
		if(!_init_spawner){
			_spawner = instance_create_depth(x,y,0,obj_lode_enmspawner);
		
			_spawner._parentobj = self;
			_spawner._enmindex = object_index;
			_spawner._spawn_offsets = [_spawn_offsets[0],_spawn_offsets[1]];
			
			_spawner._spawnblend = _spawnblend;
			
			_init_spawner = true;
		}
	}
	
	if(!_erase_init_tiles && _tilepos[0] != -1 && _tilepos[1] != -1){
		_tiles_init = [_tilepos[0],_tilepos[1]];
		
		var macros = [LTILE_ENM1,LTILE_ENM2,LTILE_ENM3,LTILE_ENM4];
		for(var i = 0; i < array_length(macros); i++){
			if(global._stage_layout[0][_tiles_init[0]][_tiles_init[1]] == macros[i]){
				global._stage_layout[0][_tiles_init[0]][_tiles_init[1]] = LTILE_AIR;
			}
			if(global._stage_layout[1][_tiles_init[0]][_tiles_init[1]] == macros[i]){
				global._stage_layout[1][_tiles_init[0]][_tiles_init[1]] = LTILE_AIR;
			}
		}
		_erase_init_tiles = true;
	}
	
	if(!_getup && !_taunt){
		//get target
		switch(_behaviortype){
			case LODE_ENM_CHASER:
			case LODE_ENM_NEAR:
				var tg = instance_nearest(x,y,obj_lode_plr);
				if(instance_exists(tg)){
					_target = tg;
				}
			break;
			case LODE_ENM_RANDOM:
				//if had monyx behavior before, switch back
				if(_remembermonyx && !_collectable && instance_number(obj_lode_collect) > 0){
					_behaviortype = LODE_ENM_MONYX;
					_target_timer = 999;
					_remembermonyx = false;
				}
				if(_target_timer >= random_range(220,370)){
					//seek random spots
					if(instance_number(obj_lode_randombox) > 0){
						var tg = instance_find(obj_lode_randombox,irandom(instance_number(obj_lode_randombox)-1));
						if(instance_exists(tg)){
							_target = tg;
							_target_timer = 0;
						}
					}
				}
				var tg = instance_nearest(x,y,obj_lode_plr);
				if(instance_exists(tg) && diff_abs(tg.y,y) <= 32 && distance_to_object(tg) <= 128){
					_target = tg;
					_target_timer = 0;
				}
			break;
			case LODE_ENM_MONYX:
				if(instance_number(obj_lode_collect) == 0 || _collectable){
					//no monyx left, switch to random behavior
					_behaviortype = LODE_ENM_RANDOM;
					_target_timer = 999;
					_remembermonyx = true;
				}
				if(_target_timer >= random_range(180,330)){
					//seek random monyx
					if(instance_number(obj_lode_collect) > 0){
						var tg = instance_find(obj_lode_collect,irandom(instance_number(obj_lode_collect)-1));
						if(instance_exists(tg)){
							_target = tg;
							_target_timer = 0;
						}
					}
				}
				var tg = instance_nearest(x,y,obj_lode_plr);
				if(instance_exists(tg) && diff_abs(tg.y,y) <= 32 && distance_to_object(tg) <= 128){
					_target = tg;
					_target_timer = 0;
				}
			break;
		}
		switch(_behaviortype){
			case LODE_ENM_RANDOM:
			case LODE_ENM_MONYX:
				if(_target != noone && instance_exists(_target)){
					if(distance_to_object(_target) <= sprite_width*2){
						_target_timer = 999;
					}
				}
				_target_timer ++;
			break;
		}
		if(_behaviortype == LODE_ENM_NEAR){
			_target_timer ++;
			if(_target != noone && instance_exists(_target)){
				if(distance_to_object(_target) < global._lode_tilesize*4 && diff_abs(_target.y,y) < _movespd){
					_target_tileoffset = 0;
				}
			}
			if(_target_timer >= random_range(600,780)){
				_target_tileoffset = irandom_range(-3,3);
			}
		}
	
		//reset path after a short period of time
		if(_path_step == 3){
			_pathfind_timer += global._lode_spd;
			if(_pathfind_timer >= 16){
				_path_step = 0;
				_pathinit = false;
				_pathfind_timer = 0;
			}
		}
		
		//find out if nearest point exists and set position
		if(_nearpoint != noone && instance_exists(_nearpoint)){
			_nearpoint_timer = 4;
			
			_walkpos = [_nearpoint.x,_nearpoint.y];
		} else {
			_nearpoint_timer -= global._lode_spd;
		}
		
		//reset position if stuck
		if(_nearpoint_timer <= 0){
			_walkpos = [x,y];
			_nearpoint_timer = 0;
		}
		
		//reset direction if reached position
		if(diff_abs(_walkpos[0],x) < _movespd && diff_abs(_walkpos[1],y) < _movespd){
			_dir = "";
			_moving = false;
		} else {
			_moving = true;
		}
		
		//get direction
		if(_walkpos[0] < x && diff_abs(_walkpos[0],x) >= _movespd){
			_dir = "l";
		} else if(_walkpos[0] > x && diff_abs(_walkpos[0],x) >= _movespd){
			_dir = "r";
		}
		if(_walkpos[1] < y && diff_abs(_walkpos[1],y) >= _movespd){
			_dir = "u";
		} else if(_walkpos[1] > y && diff_abs(_walkpos[1],y) >= _movespd){
			_dir = "d";
		}
		
		if(place_meeting_array(x,y+4,global._lode_collide_solid,false,true)){
			_groundtimer = 4;
			_enmwalk_y = y;
			_enmwalk_xspd = _xspd;
		}
		if(place_meeting(x,y+4,obj_lode_stalactite)){
			_groundtimer = 4;
			_enmwalk_y = y;
			_enmwalk_xspd = _xspd;
		}
		if(_groundtimer > 0){
			_groundtimer -= 1;
		}
		
		if(place_meeting_array(x,y+4,global._lode_collide_enemy,false,true)){
			var enm = place_meeting_array(x,y+4,global._lode_collide_enemy,true,true);
			if(instance_exists(enm) && enm._id != _id && enm._is_stuck && (enm._anim == "idle" || enm._yspd >= 0) && enm.y > y){
				if(!_stuckcol && _yspd >= 0){
					_enmwalk = 8;
				}
			}
		} else {
			if(!_stuckcol && _enmwalk <= 0 && (_anim != "walk" && (_walkpos[1] >= y || diff_abs(_walkpos[1],y) <= _movespd))){
				_enmwalk_y = _walkpos[1]-4;
			}
		}
		
		//ignore pathfinding if a pit is ahead
		var plr = instance_nearest(x,y,obj_lode_plr);
		if(instance_exists(plr) && distance_to_object(plr) <= 120){
			if(_path_step >= 3 && diff_abs(plr.y,y) <= _movespd && plr._successdig > 0){
				if((plr.x < x && _curdir == DIR_L) || (plr.x > x && _curdir == DIR_R)){
					_force_path = 140;
				}
			}
		}
		
		if(_ladder_invtime > 0){
			_ladder_invtime --;
		}
		
		//move enemy
		switch(_dir){
			case "l":
			case "r":
				var cango = false;
				switch(_state){
					case LODE_STATE_DEFAULT:
						if(_groundtimer > 0){
							cango = true;
						}
					break;
					case LODE_STATE_LADDER:
					case LODE_STATE_ROPE:
						_ladder_invtime = 16;
						cango = true;
					break;
				}
				if(cango){
					if(_dir == "l"){
						_xspd = -_movespd;
						_yspd = 0;
					} else if(_dir == "r"){
						_xspd = _movespd;
						_yspd = 0;
					}
				}
			break;
			case "u":
			case "d":
				var cango = false;
				switch(_state){
					case LODE_STATE_DEFAULT:
						if(_dir == "d"){
							cango = true;
						}
					break;
					case LODE_STATE_LADDER:
					case LODE_STATE_ROPE:
						cango = true;
					break;
				}
				if(cango){
					if(_dir == "u"){
						_xspd = 0;
						_yspd = -_movespd;
					} else if(_dir == "d"){
						_xspd = 0;
						_yspd = _movespd;
					}
				}
			break;
		}
		
		_timer ++;
	
		//direciton
		if(_groundtimer > 0){
			if(x < _storepos[0]){
				_dirval -= 0.3*global._lode_spd;
			} else if(x > _storepos[0]){
				_dirval += 0.3*global._lode_spd;
			}
			if(_dirval < -1){
				_dirval = -1;
			} else if(_dirval > 1){
				_dirval = 1;
			}
	
			if(_dirval < 0){
				_curdir = DIR_L;
			} else if(_dirval > 0){
				_curdir = DIR_R;
			}
		}
	
		switch(_state){
			case LODE_STATE_LADDER:
			case LODE_STATE_ROPE:
				_groundtimer = 2;
				if(!place_meeting(x,y+8,obj_lode_ladder) && !place_meeting(x,y+8,obj_lode_rope)){
					_state = LODE_STATE_DEFAULT;
				}
			break;
		}
	
		if(_ladder_cd > 0){
			_ladder_cd -= global._lode_spd;
		}
		if(_rope_cd > 0){
			_rope_cd -= global._lode_spd;
		}
		if(_collect_cd > 0){
			_collect_cd -= global._lode_spd;
		}
	
		if(_force_path > 0){
			_force_path -= global._lode_spd;
		}
	
		if(_ignore_pathfinding > 0){
			_ignore_pathfinding -= global._lode_spd;
		}
	}
}