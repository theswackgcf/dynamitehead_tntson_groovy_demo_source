{
	_allsounds = ds_map_create();
	
	_dh = noone;
	_groundlevel = 0;
	_height = _groundlevel;
	
	_walktimer = 0;
	_dirttimer = 0;
	_offsety = 32;
	
	_timer = 0;
	_storepos = y;
	
	_dodge = false;
	_grabcd = 0;
	
	_dead = false;
	_deathact = 0;
	_deathtimer = 0;
	
	_death_inst = noone;
	
	_vanish = false;
	
	_shadowsinit = false;
	
	_checkdelete = false;
}