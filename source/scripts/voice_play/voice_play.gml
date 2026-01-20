///function voice_play(sound_index, voice array, [volume])
function voice_play(sfx, voicearray, gain = 1.0){
	for(var i = 0; i < array_length(voicearray); i++){
		if(audio_is_playing(voicearray[i])){
			audio_stop_sound(voicearray[i]);
		}
	}
	if(global.sfx_bus.effects[0] == undefined){
		_allsounds[? sfx] = audio_play_sound(sfx, 0, false);
	
		audio_sound_gain(_allsounds[? sfx], gain, 0);
		
		if(global._buildver != HTML){
			if(!global._pause && global.sfx_effect == "echo"){
				_allsounds[? "delay"] = [sfx,4,0.45,2];
			}
		}
	} else {
		if(!ds_map_exists(_allsounds, "emitter") || (ds_map_exists(_allsounds, "emitter") && !audio_emitter_exists(_allsounds[? "emitter"]))){
			_allsounds[? "emitter"] = audio_emitter_create();
		}
		
		if(!global._pause){
			audio_emitter_bus(_allsounds[? "emitter"], global.sfx_bus);
		}
	
		audio_emitter_position(_allsounds[? "emitter"], 0, 0, 0);
		_allsounds[? sfx] = audio_play_sound_on(_allsounds[? "emitter"], sfx, false, 0, gain);
	}
	
	audio_sound_gain(_allsounds[? sfx], gain, 0);
	global._pauseSoundGains[? sfx] = gain;
}