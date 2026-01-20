{
	if(!global._pause){
		if(!_init){
			for(var i = 0; i < array_length(_charw); i++){
				_totalw += _charw[i]+_spacing;
			}
			var curpos = 0;
			for(var i = 0; i < array_length(_charw); i++){
				curpos += _offsetl[i];
				_nummap[? i] = [
					i,
					(x-(_totalw/2))+curpos, y, random_range(-3, 3), -8.8
				];
				curpos += _charw[i]+_spacing;
			}
			_init = true;
		} else {
			_timer ++;
			
			_shakeoff = [sin(random(480))*_amp,cos(random(480))*_amp];
			
			_amp -= 1;
			if(_amp < 3){
				_amp = 3;
			}
			
			if(_timer >= _droptimer){
				for(var i = 0; i < array_length(_charw); i++){
					if(_timer >= _droptimer+(i*4)){
						_nummap[? i][4] += _grav;
						_nummap[? i][1] += _nummap[? i][3];
						_nummap[? i][2] += _nummap[? i][4];
					}
				}
				
				_yvel += _grav;
				_boxy += _yvel;
			}
			
			if(_timer > 0 && !visible){
				visible = true;
			}
	
			image_yscale = lerp(image_yscale, 1.4, 0.15);
			image_xscale = lerp(image_xscale, 1.4, 0.15);
			
			//destroying
			if(_timer >= 320 || _nummap[? array_length(_charw)-1][2] >= global._cameraY+HEIGHT+128){
				instance_destroy();
			}
		}
	} else {
		_shakeoff = [0,0];
	}
}