{
	if(!global._pause){
		image_speed = 1;
		
		visible = _trigger;
		
		if(_trigger){
			_timer ++;

			if(_act == 0 && _timer >= 30 && !_voice){
				voice_play_proximity(snd_lanky_hurry, global._bossvoices, 0.75);
				_voice = true;
			}
			if(_act == 0 && _timer >= 70){
				_timer = 0;
				_act = 1;
			}
			
			if(_act == 1 && _timer >= 120){
				if(!_dialogue){
					scr_startdialogue("dg_st2_cutscene", "u", 0);
					
					_dialogue = true;
				}
			}
			
			if(_act == 1 && _timer >= 300){
				instance_destroy();
			}
			
			if(_act >= 0){
				_lankvol -= 0.003;
				_lankpos += _lankspd;
				_lankind += 0.3;
				if(_allsounds != -1){
					if(!sfx_isplaying(snd_running1)){
						sfx_play_proximity(snd_running1, _lankvol);
					}
					audio_sound_gain(snd_running1, _lankvol);
				}
			}
			if(_act == 1){
				_hench1pos += _hench1spd;
				_hench2pos += _hench2spd;
				_henchind += 0.22;
				
				_henchtimer ++;
				_henchvol -= 0.006;
				if(_henchtimer >= random_range(10,30)){
					if(_allsounds != -1){
						voice_play_overlap_proximity(snd_henchie_notice, _henchvol);
						sfx_pitch(snd_henchie_notice, random_range(0.7,1.1));
					}
					_henchtimer = 0;
				}
			}
		}
	} else {
		image_speed = 0;
	}
}