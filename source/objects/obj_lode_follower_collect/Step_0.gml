{
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		_show = false;
		if(_parentobj != noone && instance_exists(_parentobj)){
			x = _parentobj._disppos[0]+_parentobj._sparklesoffset[0];
			y = _parentobj._disppos[1]+_parentobj._sparklesoffset[1];
			if(variable_instance_exists(_parentobj.id, "_collectable")){
				if(_parentobj._collectable){
					_show = true;
				}
			}
			if(variable_instance_exists(_parentobj.id, "_collectable_timer")){
				if(_parentobj._collectable_timer > 0){
					_show = true;
				}
			}
		}

		scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale],_depth);
	} else {
		image_speed = 0;
	}
}