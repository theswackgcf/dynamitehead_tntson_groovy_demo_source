{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		_sintimer ++;
		
		if(!global._lode_editor){
			if(place_meeting(x,y,obj_lode_plr)){
				var plr = instance_place(x,y,obj_lode_plr);
				if(instance_exists(plr) && plr._plstate == LODE_STATE_ROPE){
					_plobj = plr;
				}
			} else {
				_plobj = noone;
			}
		
			if(_plobj != noone && instance_exists(_plobj)){
				x = _plobj.x-(sprite_width*0.5);
				
				_particle = false;
			} else {
				x = _startx;
				
				if(!_particle){
					var p = instance_create_depth(x+(sprite_width*0.5)-4,y-6,0,obj_particle);
					p._lode_particle = true;
					p._type = "lode_flyblock";
					
					sfx_play_proximity(snd_mg_popaway,0.65,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
					
					_particle = true;
				}
			}
		}
		
		scr_lode_overtile();
		
		scr_lode_project(sprite_index,image_index,[x,(y-sprite_height*0.5)+sin(_sintimer/5)*1.5],[image_xscale,image_yscale]);
	} else {
		image_speed = 0;
	}
}