{
	scr_sound_cleanup();
	
	if(_drawsurface != undefined && surface_exists(_drawsurface)){
		surface_free(_drawsurface);
		_drawsurface = -1;
	}
}