{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._pause && !global._gameover_stopall){
		if(_parentobj != noone && instance_exists(_parentobj)){
			y += 24;
			if(!_landchecker){
				if(place_meeting(x,y,obj_lode_wall) || place_meeting(x,y+global._lode_tilesize,obj_lode_rope)){
					_parentobj._checkerobj = noone;
					_parentobj._checker = false;
					instance_destroy();
				}
				if(place_meeting(x,y,obj_lode_plr)){
					with(_parentobj){
						sfx_play_proximity(snd_lode_stalac_trigger,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
					}
				
					_landchecker = true;
				}
			} else {
				if(place_meeting(x,y,obj_lode_wall)){
					_parentobj._checkerobj = noone;
					_parentobj._checker = false;
					
					_parentobj._trigger = true;
					_parentobj._landy = y-global._lode_tilesize;
					
					instance_destroy();
				}
			}
		}
	}
}