{
	_allsounds = ds_map_create();
	
	visible = false;
	_order = 0;
	_asset = noone;
	
	_spawnX = 0;
	_spawnY = 0;
	
	_spawndir = "";
	_spawnpos = [0,0];
	_offscreenpos = [0,0];
	
	_doenmtype = false;
	_enmtype = -1;
	
	_dostarttimer = false;
	_startTimer = 0;
	
	_battlezone = true;
	_bzobj = noone;
	
	_enmobj = false;
	_ailevel = 0;
	_bzstart = 0;
	_bzstart_offset = 0;
	
	_spawntype = SPAWN_NORMAL;
	_curstate = STATE_IDLE;
	_walkto = [0,0];
	
	_startFade = false;
	
	_fallabove = false;
	_height = 0;
	_vspd = 0;
	_jump = false;
	_standup = false;
	
	_canspawn = 0;
}