{	
	depth = -2000;
	
	if(!global._pause){
		image_speed = 1;
		
		if(!_init){
			sfx_play_proximity(snd_ghost);
			_init = true;
		}
		
		_intimer ++;
		if(_intimer > 1){
			visible = true;
			y -= 8;
			x = _startx + (sin(_intimer/14)*90);
			if(x < xprevious){
				image_xscale = -global._scale;
			} else {
				image_xscale = global._scale;
			}
			image_yscale = global._scale;
			
			image_alpha = _alpha;
			_alpha -= 0.01;
			
			if(y <= -128 || _alpha <= 0){
				instance_destroy();
			}
		} else {
			visible = false;
		}
	} else {
		image_speed = 0;
	}
}