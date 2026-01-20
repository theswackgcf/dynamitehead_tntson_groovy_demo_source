{
	if(_gui_surface != undefined){
		if(surface_exists(_gui_surface)){
			surface_free(_gui_surface);
		}
	}
	if(_resizegui_surface != undefined){
		if(surface_exists(_resizegui_surface)){
			surface_free(_resizegui_surface);
		}
	}
	
	if(_allsounds != undefined && _allsounds != -1){
		if(ds_map_exists(_allsounds, "emitter")){
			audio_emitter_free(_allsounds[? "emitter"]);
		}
		
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(_actiontimer != undefined){
		ds_map_destroy(_actiontimer);
		_actiontimer = -1;
	}
}