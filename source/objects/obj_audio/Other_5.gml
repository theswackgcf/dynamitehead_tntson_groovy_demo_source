{
	if(variable_instance_exists(self.id, "_allsounds") && _allsounds != undefined && _allsounds != -1){
		ds_map_destroy(_allsounds);
		_allsounds = -1;
	}
}