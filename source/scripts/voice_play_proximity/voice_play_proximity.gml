///function voice_play_proximity(sound_index, voice array, [volume], [point_x], [point_y])
function voice_play_proximity(sfx, voicearray, gain = 1.0, point_x = global._cameraX+(WIDTH/2), point_y = global._cameraY+(HEIGHT/2)){
	for(var i = 0; i < array_length(voicearray); i++){
		if(audio_is_playing(voicearray[i])){
			audio_stop_sound(voicearray[i]);
		}
	}
	
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
	
	if(!ds_map_exists(_allsounds, "emitter") || (ds_map_exists(_allsounds, "emitter") && !audio_emitter_exists(_allsounds[? "emitter"]))){
		_allsounds[? "emitter"] = audio_emitter_create();
	}
	
	if(!global._pause){
		audio_emitter_bus(_allsounds[? "emitter"], global.sfx_bus);
	}
	
	var medvalue = -median(-1, newpan, 1);
	if(global._buildver == HTML){
		medvalue = 1;
	}
	
	audio_emitter_position(_allsounds[? "emitter"], medvalue*global._panmultiply, 0, 0);
	_allsounds[? sfx] = audio_play_sound_on(_allsounds[? "emitter"], sfx, false, 0, gain*newgain);
	
	if(global._buildver != HTML){
		if(!global._pause && global.sfx_effect == "echo"){
			_allsounds[? "delay"] = [sfx,4,0.45,2];
		}
	}
	
	global._pauseSoundGains[? sfx] = gain*newgain;
}