///function sfx_play_choose(sfx_array, [volume], [loop])
function sfx_play_choose(array, gain = 1.0, loop = false){
	var len = array_length(array);
	sfx_play(array[floor(random(len))], gain, loop);
}