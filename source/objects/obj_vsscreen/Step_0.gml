{
	depth = -10999;
	
	if(!global._pause){
		if(_start){
			if(_addamp > 0){
				_addamp -= 0.12;
			} else {
				_addamp = 0;
			}
			
			_timer ++;
			if(_act == 0){
				sfx_play(snd_vs);
				_timer = 0;
				_act = 1;
			} else if(_act == 1){
				if(_timer >= 6){
					with(obj_camera){
						_ampX = 18;
						_ampY = 16;
					}
					_addamp = 10;
					_act = 2;
					_timer = 0;
				}
			} else if(_act == 2){
				with(obj_boss_intro){
					_freeze = 2;
				}
				
				with(obj_st2_enm1_mask){
					_freeze = 2;
				}
				with(obj_st2_enm2_mask){
					_freeze = 2;
				}
				with(obj_projectile){
					_freeze = 2;
				}
				with(obj_st2_enm3_mask){
					_freeze = 2;
				}
				
				with(obj_dh_mask){
					_idletimer = 0;
					_idleanim = [false,false];
					_idles = 0;
					
					_freeze = 2;
				}
				with(obj_boss2_bg){
					_freeze = 2;
				}
				with(obj_particle){
					_freeze = 2;
				}
			
				if(!_voice){
					if(array_length(_bosslines[global._location]) > 0){
						voice_play_choose(_bosslines[global._location], global._bossvoices);
					}
					_voice = true;
				}
			
				if(_timer >= 100){
					global._bossintro = true;
					global._seteffect = 0;
					_start = false;
					_timer = 0;
					
					if(surface_exists(_gui_surface)){
						surface_free(_gui_surface);
					}
					if(surface_exists(_resizegui_surface)){
						surface_free(_resizegui_surface);
					}
					
					if(ds_map_exists(_allsounds, "emitter")){
						audio_emitter_free(_allsounds[? "emitter"]);
					}
					
					ds_map_destroy(_allsounds);
					_allsounds = -1;
				} else {
					global._seteffect = 2;
					global._effect = EFFECT_SEPIA;
				}
			}
		} else {
			_addamp = 0;
		}
	}
}