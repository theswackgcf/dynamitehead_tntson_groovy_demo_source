{
	if(_lankf_offsets != undefined){
		ds_map_destroy(_lankf_offsets);
		_lankf_offsets = -1;
	}
	
	if(_lankframes != undefined){
		ds_map_destroy(_lankframes);
		_lankframes = -1;
	}
	
	if(_mineds != undefined){
		ds_map_destroy(_mineds);
		_mineds = -1;
	}
	
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
}