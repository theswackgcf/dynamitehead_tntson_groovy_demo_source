///function voice_play_overlap(sound_index, [volume])
function voice_play_overlap(sfx, gain = 1.0){
	_allsounds[? sfx] = audio_play_sound(sfx, 0, false, gain);
	
	global._pauseSoundGains[? sfx] = gain;
}