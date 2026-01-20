{
	if(_surface != undefined){
		if(surface_exists(_surface)){
			surface_free(_surface);
		}
	}
}