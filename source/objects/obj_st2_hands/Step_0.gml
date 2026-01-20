{
	if(distance_to_point(global._cameraX+(WIDTH*0.5),global._cameraY+(HEIGHT*0.5)) <= WIDTH*2.1){
		_inview = true;
	} else {
		_inview = false;
	}
	
	if(!global._pause){
		image_speed = 0;
		
		if(_inview){
			image_speed = 1;
			_timer ++;
			image_angle = _startangle + (sin(_timer*_spd)*10);
		}
	} else {
		image_speed = 0;
	}
}