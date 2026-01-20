{
	for(var i = 0; i < array_length(_stages); i++){
		if(_stages[i].surf != undefined){
			if(surface_exists(_stages[i].surf)){
				surface_free(_stages[i].surf);
			}
		}
	}
	
	if(_allsounds != undefined && _allsounds != -1){
		if(ds_map_exists(_allsounds, "emitter")){
			audio_emitter_free(_allsounds[? "emitter"]);
		}
		
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
}