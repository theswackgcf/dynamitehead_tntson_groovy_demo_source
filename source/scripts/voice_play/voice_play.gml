///function voice_play(sound_index, voice array, [volume])
function voice_play(sfx, voicearray, gain = 1.0){
	for(var i = 0; i < array_length(voicearray); i++){
		if(audio_is_playing(voicearray[i])){
			audio_stop_sound(voicearray[i]);
		}
	}
	_allsounds[? sfx] = audio_play_sound(sfx, 0, false, gain);
	
	audio_sound_gain(_allsounds[? sfx], gain, 0);
	global._pauseSoundGains[? sfx] = gain;
}