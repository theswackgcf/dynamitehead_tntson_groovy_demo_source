{
	visible = false;
	
	_inittimer = 0;
	
	_dir = "l";
	_timer = 0;
	_parentobj = noone;
	_active = false;
	
	_sequence = true;
	
	_setpos = false;
	
	_enemyicons = ds_map_create();
	_enemyicons[? "st2_enm1"] = 0;
	_enemyicons[? "st2_enm2"] = 1;
	_enemyicons[? "st2_enm2_mtcycle"] = 2;
	_enemyicons[? "st2_enm3"] = 3;
	_enemyicons[? "boss2"] = 4;
	
	_codename = "";
	_enmtype = -1;
	_maxcolors = 1;
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	_spblend = c_white;
	
	_hpcolor = c_white;
}