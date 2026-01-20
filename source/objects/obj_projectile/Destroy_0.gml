{
	if(ds_map_exists(global._gameshadows, _occupy_id)){
		ds_map_delete(global._gameshadows, _occupy_id);
	}

	ds_map_destroy(_allsounds);
	_allsounds = -1;
}