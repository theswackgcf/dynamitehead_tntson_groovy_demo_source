{
	event_inherited();
	
	_visible = true;
	visible = _visible;
	
	_xspd = 1.5;
	_startheight = 0;
	_height = _startheight;
	_timer = 0;
	_dispoffset = [0,-86];
	
	_damage = ATK_NORM;
	_add_damage = 2;
	
	_breakpower = 0.2; //dh shield break pwoer
	
	_scale2 = [0.9,0.9];
	
	_candodge = {
		roll: true,
		down: false,
		atk: true
	}
	
	_canparry = true;
	
	_shadsize = [0.8, 0.5];
	
	function dead() {
		var p = instance_create_depth(x-32, y-32-_dispoffset[1], depth, obj_particle);
		p._type = "vanish";
									
		instance_destroy();
	}
}