{
	depth = -9991;
	x = _xpos + global._cameraX;
	y = _ypos + global._cameraY;
	
	sprite_index = asset_get_index("spr_minidh_pose"+string(_sp));
	
	_xpos += _xvel;
	if(_xvel > 0 && x >= global._cameraX + WIDTH){
		_xpos = -_gridsize;
	}
	if(_xvel < 0 && x <= global._cameraX - _gridsize){
		_xpos = WIDTH;
	}
}