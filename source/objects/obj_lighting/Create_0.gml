{
	depth = -5099;
	_surfdim = [global._res[global._curres][0], global._res[global._curres][1]];
	_surface = surface_create(_surfdim[0], _surfdim[1]);
	_draw = false;
	
	_scalex = 1;
	_scaley = 1;
	
	_color = [[0,0,0],[0,0,0]];
	_colorTo = [[0,0,0],[0,0,0]];
	
	_offtimer = 0;
	_ontimer = 0;
	
	_spd = 0.14;
	
	_thunderalp = 0;
}