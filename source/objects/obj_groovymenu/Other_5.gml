{
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
	
	for(var i = 0; i < array_length(_manual_imgs); i++){
		if(sprite_exists(_manual_imgs[i])){
			sprite_delete(_manual_imgs[i]);
		}
	}
	
	if(_menubtn_surface != undefined){
		if(surface_exists(_menubtn_surface)){
			surface_free(_menubtn_surface);
		}
	}
}