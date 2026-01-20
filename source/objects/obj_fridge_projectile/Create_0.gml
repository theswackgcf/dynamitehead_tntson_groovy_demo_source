{
	event_inherited();
	
	_visible = true;
	visible = _visible;
	
	_xspd = 28;
	_height = 16;
	_dispoffset = [0,-48];
	
	_damage = ATK_NORM;
	
	_breakpower = 0; //dh shield break pwoer
	
	_scale2 = [0.9,0.9];
	
	_candodge = {
		roll: false,
		down: false,
		atk: false
	}
	
	_canparry = true;
	_cangetdamage = false;
	
	_shadsize = [0.4, 0.2];
	
	_food = true;
	
	function dead() {
		if(!_shielded){
			_freeze = 40;
			
			_shielded = true;
			_xspd *= -1;
		}
	}
}