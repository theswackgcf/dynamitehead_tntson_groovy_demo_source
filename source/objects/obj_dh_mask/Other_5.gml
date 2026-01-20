{
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(_sfx != undefined){
		ds_map_destroy(_sfx);
		_sfx = -1;
	}
}