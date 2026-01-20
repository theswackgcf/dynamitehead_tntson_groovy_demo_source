{
	if(!global._pause){
		if(_freeze <= 0){
			image_speed = 1;
			
			if(image_index >= image_number-1){
				image_index = image_number-1;
			}
		} else {
			_freeze -= 1;
			image_speed = 0;
		}
	} else {
		image_speed = 0;
	}
}