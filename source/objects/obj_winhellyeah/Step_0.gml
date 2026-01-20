{
	depth = -10000;
	x = _xpos + global._cameraX + _offset[0];
	y = _ypos + global._cameraY + _offset[1];
	
	if(_size > 1){
		_size -= 0.7;
	} else if(_size <= 1){
		if(!_shake){
			sfx_play(snd_hellyeahletr);
			_amp = 18;
			_shake = true;
			
			global._pad_vibrate = 2;
		}
		_size = 1;
	}
	
	if(_amp > 0){
		_offset[0] = random(sin(480))*_amp;
		_offset[1] = random(cos(480))*_amp;
		_amp --;
	}
	if(_shake && _amp < 2){
		_amp = 2;
	}
	
	image_xscale = _size;
	image_yscale = _size;
}