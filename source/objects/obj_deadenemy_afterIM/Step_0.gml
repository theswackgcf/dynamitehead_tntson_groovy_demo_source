{
	depth = -1990;
	
	if(!global._pause){
		image_speed = 1;
		
		_timer ++;
		if(_timer > 0){
			visible = true;
		} else {
			visible = false;
		}
		image_alpha = _alpha;
		image_blend = c_aqua;
		y += 2;
		_alpha -= 0.1;
		if(_alpha <= 0 || _timer >= 200){
			instance_destroy();
		}
	} else {
		image_speed = 0;
	}
}