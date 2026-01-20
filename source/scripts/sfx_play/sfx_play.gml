///function sfx_play(sound_index, [volume], [loop], [echo])
function sfx_play(sfx, gain = 1.0, loop = false, echo = false){
	if(global.sfx_bus.effects[0] == undefined){
		_allsounds[? sfx] = audio_play_sound(sfx, 0, loop, gain);
		audio_sound_gain(_allsounds[? sfx], gain, 0);
		if(global._buildver != HTML){
			if(!echo && !global._pause && global.sfx_effect == "echo" && !global._winscreen){
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
		_allsounds[? sfx] = audio_play_sound_on(_allsounds[? "emitter"], sfx, loop, 0, gain);
	}
}