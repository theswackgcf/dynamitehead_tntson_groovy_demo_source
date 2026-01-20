{
	depth = 3000;
	
	if(!global._pause){
		image_speed = 1;
		
		if(image_index >= image_number-1){
			image_index = image_number-1;
		}
		
		_timer ++;
		if(_timer >= 160){
			image_alpha -= 0.06;
			if(image_alpha <= 0){
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}