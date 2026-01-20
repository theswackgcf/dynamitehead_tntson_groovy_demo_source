///function mus_play(sound_index, [volume])
function mus_play(mus, gain = 1.0){
	if(global._cursong != mus){
		global._looped = 0;
		if(global._cursong != -1){
			audio_stop_sound(global._cursong);
		}
		global._curSongGain = gain;
		global._cursong = audio_play_sound_on(global.mus_emitter, mus, true, 0, gain);
		with(obj_music){
			_musindex = mus;
		}
	}
}