{
	if(!global._pause){
		image_speed = 1;
		
		depth = 9980;
		
		if(_amp > 0){
			_amp --;
		}
		x = _startx + sin(random(480))*_amp;
		
		_timer ++;
		if(_timer >= 60){
			_alp -= 0.034;
			if(_alp <= 0){
				instance_destroy();
			}
		}
		image_alpha = _alp;
	} else {
		image_speed = 0;
	}
}