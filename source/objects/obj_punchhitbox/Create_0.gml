{
	visible = false;
	
	_parentobj = noone;
	_forcefollow = false;
	_forcefollow_pos = [x,y];
	_offset = [0,0];
	_scale = [0,0];
	_timer = 16;
	_timerignore = false;
	_damage = ATK_NORM;
	_add_damage = 0;
	_combo = false;
	_type = "";
	_persist = false;
	_curdir = DIR_R;
	_parentdir = true;
	_bothdir = false;
	_slam = false;
	_curdir = 0;
	
	_height = 50;
	_diffabs = [42,70]; //y, height
	
	_ptype = "pl";
	
	_success = false;
	
	_active = true;
	_delay = 0;
	_frame_active = false;
	_frame = 0;
	_shielded = false;
	_shieldt = 0;
	
	_canparry = true;
	
	_destroy_timer = 0;
}