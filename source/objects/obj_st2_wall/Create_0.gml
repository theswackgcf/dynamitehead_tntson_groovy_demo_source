{
	_allsounds = ds_map_create();
	
	_id = 0;
	
	_wall_offs = 0;
	_wall_alp = 1;
	_wall_spd = 0;
	
	_borders = [-300,0];
	_alphas = [0.45,1];
	
	_init = false;
	
	_open = true;
	_changing = false;
	
	_bounce = false;
	
	_dhdist = HEIGHT;
	
	_solid = noone;
	
	_sort = true;
	_depthoffset = 0;
	
	_forcedepth = 0;
}