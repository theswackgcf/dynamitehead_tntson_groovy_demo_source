{
	if(_camera != undefined){
		camera_destroy(_camera);
	}
	
	if(_boss_surface != undefined){
		if(surface_exists(_boss_surface)){
			surface_free(_boss_surface)
		}
	}
	
	if(_boss_surface_resize != undefined){
		if(surface_exists(_boss_surface_resize)){
			surface_free(_boss_surface_resize)
		}
	}
}