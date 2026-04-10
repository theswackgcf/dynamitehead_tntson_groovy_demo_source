{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		_sintimer ++;
		
		if(!global._lode_editor){
			if(!_checkdelete){
				if(ds_map_exists(global._lode_deletedStuff,_id)){
					_project = false;
					_addcount = true;
				}
			
				_checkdelete = true;
			}
			
			_show = true;
			if(place_meeting(x,y,obj_lode_wall)){
				var wall = instance_place(x,y,obj_lode_wall);
				if(instance_exists(wall)){
					if(wall._sparkles == noone){
						wall._sparkles = instance_create_depth(x,y,0,obj_lode_follower_collect);
						wall._sparkles._parentobj = wall;
						wall._sparkles._id = "collect"+string(x+y)+string(irandom(99999));
					}
					wall._collectable_timer = 2;
				}
				_show = false;
			}
			
			if(_spawned){
				repeat(sprite_height){
					y ++;
					if(place_meeting_array(x,y+2,global._lode_collide_solid,false,true)){
						_spawned = false;
						break;
					}
					if(place_meeting_array(x,y+2,global._lode_collide_enemy,false,true)){
						_spawned = false;
						break;
					}
					if(place_meeting(x,y+2,obj_lode_ladder)){
						_spawned = false;
						break;
					}
					if(place_meeting(x,y+2,obj_lode_enmwall)){
						_spawned = false;
						break;
					}
				}
			}
		}
		
		scr_lode_overtile();
		
		if(_project){
			scr_lode_project(sprite_index,image_index,[x,y+sin(_sintimer/22)*4],[image_xscale,image_yscale]);
		} else {
			_deadtimer ++;
			if(_deadtimer >= 2){
				scr_lode_remove_project();
				if(_addcount){
					global._lode_collect_cur ++;
				}
				
				if(_tilelayer == 0){
					global._stage_layout[0][_tilepos[0]][_tilepos[1]] = LTILE_AIR;
				}
				
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}