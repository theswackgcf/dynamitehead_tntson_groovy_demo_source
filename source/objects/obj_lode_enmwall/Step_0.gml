{
	if(global._debug){
		image_blend = c_grey;
		visible = global._showHitbox;
	}
	
	if(!global._pause && !global._gameover_stopall){
		if(_parentobj != noone && instance_exists(_parentobj)){
			x = _parentobj.x;
			if(_parentobj.y < y){
				instance_destroy();
			}
			if(abs(_parentobj._xspd) >= _parentobj._movespd){
				instance_destroy();
			}
		} else {
			instance_destroy();
		}
	
		if(!place_meeting_array(x,y+2,global._lode_collide_solid) && !place_meeting_array(x,y+(sprite_height+2),global._lode_collide_enemy,false,true)){
			instance_destroy();
		}
		if(place_meeting(x,y,obj_lode_collect)){
			instance_destroy();
		}
		if(place_meeting(x,y,obj_lode_ladder)){
			instance_destroy();
		}
		if(place_meeting(x,y+sprite_width,obj_lode_rope)){
			instance_destroy();
		}
		if(place_meeting(x,y,obj_lode_rope)){
			instance_destroy();
		}
	}
}