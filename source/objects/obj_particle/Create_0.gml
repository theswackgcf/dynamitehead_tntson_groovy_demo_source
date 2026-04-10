{
	_freeze = 0;
	
	_type = "";
	_timer = 0;
	_curdir = DIR_R;
	
	_move = false;
	_xspd = 0;
	_yspd = 0;
	
	_do_grav = false;
	_grav_val = 0.5;
	
	_scale = 1;
	
	_sort = true;
	_depthoffset = 48;
	
	_forcedepth = 0;
	
	_frameend = true;
	
	_damage = -1;
	_adddepth = 48;
	
	_color = make_color_rgb(255,255,255);
	
	_start_xscale = 1;
	_start_yscale = 1;
	
	_rotate = false;
	_rotate_spd = 0;
	
	_alpha = false;
	_alpha_spd = 0;
	
	_changescale = false;
	_changescale_spd = 0;
	
	image_blend = _color;
	_angle = 0;
	
	_tilepos = [0,0];
	_lode_particle = false;
	_lode_depth = 10;
	_id = "particle"+string(irandom(99999));
	_tilelayer = 1;
	_lode_project = true;
	_lode_deadtimer = 0;
	
	if(_lode_particle){
		visible = false;
	}
	
	_init = false;
}