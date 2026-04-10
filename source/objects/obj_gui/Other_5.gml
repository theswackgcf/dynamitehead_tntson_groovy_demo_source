{
	if(_allsounds != undefined && _allsounds != -1){
		if(ds_map_exists(_allsounds, "emitter")){
			audio_emitter_free(_allsounds[? "emitter"]);
		}
		
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(_dialm_surf != undefined){
		if(surface_exists(_dialm_surf)){
			surface_free(_dialm_surf);
		}
	}
}