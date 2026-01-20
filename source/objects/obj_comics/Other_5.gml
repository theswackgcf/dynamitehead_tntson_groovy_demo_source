{
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(_comics != undefined && _comics != -1){
		var dskeys = ds_map_keys_to_array(_comics);
		for(var i = 0; i < array_length(dskeys); i++){
			if(_comics[? dskeys[i]] != undefined && _comics[? dskeys[i]] != -1){
				ds_map_delete(_comics, dskeys[i]);
			}
		}
		
		ds_map_destroy(_comics);
		_comics = -1;
	}
}