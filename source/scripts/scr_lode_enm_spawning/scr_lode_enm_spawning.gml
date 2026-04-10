function scr_lode_enm_spawning(){
	if(_freeze <= 0){
		_init_timer = 0;
		
		if(!_spawn_snd){
			sfx_play_proximity(snd_lode_enm_spawn1,0.65,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
			sfx_volume(snd_lode_enm_spawn1,clamp(audio_sound_get_gain(_allsounds[? snd_lode_enm_spawn1]),0,0.65));
			_spawn_snd = true;
		}
		
		_spawntimer ++;
		image_xscale = 1+(sin(_spawntimer/20)*_spawnamp);
		image_yscale = 1+(cos(_spawntimer/20)*_spawnamp);
	
		image_alpha += 0.02;
		if(image_alpha > 1){
			image_alpha = 1;
		}
	
		if(_spawntimer >= 45){
			_spawnblend_amnt -= 0.02;
			if(_spawnblend_amnt < 0){
				_spawnblend_amnt = 0;
			}
			var newcolor = merge_color(c_white,_spawnblend,_spawnblend_amnt);
			image_blend = newcolor;
		}
	
		if(_spawntimer >= 70){
			_spawnamp -= 0.008;
			if(_spawnamp < 0){
				_spawnamp = 0;
			}
		}
	
		if(_spawntimer >= 100){
			var p = instance_create_depth(x+(sprite_width*0.5)-16,y-12,0,obj_particle);
			p._lode_particle = true;
			p._type = "lode_flyblock";
		
			sfx_stop(snd_lode_enm_spawn1);
			sfx_play_proximity(snd_lode_enm_spawn2,0.9,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
			sfx_volume(snd_lode_enm_spawn2,clamp(audio_sound_get_gain(_allsounds[? snd_lode_enm_spawn2]),0,0.65));
		
			image_blend = c_white;
			image_alpha = 1;
		
			_spawnamp = 0;
			_spawnblend_amnt = 0;
		
			_spawning = false;
		}
	}
}