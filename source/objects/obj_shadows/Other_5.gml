{
	if(global._gameshadows != undefined && global._gameshadows != -1){
		ds_map_destroy(global._gameshadows);
		global._gameshadows = -1;
	}
	
	if(_surface != undefined){
		if(surface_exists(_surface)){
			surface_free(_surface);
		}
	}
}