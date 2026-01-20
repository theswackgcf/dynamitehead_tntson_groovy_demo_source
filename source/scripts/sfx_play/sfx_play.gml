///function sfx_play(sound_index, [volume], [loop])
function sfx_play(sfx, gain = 1.0, loop = false){
	_allsounds[? sfx] = audio_play_sound(sfx, 0, loop, gain);
}