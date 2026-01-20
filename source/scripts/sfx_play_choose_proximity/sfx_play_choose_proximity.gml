///function sfx_play_choose_proximity(sfx_array, [volume], [loop], [point_x], [point_y])
function sfx_play_choose_proximity(array, gain = 1.0, loop = false, point_x = global._cameraX+(WIDTH/2), point_y = global._cameraY+(HEIGHT/2)){
	var len = array_length(array);
	sfx_play_proximity(array[floor(random(len))], gain, loop, point_x, point_y);
}