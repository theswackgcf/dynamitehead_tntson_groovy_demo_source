{
	_allsounds = ds_map_create();
	
	_lode_object = true;
	
	_depth = 0;
	
	_show = true;
	
	_id = "";
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	x += sprite_width*0.5;
	y += sprite_height;
	y -= 8;
	
	_open = false;
	_change = false;
	_gate_offset = 0;
	_gate_yspd = 0;
	
	_stage_exit = false;
	_exit_timer = 0;
	
	_key_init = false;
	_has_key = false;
	
	_do_locked = 0;
	_locked = false;
	_locked_img = 0;
	_locked_spr = spr_lode_exit_locked;
	_lock_snd = false;
	
	visible = false;
}