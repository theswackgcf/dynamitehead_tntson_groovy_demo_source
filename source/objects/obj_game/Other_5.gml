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
	if(_dialm_surf != undefined){
		if(surface_exists(_dialm_surf)){
			surface_free(_dialm_surf);
		}
	}
	
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(_badnumb != undefined){
		ds_map_destroy(_badnumb);
		_badnumb = -1;
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
	if(global._allvoices != undefined){
		ds_map_destroy(global._allvoices);
		global._allvoices = -1;
	}
}