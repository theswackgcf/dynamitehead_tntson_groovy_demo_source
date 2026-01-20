{
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	with(obj_music){
		global.music_bus.effects[0] = undefined;
	}
}