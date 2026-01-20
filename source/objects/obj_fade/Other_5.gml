{
	if(_surface != undefined){
		if(surface_exists(_surface)){
			surface_free(_surface);
		}
	}
	
	if(_instmap != undefined){
		ds_map_destroy(_instmap);
		_instmap = -1;
	}
	
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
}