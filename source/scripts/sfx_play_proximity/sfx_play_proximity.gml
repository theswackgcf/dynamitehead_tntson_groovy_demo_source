///function sfx_play_proximity(sound_index, [volume], [loop], [point_x], [point_y])

//default point is to the center of the screen
function sfx_play_proximity(sfx, gain = 1.0, loop = false, point_x = global._cameraX+(WIDTH/2), point_y = global._cameraY+(HEIGHT/2)){
	var offset = [global._proximityoffset[0], global._proximityoffset[1]];
	var disttopoint = [1-(clamp(diff_abs(x, point_x)/(WIDTH+offset[0]), 0, 1)),1-(clamp(diff_abs(y, point_y)/(HEIGHT+offset[1]), 0, 1))];
	var newgain = clamp(sqrt_value(disttopoint[0],disttopoint[1]), 0, 1);
	var pan = clamp(diff_abs(x, point_x)/(WIDTH+offset[0]), 0, 1);
	
	var newpan = 0;
	if(x < point_x){
		newpan = -pan;
	} else {
		newpan = pan;
	}
	
	var medvalue = -median(-1, newpan, 1);
	if(global._buildver == HTML){
		medvalue = 0;
	}
	
	audio_falloff_set_model(audio_falloff_linear_distance);
	audio_listener_position(medvalue*global._panmultiply,0,0);
	_allsounds[? sfx] = audio_play_sound(sfx, 0, loop, gain*newgain);
	
	global._pauseSoundGains[? sfx] = gain*newgain;
}