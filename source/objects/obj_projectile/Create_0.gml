{
	_allsounds = ds_map_create();

	_delay = 0;
	_delayed = false;

	_active = true;
	_shielded = false;
	_shieldt = 0;
	
	_battlezone = false;
	_bzobj = noone;
	
	_spawnpos = [0,0];
	_offscreenpos = [0,0];
	
	_xspd = 0;
	_curdir = DIR_R;
	_spawndir = "";
	_setspawndir = false;
	_freeze = 0;
	
	_height = 0;
	_groundlevel = 0;
	
	_heightdiff = [42, 70]; //diff between y and player y, diff between height and player height
	
	_dispoffset = [0,0];
	
	_sort = true;
	_depthoffset = 0;
	
	_forcedepth = 0;
	
	_damage = ATK_NORM;
	_add_damage = 0;
	
	_candodge = {
		roll: false,
		down: false,
		atk: false
	}
	
	_cangetdamage = true;
	_canparry = false;
	_killedbyshield = true;
	
	_breakpower = 0.2; //dh shield break pwoer
	
	_scale2 = [1,1];
	
	_canhit = [];
	_killoffscreen = true;
	
	_temp = false;
	_deathtimer = 0;
	
	//other cases
	_bike = false;
	
	image_xscale = _scale2[0]*_curdir;
	image_yscale = _scale2[1];
	
	//set occupy id
	_occupy_id = "";
	_letr = global._occupyCharset;
	for(var i = 0; i < 7; i++){
		_occupy_id += string_char_at(_letr, round(random_range(1, string_length(_letr))));
	}
	
	_shadowsinit = false;
	_shadowmult = [1,1];
	
	_shadsize = [1,1];
	
	_visible = false;
	visible = _visible;
	
	_food = false;
	
	function dead() {
	}
}