function scr_lode_enm_stuck(){
	_fallspd = max(1,_movespd*1.25);
	if(_state == LODE_STATE_DEFAULT){
		if(_groundtimer <= 0){
			x = _fall_storepos[0];
			_xspd = 0;
			_yspd = _fallspd;
				
			_ignore_pathfinding = 4;
			_pathinit = false;
			_pathfind_timer = 999;
		} else {
			_fall_storepos = [x,y];
		}
	}
		
	//stuck on ground fix
	if(_groundtimer > 0){
		if(_walkpos[0] < x){
			_xspd = -_movespd;
		} else if(_walkpos[0] > x){
			_xspd = _movespd;
		}
	}
		
	_storetimer ++;
	if(_storetimer >= 4){
		_storepos[0] = x;
		_storepos[1] = y;
			
		_storetimer = 0;
	}
		
	if(x == _storepos[0] && y == _storepos[1]){
		_idletimer ++;
		if(_idletimer >= 8){
			_idlefix = true;
		}
	} else {
		_idletimer = 0;
	}
		
	if(_idlefix){
		x = lerp(x,_walkpos[0],0.08);
		y = lerp(y,_walkpos[1],0.08);
			
		if(diff_abs(x,_walkpos[0]) <= 2 && diff_abs(y,_walkpos[1]) <= 2){
			_idlefix = false;
		}
			
		_idletimer = 0;
		_storepos[0] = x;
		_storepos[1] = y;
	}
	
	//stuck detection
	if(_is_stuck && place_meeting_array(x,y+sprite_height,global._lode_collide_enemy,false,true)){
		_groundtimer = 4;
	}
	if(_groundtimer <= 0){
		_stuckcol = false;
	}
	if(_force_stuck || (_cangetdamage && _state == LODE_STATE_DEFAULT && _anim == "idle" && !place_meeting(x,y,obj_lode_ladder) && !place_meeting_array(x,y-global._lode_tilesize,global._lode_collide_solid) && (place_meeting_array(x,y+1,global._lode_collide_solid) || place_meeting_array(x,y+8,global._lode_collide_enemy,false,true)) && place_meeting_array(x-sprite_width,y-4,global._lode_collide_solid,false,true) && place_meeting_array(x+sprite_width,y-4,global._lode_collide_solid,false,true))){
		_pathfind_timer = 999;
		
		update_tilepos();
			
		_is_stuck = true;
			
		if(!_stuckcol){
			var wall = instance_create_depth(x,(_tilepos[0]*global._lode_tilesize)+global._lode_tilesize,0,obj_lode_enmwall);
			wall._parentobj = self;
			wall._tilepos = [_tilepos[0],_tilepos[1]];
			
			y = wall.y;
			
			//spawn own collectable if stuck in the ground
			spawn_collect(-1);
				
			_stuckcol = true;
		}
	}
	
	if(_force_stuck > 0){
		_force_stuck --;
	}
	
	if(_stuckcol || _is_stuck){
		if(_is_stuck){
			_groundtimer = 4;
			_yspd = 0;
		}
		if(place_meeting_array(x,y-8,global._lode_collide_enemy,false,true)){
			//enemy above this one
			var wallsabove = false;
			if(place_meeting_array(x-global._lode_tilesize,y-global._lode_tilesize,global._lode_collide_solid)){
				wallsabove = true;
			}
			if(place_meeting_array(x+global._lode_tilesize,y-global._lode_tilesize,global._lode_collide_solid)){
				wallsabove = true;
			}
			var enm = place_meeting_array(x,y-16,global._lode_collide_enemy,true,true);
			if(instance_exists(enm)){
				if(wallsabove && enm._enmwalk <= 0){
					enm._force_stuck = 8;
				}
			}
		}
		
		if(_state != LODE_STATE_CLIMB){
			if(place_meeting_array(x-global._lode_tilesize,y-global._lode_tilesize,global._lode_collide_solid) && place_meeting_array(x+global._lode_tilesize,y-global._lode_tilesize,global._lode_collide_solid)){
				_stucktimer = 0;
			} else {
				if(!place_meeting(x,y-16,obj_lode_plr) && !place_meeting_array(x,y-sprite_height,global._lode_collide_enemy,false,true)){
					_stucktimer += global._lode_spd;
				} else {
					_stucktimer = 0;
				}
			}
			if(_stucktimer >= 100){
				_stucktimer = 0;
				_state = LODE_STATE_CLIMB;
			}
		}
	}
	
	if(_state == LODE_STATE_CLIMB){
		if(!place_meeting(x,y-16,obj_lode_plr)){
			_stucktimer ++;
			_offset[0] = sin(random(480))*2;
		} else {
			_stucktimer = 0;
			_offset[0] = 0;
		}
		if(_stucktimer >= 30){
			var plr = instance_nearest(x,y,obj_lode_plr);
			if(instance_exists(plr)){
				var cangoL = true;
				var cangoR = true;
				if(place_meeting_array(x-20,y-global._lode_tilesize,global._lode_collide_solid)){
					cangoL = false;
				}
				if(place_meeting_array(x+20,y-global._lode_tilesize,global._lode_collide_solid)){
					cangoR = false;
				}
					
				if(plr.x < x && cangoL){
					x -= global._lode_tilesize;
					_curdir = DIR_L;
				} else {
					if(cangoR){
						x += global._lode_tilesize;
						_curdir = DIR_R;
					}
				}
					
				if(cangoL || cangoR){
					image_xscale = _curdir;
					y -= global._lode_tilesize+2;
							
					_getup_pos = [x,y];
					_getup_dir = _curdir;
				
					_anim = "pit";
					_disppos = [x,y];
					image_index = 0;
					_getup = true;
				
					var spr = asset_get_index("spr_lode_"+_codename+"_"+_anim);
					if(sprite_exists(spr)){
						sprite_index = spr;
					}
				
					_force_path = 0;
					_pathinit = false;
					_pathfind_timer = 999;
				
					_state = LODE_STATE_DEFAULT;
					_force_stuck = 0;
					_is_stuck = false;
					_stuckcol = false;
					_stucktimer = 0;
					_offset[0] = 0;
				} else {
					_offset[0] = 0;
				}
			}
		}
	}
}