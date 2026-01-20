{
	event_inherited();
	
	_visible = true;
	visible = _visible;
	
	_xspd = 28;
	_height = 16;
	_dispoffset = [0,-86];
	
	_damage = ATK_NORM;
	_add_damage = 3;
	
	_breakpower = 0.2; //dh shield break pwoer
	
	_scale2 = [0.9,0.9];
	
	_candodge = {
		roll: true,
		down: true,
		atk: true
	}
	
	_canparry = true;
	
	_shadsize = [0.4, 0.2];
	
	_enmtype = -1;
	
	_maxcolors = 1;
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	function dead() {
		var p = instance_create_depth(x-32, y-32-_dispoffset[1], depth, obj_particle);
		p._type = "vanish";
									
		instance_destroy();
	}
}