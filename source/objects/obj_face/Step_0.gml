{
	//make waveform
	if(!_init){
		_audiobuffer = buffer_load("visualiser/mus_gameover.wav");
		_bufferlength = buffer_get_size(_audiobuffer);
	
		if(global._cursong != -1){
			_soundlen = audio_sound_length(global._cursong);
	
			_init = true;
		}
	} else {
		if(global._cursong != -1){
			_soundpos = audio_sound_get_track_position(global._cursong);
		}
		if(_soundlen <> 0){
			_soundpercent = _soundpos/_soundlen;
		}
	}
	
	//face lerp
	_facescale = lerp(_facescale, clamp(obj_lost._loseOpt, 0.9, 1.38), 0.035);
}