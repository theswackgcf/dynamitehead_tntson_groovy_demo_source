{
	if(_solid != noone && instance_exists(_solid)){
		instance_destroy(_solid.id);
	}
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
}