{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._pause && !global._gameover_stopall){
		if(_project){
			if(!global._lode_editor){
				if(!place_meeting_array(x,y+4,global._lode_collide_solid,false,true)){
					var p = instance_create_depth(x+(sprite_width*0.5)-3,y+(sprite_height*0.5)-3,0,obj_particle);
					p._lode_particle = true;
					p._type = "lode_block";
					
					_project = false;
				}
			}
			
			scr_lode_overtile();
		
			scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale]);
		} else {
			_deathtimer ++;
			if(_deathtimer >= 2){
				instance_destroy();
			}
		}
	}
}