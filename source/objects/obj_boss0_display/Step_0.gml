{
	_scale = 1;
	
	image_xscale = _xscale * _scale;
	image_yscale = _yscale * _scale;
	_height = _parentobj._height;
	if(_parentobj != noone){
		x = _parentobj.x + _offset[0];
		y = (_parentobj.y + _offset[1]);
		if(!_parentobj._begin){
			y = (_parentobj._beginoffset + _offset[1]);
		}
	}
}