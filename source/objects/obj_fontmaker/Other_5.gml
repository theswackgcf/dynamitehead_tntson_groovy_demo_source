{
	if(_glyphsurface != undefined){
		if(surface_exists(_glyphsurface)){
			surface_free(_glyphsurface);
		}
	}
	if(_fontsurface != undefined){
		if(surface_exists(_fontsurface)){
			surface_free(_fontsurface);
		}
	}
	if(_fontdata != undefined){
		if(surface_exists(_fontdata)){
			surface_free(_fontdata);
		}
	}
	
	ds_map_destroy(_exportdata);
	_exportdata = -1;
	
	ds_map_destroy(_fontdata);
	_fontdata = -1;
}