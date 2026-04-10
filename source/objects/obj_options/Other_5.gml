{
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(_actiontimer != undefined){
		ds_map_destroy(_actiontimer);
		_actiontimer = -1;
	}
}