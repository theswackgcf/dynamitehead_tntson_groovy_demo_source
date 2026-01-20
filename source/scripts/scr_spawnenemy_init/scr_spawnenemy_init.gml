function scr_spawnenemy_init(){
	visible = false;
	
	_spawntype = SPAWN_NORMAL;
	_offset = [0,0,0];
	
	_enmtype = -1;
	
	_allsounds = ds_map_create();
	
	_trigger = true;
	_enmtrigger = false;
	
	_spawndir = "r";
	_glass = false;
	
	_startFade = false;
	
	_matchid = 0;
	
	_checkdelete = false;
	
	_nameoverwrite = "";
}