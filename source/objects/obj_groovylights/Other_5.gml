{
	if(_surface != undefined){
		if(surface_exists(_surface)){
			surface_free(_surface);
		}
	}
	if(_tempsurf != undefined){
		if(surface_exists(_tempsurf)){
			surface_free(_tempsurf);
		}
	}
	
	if(global._groovylights != undefined){
		ds_map_destroy(global._groovylights);
		global._groovylights = -1;
	}
}