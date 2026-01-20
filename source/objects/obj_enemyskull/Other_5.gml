{
	if(global._gameshadows != undefined && global._gameshadows != -1){
		if(ds_map_exists(global._gameshadows, _occupy_id)){
			ds_map_delete(global._gameshadows, _occupy_id);
		}
	}
	
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
}