{
	if(variable_instance_exists(self.id, "_allsounds") && _allsounds != undefined && _allsounds != -1){
		if(ds_map_exists(_allsounds, "emitter")){
			audio_emitter_free(_allsounds[? "emitter"]);
		}
		
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(variable_global_exists("_allvoices")){
		if(global._allvoices != undefined && global._allvoices != -1){
			ds_map_destroy(global._allvoices);
			global._allvoices = -1;
		}
	}
}