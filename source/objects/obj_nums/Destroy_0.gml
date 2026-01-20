{
	if(variable_instance_exists(self.id, "_fnt")){
		if(font_exists(_fnt)){
			font_delete(_fnt);
		}
	}
	
	ds_map_destroy(_nummap);
	_nummap = -1;
}