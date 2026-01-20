///function sfx_pause_all()
function sfx_pause_all(pause){
	with(all){
		if(variable_instance_exists(self, "_allsounds")){
			if(_allsounds != -1 && ds_map_size(_allsounds) > 0){
				var sfxarray = ds_map_keys_to_array(_allsounds);
				for(var i = 0; i < array_length(sfxarray); i++){
					if(typeof(sfxarray[i]) != "string"){
						var cursnd = asset_get_index(audio_get_name(sfxarray[i]));
						if(pause){
							if(!audio_is_paused(cursnd) && ds_map_exists(_allsounds, cursnd)){
								audio_pause_sound(_allsounds[? cursnd]);
							}
						} else {
							if(audio_is_paused(cursnd) && ds_map_exists(_allsounds, cursnd)){
								audio_resume_sound(_allsounds[? cursnd]);
							}
						}
						
						if(global._buildver != HTML){
							if(ds_map_exists(_allsounds, "delay")){
								if(_allsounds[? "delay"] != undefined && is_array(_allsounds[? "delay"])){
									if(array_length(_allsounds[? "delay"]) > 0){
										if(pause){
											audio_pause_sound(_allsounds[? "delay"][0]);
										} else {
											audio_resume_sound(_allsounds[? "delay"][0]);
										}
									}
								}
							}
						}
						
						if(ds_map_exists(_allsounds, sfxarray[i])){
							if(pause){
								audio_pause_sound(_allsounds[? sfxarray[i]]);
							} else {
								audio_resume_sound(_allsounds[? sfxarray[i]]);
							}
						}
						
						if(audio_exists(sfxarray[i])){
							if(pause){
								audio_pause_sound(sfxarray[i]);
							} else {
								audio_resume_sound(sfxarray[i]);
							}
						}
					}
				}
			}
		}
	}
}