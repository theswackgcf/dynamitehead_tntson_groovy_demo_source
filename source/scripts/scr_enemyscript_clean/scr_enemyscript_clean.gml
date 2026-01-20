function scr_enemyscript_clean(){
	if(_allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
	
	if(_path != 0){
		path_delete(_path);
		_path = 0;
		_pathtimer = 0;
	}
	
	if(_pathgrid != undefined && _pathgrid != 0){
		mp_grid_destroy(_pathgrid);
		global._mpGridCount--;
	}
}