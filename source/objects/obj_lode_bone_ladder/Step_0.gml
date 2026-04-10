{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){	
		if(!global._lode_editor){
			if(!_show){
				if(_tilepos[0] != -1 && _tilepos[1] != -1){
					var btile = LTILE_AIR;
					if(_tilelayer == 0){
						btile = global._stage_layout_bg[_tilepos[0]][_tilepos[1]];
					}
					global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]] = btile;
				}
				y = -1024;
			} else {
				if(_tilepos[0] != -1 && _tilepos[1] != -1){
					global._stage_layout[0][_tilepos[0]][_tilepos[1]] = LTILE_LDR2;
					global._stage_layout[1][_tilepos[0]][_tilepos[1]] = LTILE_LDR2;
				}
				
				y = _starty;
				
				if(place_meeting(x,y,obj_lode_wall) || place_meeting(x,y,obj_lode_wallgone)){
					var wall = instance_place(x,y,obj_lode_wall);
					if(instance_exists(wall)){
						global._stage_layout[1][wall._tilepos[0]][wall._tilepos[1]] = LTILE_LDR2;
						instance_destroy(wall.id);
					}
					var wall2 = instance_place(x,y,obj_lode_wallgone);
					if(instance_exists(wall2)){
						global._stage_layout[1][wall2._tilepos[0]][wall2._tilepos[1]] = LTILE_LDR2;
						instance_destroy(wall2.id);
					}
				}
				
				if(!_show_particle){
					var p = instance_create_depth(x+(sprite_width*0.5)-3,y+(sprite_height*0.5)-3,0,obj_particle);
					p._lode_particle = true;
					p._type = "lode_block";
					
					_show_particle = true;
				}
			}
		}
		
		scr_lode_overtile();
		
		if(_project){
			scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale],_depth);
		} else {
			_deadtimer ++;
			if(_deadtimer >= 2){
				scr_lode_remove_project();
				
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}