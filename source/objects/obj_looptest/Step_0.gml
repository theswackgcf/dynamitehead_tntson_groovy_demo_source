{
	if(!_init){
		for(var i = 0; audio_exists(i); i++){
			if(string_starts_with(audio_get_name(i), "mus_")){
				_musiclist[i] = asset_get_index(audio_get_name(i));
			}
		}
		
		var loaded = 0;
		for(var i = 0; i < array_length(_groups); i++){
			if(!audio_group_is_loaded(_groups[i])){
				audio_group_load(_groups[i]);
			} else {
				loaded ++;
			}
		}
		if(loaded >= array_length(_groups)){
			_audio = audio_play_sound(_musiclist[global._testloop_curmusic], 0, true);
			_soundlen = audio_sound_length(_audio);
			if(ds_map_exists(global._loops, audio_get_name(_audio))){
				_looppoint = global._loops[? audio_get_name(_audio)];
			}
			_init = true;
		}
	} else {
		_soundpos = audio_sound_get_track_position(_audio);
		
		_looppercent = _looppoint/_soundlen;
		_soundpercent = _soundpos/_soundlen;
		
		if(_playing && audio_is_paused(_audio)){
			audio_resume_sound(_audio);
		}
		if(!_playing && !audio_is_paused(_audio)){
			audio_pause_sound(_audio);
		}
		
		if(_playing){
			_stopped = false;
		}
		
		//looping
		if(_playing){
			if(_soundpos >= _looppoint){
				_surpassedloop = true;
			}
			if(_surpassedloop && _soundpos < _looppoint){
				audio_sound_set_track_position(_audio, _looppoint);
			}
		}
		
		//input
		if(keyboard_check_pressed(vk_space)){
			if(keyboard_check(vk_shift)){
				//stop
				audio_sound_set_track_position(_audio, 0);
				_playing = false;
				_stopped = true;
				_surpassedloop = false;
			} else {
				//play / resume
				if(!_playing){
					_playing = true;
				} else {
					_playing = false;
				}
			}
		}
		if(keyboard_check_pressed(ord("L"))){
			if(keyboard_check(vk_shift)){
				//set loop
				_looppoint = _soundpos;
				_surpassedloop = false;
			} else {
				//go to loop
				audio_sound_set_track_position(_audio, _looppoint);
			}
		}
		
		//precise position
		if(!_playing){
			function precise(offset) {
				var point = audio_sound_get_track_position(_audio)+offset;
				if(point < 0){
					point = 0;
				} else if(point > _soundlen-abs(offset*10)){
					point = _soundlen-abs(offset*10);
				}
				audio_sound_set_track_position(_audio, point);
			}
			if(keyboard_check_pressed(vk_left)){
				precise(-0.01);
			} else if(keyboard_check_pressed(vk_right)){
				precise(0.01);
			}
		}
		
		//set track position
		if(_mushover == -1){
			if(mouse_check_button(mb_left)){
				var mousereal = mouse_x - _trackoffset[0];
				if(mousereal < 0){
					mousereal = 0;
				} else if(mousereal > _tracksize[0]-1){
					mousereal = _tracksize[0]-1;
				}
				var mousepercent = mousereal/_tracksize[0];
				audio_sound_set_track_position(_audio, mousepercent*_soundlen);
			}
		}
		
		//choose music track
		if(_mushover != -1){
			if(mouse_check_button_pressed(mb_left)){
				global._testloop_curmusic = _mushover;
				
				audio_stop_all();
				
				room_restart();
			}
		}
	}
}