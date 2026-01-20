///function mus_fade(volume, time, [stop on end])
function mus_fade(gain, time, stop = false){
	if(global._cursong != -1){
		audio_sound_gain(global._cursong, gain, time);
		global._curSongGain = audio_sound_get_gain(global._cursong);
		if(stop){
			if(diff(audio_sound_get_gain(global._cursong), gain) < 0.1){
				mus_stop();
			}
		}
	}
}