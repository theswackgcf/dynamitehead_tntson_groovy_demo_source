{
	depth = -6500;
	
	if(!global._pause){
		if(global._kohit <= 0){
			if(_draw){
				_timer ++;
				if(_timer >= 10){
					with(obj_stageentrance){
						_drawnorm = false;
					}
					_starscale += 0.18;
					_starrot += 6;
				}
				if(_timer >= 90){
					with(obj_stageentrance){
						instance_destroy();
					}
					if(surface_exists(_surface)){
						surface_free(_surface);
					}
					_draw = false;
				}
			}
		}
	}
}