{
	_init = false;
	
	_color = c_white;
	_plus = false;
	_addstr = "";
	_money = false;
	_tnt = false;
	
	_string = "0123456789+$F";
	_fnt = font_add_sprite_ext(sprite_index, _string, true, 0);
	_charw = 58;
	
	_num = 0;
	
	_grav = 0.45;
	
	x += random_range(-24,24);
	y += random_range(-24,24);
	
	_boxx = x;
	_boxy = y;
	_xvel = random_range(-3, 3);
	_yvel = -8.8;
	
	_alpha = 1;
	_timer = 0;
	visible = false;
	
	image_xscale = 2.4;
	image_yscale = 2.4;
	depth = -(9900+instance_number(obj_nums));
	
	_numstring = "";
	_nummap = ds_map_create();
	_amp = 12;
	_shakeoff = [0,0];
	_addoffset = 0;
	_drawback = true;
	
	_randspd = [0,0];
}