{
	if(!global._pause){
		_scalex = lerp(_scalex, _scaletox, 0.19);
		_scaley = lerp(_scaley, _scaletoy, 0.09);
		
		_amp = 0.08;
		
		image_xscale = _scalex+sin(random(480))*_amp;
		image_yscale = _scaley+cos(random(480))*_amp;
		
		_timer ++;
		if(_timer < 6){
			_scaletox = 1;
			_scaletoy = 1;
		} else if(_timer >= 6 && _timer < 20){
			_scalex = _scaletox;
			_scaley = _scaletoy;
		} else {
			_scaletox = 0;
			_scaletoy = 0;
			if(_scalex <= 0 && _scaley <= 0){
				instance_destroy();
			}
		}
	} else {
		_amp = 0;
	}
}