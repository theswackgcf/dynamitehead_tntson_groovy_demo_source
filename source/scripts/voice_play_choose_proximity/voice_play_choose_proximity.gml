///function voice_play_choose_proximity(sfx_array, voice array, [volume], [point_x], [point_y])
function voice_play_choose_proximity(array, voicearray, gain = 1.0, point_x = global._cameraX+(WIDTH/2), point_y = global._cameraY+(HEIGHT/2)){
	var len = array_length(array);
	voice_play_proximity(array[floor(random(len))], voicearray, gain, point_x, point_y);
}