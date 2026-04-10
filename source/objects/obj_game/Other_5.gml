{
	if(_allsounds != undefined && _allsounds != -1){
		if(ds_map_exists(_allsounds, "emitter")){
			audio_emitter_free(_allsounds[? "emitter"]);
		}
		
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(global._bzone_fx != undefined && global._bzone_fx != 1){
		ds_map_destroy(global._bzone_fx);
		global._bzone_fx = -1;
	}
	
	if(global._easings != undefined){
		ds_map_destroy(global._easings);
		global._easings = -1;
	}
	if(global._portraits != undefined){
		ds_map_destroy(global._portraits);
		global._portraits = -1;
	}
	if(global._bossinfo != undefined){
		ds_map_destroy(global._bossinfo);
		global._bossinfo = -1;
	}
	if(global._guiNumColors != undefined){
		ds_map_destroy(global._guiNumColors);
		global._guiNumColors = -1;
	}
}