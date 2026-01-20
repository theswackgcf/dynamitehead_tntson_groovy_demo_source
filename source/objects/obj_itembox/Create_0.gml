{
	_active = true;
	
	_allsounds = ds_map_create();
	_parentobj = noone;
	_parentpos = [x,y];
	_dir = "r";
	_height = 9999;
	_height_draw = 0;
	_sort = true;
	_collidewith = "player";
	image_xscale = global._scale;
	image_yscale = global._scale;
	
	visible = false;
	_vtimer = 0;
	
	_boxonly = false;
	_boxonlytimer = 0;
	
	_trigger = 0;
	_timer = 0;
	_timermax = 50;
	
	_shadowsinit = false;
	_shadowmult = 1;
	
	_init = false;
	_intimer = 0;
	
	_wire = noone;
	
	_showself = true;
	_nukeframe = 0;
	_nukeloop = true;
	_nukeactive = true;
	
	_spawn8dir = false;
	_spawncount_bottom = 0;
	
	_spawntop_offset = -30;
	
	_deadtimer = 0;
}