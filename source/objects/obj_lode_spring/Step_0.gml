{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		if(!_launch){
			if(!_trigger){
				_pitch = 0.7;
				_index_timer = 0;
				
				sprite_index = spr_lode_spring;
			} else {
				//cancel
				if(!place_meeting(x,y-8,obj_lode_plr)){
					image_index = 0;
					_trigger = false;
				}
				
				_index_timer += global._lode_spd;
				if(_index_timer % 2 == 0){
					_prev_index = image_index;
				}
				if(_prev_index != image_index){
					sfx_play(snd_lode_spring_blip);
					sfx_pitch(snd_lode_spring_blip, _pitch);
					_pitch += 0.35;
					_prev_index = image_index;
				}
				
				sprite_index = spr_lode_spring_charge;
				if(image_index >= image_number-1){
					sfx_play(snd_lode_spring);
					
					image_index = 0;
					_launch = true;
				}
			}
		} else {
			sprite_index = spr_lode_spring_launch;
			if(image_index >= image_number-1){
				image_index = 0;
				_trigger = false;
				_launch = false;
			}
		}
		
		scr_lode_overtile();
		
		scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale]);
	} else {
		image_speed = 0;
	}
}