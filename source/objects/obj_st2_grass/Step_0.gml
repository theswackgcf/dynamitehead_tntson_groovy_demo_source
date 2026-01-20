{
	if(!global._pause){
		image_speed = 1;
		
		if(distance_to_point(global._cameraX+(WIDTH*0.5),global._cameraY+(HEIGHT*0.5)) <= WIDTH*2.1){
			_inview = true;
		} else {
			_inview = false;
		}
		
		if(_inview){
			//wind effect
			_timer ++;
		
			_windoffset[0] = sin(_timer*_windSpd)*_windAmp;
			_windoffset[1] = cos((_timer+99)*_windSpd)*(_windAmp*0.5);
		
			_windAmp = 3+(sin(((_timer*0.3)*_windSpd))*10);
		} else {
			if(surface_exists(_surf)){
				surface_free(_surf);
			}
		}
		
		if(global._kohit > 0){
			image_blend = c_black;
		} else {
			image_blend = _colfade;
		}
	} else {
		image_speed = 0;
	}
}