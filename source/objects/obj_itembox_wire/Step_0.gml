{
	if(!global._pause){
		image_speed = 1;
		if(!_fuse){
			_frame = 0;
		} else {
			_frame += 0.7;
			if(_frame >= 3){
				_frame = 3;
				_gone = true;
				_fuse = false;
			}
		}
		if(_parentobj != noone && instance_exists(_parentobj)){
			_height = _parentobj._height_draw;
		}
	} else {
		image_speed = 0;
	}
}