{
	depth = -2000;
	if(!global._pause){
		if(visible){
			if(!_trigger && distance_to_object(obj_dh_mask) < 200){
				for(var i = 0; i < array_length(global._enemyArray); i++){
					with(global._enemyArray[i]){
						killself();
					}
				}
				with(obj_battlezone_trigger){
					if(!_boss){
						instance_destroy();
					}
				}
				with(obj_seq_enmhop){
					instance_destroy();
				}
				mus_stop();
				_snd = audio_play_sound(snd_checkp, 0, false);
				audio_sound_pitch(_snd, 0.08);
				scr_startdialogue("dg_st2_easteregg", "u", 100, true);
				_storex = x - global._cameraX;
				_storey = y - global._cameraY;
				_trigger = true;
				global._easteregg_goblin = true;
			}
		}
		if(_trigger){
			if(global._cursong != -1 && audio_is_playing(global._cursong)){
				mus_stop();
			}
			x = _storex + global._cameraX;
			y = _storey + global._cameraY;
		}
		if(global._bossstart){
			global._easteregg_goblin = false;
			instance_destroy();
		}
	}
}