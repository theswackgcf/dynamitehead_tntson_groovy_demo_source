{
	_allsounds = ds_map_create();
	
	_lode_object = true;
	
	_depth = 64;
	
	_init = false;
	
	_show = true;
	
	_id = "";
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_timer = 0;
	
	_particle_timer = 0;
	_grad_timer = 0;
	_grad_x = 0;
	
	_startx = -900;
	_starty = -120;
	
	x = _startx;
	y = _starty;
	
	_offsetx = 0;
	_spd = 1.12;
	
	_vol = 0;
	
	_stopsnd = false;
	_stop = false;
	
	_surf_dim = [global._lode_disp_dim[0]+700,global._lode_disp_dim[1]+240];
	_drawsurface = surface_create(_surf_dim[0],_surf_dim[1]);
	
	_surf_sprites = ds_map_create();
	
	visible = true;
}