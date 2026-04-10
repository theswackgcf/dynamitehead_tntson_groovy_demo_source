{
	if(!global._pause){
		image_speed = 1;
		
		_timer ++;
		
		if(_timer >= 240 || image_index >= image_number-1){
			instance_destroy();
		}
	} else {
		image_speed = 0;
	}
}