///function sfx_stop_all()
function sfx_stop_all(){
	with(all){
		if(variable_instance_exists(self, "_allsounds")){
			if(ds_map_size(_allsounds) > 0){
				var sfxarray = ds_map_keys_to_array(_allsounds);
				for(var i = 0; i < array_length(sfxarray); i++){
					var cursnd = asset_get_index(audio_get_name(sfxarray[i]));
					if(audio_is_playing(cursnd)){
						audio_stop_sound(cursnd);
					}
				}
				if(ds_map_exists(_allsounds, "emitter")){
					audio_emitter_free(_allsounds[? "emitter"]);
				}
				ds_map_destroy(_allsounds);
				_allsounds = ds_map_create();
			}
		}
	}
}