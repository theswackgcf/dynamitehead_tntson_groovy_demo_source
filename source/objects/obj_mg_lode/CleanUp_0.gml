{
	if(global._lode_editor_layerarray != undefined && global._lode_editor_layerarray != -1){
		ds_map_destroy(global._lode_editor_layerarray);
		global._lode_editor_layerarray = -1;
	}
	
	if(global._sign_layout != undefined && global._sign_layout != -1){
		ds_map_destroy(global._sign_layout);
		global._sign_layout = -1;
	}
	
	if(_tileinfo != undefined && _tileinfo != -1){
		ds_map_destroy(_tileinfo);
		_tileinfo = -1;
	}
	
	if(_sprinfo != undefined && _sprinfo != -1){
		ds_map_destroy(_sprinfo);
		_sprinfo = -1;
	}
	
	if(_project != undefined && _project != -1){
		ds_map_destroy(_project);
		_project = -1;
	}
	
	if(_editor_tileselect_dsmap != undefined && _editor_tileselect_dsmap != -1){
		ds_map_destroy(_editor_tileselect_dsmap);
		_editor_tileselect_dsmap = -1;
	}
	
	if(_display != undefined && surface_exists(_display)){
		surface_free(_display);
	}
	
	scr_sound_cleanup();
}