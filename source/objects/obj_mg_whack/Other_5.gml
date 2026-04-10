{
	if(_allsounds != undefined && _allsounds != -1){
		if(ds_map_exists(_allsounds, "emitter")){
			audio_emitter_free(_allsounds[? "emitter"]);
		}
		
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(_flames != -1){
		if(ds_map_size(_flames) > 0){
			var dskeys = ds_map_keys_to_array(_flames);
			for(var i = 0; i < array_length(dskeys); i++){
				if(ds_map_exists(_flames, dskeys[i])){
					ds_map_delete(_flames, dskeys[i]);
				}
			}
		}
		
		ds_map_destroy(_flames);
		_flames = -1;
	}
	
	if(_enemystate != -1){
		ds_map_destroy(_enemystate);
		_enemystate = -1;
	}
}