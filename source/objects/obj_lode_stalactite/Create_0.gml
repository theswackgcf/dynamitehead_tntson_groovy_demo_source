{
	_allsounds = ds_map_create();
	
	_lode_object = true;
	
	_depth = -1;
	
	_show = true;
	
	_id = "";
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_checker = false;
	_checkerobj = noone;
	
	_offset = [0,0];
	_trigger = false;
	_trigger_timer = 0;
	_trigger_act = 0;
	_landy = y;
	_shake_amp = 0;
	
	_falltimer = 99;
	
	_hitbox = noone;
	_checkdelete = false;
	
	visible = false;
}