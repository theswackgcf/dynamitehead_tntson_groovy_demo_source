{
	depth = -5001;
	if(!global._pause){
		image_speed = 1;
		
		if(!_dovoice){
			if(_playvoice != -1){
				voice_play_overlap_proximity(_playvoice);
				sfx_pitch(_playvoice, random_range(0.9,1.3));
			}
			
			_dovoice = true;
		}
		
		_timer ++;
		_sintimer ++;
		if(!_init){
			sfx_play(snd_whistle);
			_init = true;
		}
		if(_spd[0] > 0){
			image_xscale = 1*_scale;
		} else {
			image_xscale = -1*_scale;
		}
		image_yscale = _scale;
		x += _spd[0]*_speedup;
		y += _spd[1]*_speedup;
		_scale += 0.022*_speedup;
		_spd[1] += 0.52*_speedup;
		if(_scale >= 0.9){
			_alpha -= 0.04;
		}
				
		if(y >= global._cameraY+HEIGHT+1400){
			sfx_stop(snd_whistle);
			sfx_play(snd_bosscrash);
			sfx_play_choose([snd_badhead_crash1,snd_badhead_crash2,snd_badhead_crash3,snd_badhead_crash4], 0.75);
			with(obj_camera){
				_ampY = 45;
			}
			
			if(_battlezone && !_confirmkill){
				global._enmorder ++;
				_confirmkill = true;
			}
			
			instance_destroy();
		}
	} else {
		image_speed = 0;
	}
	
	sprite_index = asset_get_index("spr_"+_codename+"_finalko");
}