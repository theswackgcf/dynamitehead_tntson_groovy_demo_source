{
	global._groovylights = ds_map_create();
	
	_surfdim = [global._camerasize[0]*global._appsurfScale, global._camerasize[1]*global._appsurfScale];
	_surface = surface_create(_surfdim[0],_surfdim[1]);
	
	_tempsurf = surface_create(_surfdim[0],_surfdim[1]);
}