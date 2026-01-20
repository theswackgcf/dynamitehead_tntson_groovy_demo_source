{
	_offset = global._screenSideOffset;
	_surfdim = [global._res[global._curres][0]+_offset, global._res[global._curres][1]+_offset];
	_surface = surface_create(_surfdim[0], _surfdim[1]);
	_draw = false;
	
	_scalex = 1;
	_scaley = 1;
	
	_starrot = 0;
	_starscale = 0;
	_timer = 0;
	
	_forcedepth = 0;
}
