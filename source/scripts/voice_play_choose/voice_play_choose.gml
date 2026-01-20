///function voice_play_choose(sfx_array, voice array, [volume])
function voice_play_choose(array, voicearray, gain = 1.0){
	var len = array_length(array);
	voice_play(array[floor(random(len))], voicearray, gain);
}