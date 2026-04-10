{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	depth = -12;
	
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		if(!global._lode_editor && _project){
			if(_spawning){
				scr_lode_enm_spawning();
			} else {
				if(_freeze <= 0){
					if(!_pathinit){
						scr_lode_enm_pathfind_init();
					} else {
						if(_target != noone && instance_exists(_target)){
							scr_lode_enm_pathfind();
						}
					}
			
					scr_lode_enm_animation();
		
					scr_lode_enm_behavior();
		
					scr_lode_enm_interact();
		
					scr_lode_enm_stuck();
		
					scr_lode_enm_movement();
			
					scr_lode_enm_death();
				} else {
					image_speed = 0;
					_freeze --;
				}
			}
		}
		
		mask_index = spr_lode_chaser_mask;
		
		scr_lode_overtile();
		
		if(_project){
			scr_lode_enm_project();
		} else {
			_deadtimer ++;
			if(_deadtimer >= 2){
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}