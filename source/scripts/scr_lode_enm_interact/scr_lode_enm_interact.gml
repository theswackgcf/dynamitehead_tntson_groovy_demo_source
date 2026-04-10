function scr_lode_enm_interact(){
	//interaction
	if(_ladder_cd <= 0 && place_meeting(x,y,obj_lode_ladder)){
		var ladderstate = false;
		if(_state != LODE_STATE_LADDER){
			var inst = instance_place(x,y,obj_lode_ladder);
			if(instance_exists(inst)){
				if(diff_abs(y,_walkpos[1])>_movespd){
					ladderstate = true;
					_pathfind_timer = 999;
					x = inst.x+(global._lode_tilesize*0.5);
					_ladder_cd = 60;
				}
			}
		}
		if(ladderstate){
			_state = LODE_STATE_LADDER;
		}
	}
	if(_rope_cd <= 0 && place_meeting_array(x,y,global._lode_collide_rope,false,true)){
		if(_state != LODE_STATE_ROPE){
			var inst = place_meeting_array(x,y,global._lode_collide_rope, true,true);
			if(instance_exists(inst)){
				_pathfind_timer = 999;
				y = inst.y+(global._lode_tilesize)-12;
				
				sfx_play_proximity(snd_lode_rope,0.8,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
				
				_rope_cd = 36*global._lode_spd;
			}
		}
		_state = LODE_STATE_ROPE;
	}
		
	if(_collect_cd <= 0 && !_collectable && place_meeting(x,y,obj_lode_collect)){
		var collect = instance_place(x,y,obj_lode_collect);
		if(instance_exists(collect) && collect._checkdelete && collect._project){
			if(global._stage_layout[0][collect._tilepos[0]][collect._tilepos[1]] == LTILE_COL){
				global._stage_layout[0][collect._tilepos[0]][collect._tilepos[1]] = LTILE_AIR;
			}
			if(global._stage_layout[1][collect._tilepos[0]][collect._tilepos[1]] == LTILE_COL){
				global._stage_layout[1][collect._tilepos[0]][collect._tilepos[1]] = LTILE_AIR;
			}
			
			var p = instance_create_depth(collect.x,collect.y,0,obj_particle);
			p._type = "lode_collect";
			p._lode_particle = true;
				
			_collectable = true;
			_collectable_id = collect._id;
				
			sfx_play_proximity(snd_lode_monyx,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
				
			instance_destroy(collect.id);
		}
	}
	
	_move_mult = 1;
	if(place_meeting(x,y,obj_lode_river)){
		_river_timer ++;
		if(_moving && _river_timer >= 12){
			var p = instance_create_depth(x,y-(sprite_height*0.5),0,obj_particle);
			p._lode_particle = true;
			p._type = "lode_river";
					
			if(!sfx_isplaying(snd_lode_rivermove)){
				sfx_play_proximity(snd_lode_rivermove,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
			}
					
			_river_timer = 0;
		}
		
		_move_mult = 0.5;
	} else {
		_river_timer = 99;
	}
}