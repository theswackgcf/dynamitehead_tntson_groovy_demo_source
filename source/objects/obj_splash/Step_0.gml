{
	if(!global._pause){
		depth = -5001;
		
		image_speed = 1;
		_timer ++;
		if(_timer >= 40){
			image_alpha -= 0.03;
			if(image_alpha <= 0){
				instance_destroy();
			}
		}
		image_xscale = 1 + sin(_timer/16)*_amp;
		image_yscale = 1 + cos(_timer/16)*_amp;
		_amp = lerp(_amp, 0, 0.07);
		_amp2 = lerp(_amp2, 120, 0.03);
		x = _startx + sin(_timer/12)*_amp2;
		y -= 8;
		
		if(y <= global._cameraY - 256){
			instance_destroy();
		}
	} else {
		image_speed = 0;
	}
}