{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		if(!global._lode_editor){
			if(!_pathblock){
				if(_tilepos[0] > 2 && _tilepos[1] % 3 == 0){
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
		
		scr_lode_overtile();
		
		scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale],_depth);
	} else {
		image_speed = 0;
	}
}