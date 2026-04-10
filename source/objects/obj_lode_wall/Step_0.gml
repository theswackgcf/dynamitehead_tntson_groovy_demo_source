{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._lode_editor){
		if(!global._pause && !global._gameover_stopall){
			if(_collectable_timer > 0){
				_collectable_timer --;
			} else {
				if(_sparkles != noone && instance_exists(_sparkles)){
					instance_destroy(_sparkles.id);
					_sparkles = noone;
				}
			}
			
			if(place_meeting(x,y,obj_lode_wall_delete)){
				if(_tilelayer != -1 && _tilepos[0] != -1 && _tilepos[1] != -1){
					global._stage_hidetiles[_tilelayer][_tilepos[0]][_tilepos[1]] = true;
					instance_destroy();
				}
			}
		
			if(!_pathblock){
				if(_tilepos[0] > 2 && _tilepos[1] % 5 == 0){
					if(!place_meeting_array(x,y-sprite_height,global._lode_collide_solid)){
						if(!place_meeting(x,y-sprite_height,obj_lode_randombox)){
							var block = instance_create_depth(x,y-sprite_height,0,obj_lode_randombox);
							block._tilepos = [_tilepos[0]-1,_tilepos[1]];
						
							_pathblock = true;
						}
					}
				}
			}
		}
	}
	
	if(global._lode_editor){
		scr_lode_delete_tileobj();
	}
}