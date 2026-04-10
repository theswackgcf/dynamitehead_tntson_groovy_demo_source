{
	scr_sound_cleanup();
	
	if(_drawsurface != undefined && surface_exists(_drawsurface)){
		surface_free(_drawsurface);
		_drawsurface = -1;
	}
	
	if(_surf_sprites != undefined && _surf_sprites != -1){
		ds_map_destroy(_surf_sprites);
		_surf_sprites = -1;
	}
}