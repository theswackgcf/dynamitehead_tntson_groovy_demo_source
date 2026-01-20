{
	if(_parentobj != noone && instance_exists(_parentobj)){
		x = _parentobj.x+_offset[0];
		y = _parentobj.y+_offset[1];
	}
	
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
}