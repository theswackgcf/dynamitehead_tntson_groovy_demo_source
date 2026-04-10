{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;

		if(global._lode_editor){
			scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale]);
		} else {
			if(_loop > global._lode_curloop){
				if(place_meeting_array(x,y,global._lode_collide_enemy,false,true)){
					var enm = place_meeting_array(x,y,global._lode_collide_enemy,true,true);
					if(instance_exists(enm)){
						instance_destroy(enm.id);
					}
				}
				if(place_meeting(x,y,obj_lode_enmspawner)){
					var sp = instance_place(x,y,obj_lode_enmspawner);
					if(instance_exists(sp)){
						instance_destroy(sp.id);
					}
				}
				if(place_meeting(x,y,obj_lode_chaser_deathmask)){
					var dm = instance_place(x,y,obj_lode_chaser_deathmask);
					if(instance_exists(dm)){
						instance_destroy(dm.id);
					}
				}
				
				var other_inst = [obj_lode_crawler_h,obj_lode_crawler_v,obj_lode_stalactite];
				
				for(var i = 0; i < array_length(other_inst); i++){
					if(place_meeting(x,y,other_inst[i])){
						var inst = instance_place(x,y,other_inst[i]);
						if(instance_exists(inst)){
							instance_destroy(inst.id);
						}
					}	
				}
			}
			
			_timer ++;
			if(_timer >= 2){
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}