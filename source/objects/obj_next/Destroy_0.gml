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
	
	ds_map_destroy(_allsounds);
	_allsounds = -1;
}