{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!_init){
		if(!global._lode_editor){
			if(!place_meeting(x-sprite_height,y,obj_lode_rope) || !place_meeting(x+sprite_height,y,obj_lode_rope)){
				_solid = true;
			}
		
			if(!_pathblock){
				if(!place_meeting(x,y,obj_lode_randombox)){
					var block = instance_create_depth(x,y,0,obj_lode_randombox);
					block._tilepos = [_tilepos[0],_tilepos[1]];
				
					_pathblock = true;
				}
			}
		}
		
		_init = true;
	}
	
	if(global._lode_editor){
		scr_lode_delete_tileobj();
	}
}