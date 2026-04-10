{
	visible = false;
	
	_type = "h";
	_side = "r";
	
	_gonext_xpos = 0;
	_gonext_inst = noone;
	
	_clear = false;
	_bzcleared = false;
	
	_act = 0;
	_init = false;
	_curwave = -1;
	_waveinit = false;
	_borders = [];
	_enemies = [];
	_bzSize = [sprite_width, sprite_height];
	_resize = false;
	_activated = false;
	
	_border_top_size = 1;
	_border_bottom_size = 1;
	
	_camOffsetX = 0;
	_camOffsetY = 0;
	
	_cutscene = noone;
	
	_deleteenm = false;
	
	_allsounds = ds_map_create();
	
	_checkdelete = false;
	
	_tutr_bigpunch = false;
}