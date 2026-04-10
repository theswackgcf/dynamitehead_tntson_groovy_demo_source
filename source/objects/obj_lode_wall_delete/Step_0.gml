{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	scr_lode_overtile();
		
	if(!global._lode_editor){
		if(place_meeting(x,y,obj_lode_plr)){
			var plr = instance_place(x,y,obj_lode_plr);
			if(instance_exists(plr)){
				if(plr.y >= y+(sprite_height*0.5)){
					if(instance_exists(plr._hurtbox)){
						plr._hurtbox._hurttimer = 2;
						plr._tnt_power = 0;
					}
				}
			}
		}
	}
		
	if(global._lode_editor){
		scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale]);
	}
}