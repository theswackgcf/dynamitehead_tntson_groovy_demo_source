{
	if(!global._pause){
		if(distance_to_point(global._cameraX+(WIDTH*0.5),global._cameraY+(HEIGHT*0.5)) <= WIDTH*2.1){
			_inview = true;
		} else {
			_inview = false;
		}
		
		if(_inview){
			_timer += 0.18;
			
			_alp += 0.01;
			if(_alp >= 1){
				_alp = 0;
				_ind ++;
				_indnext = _ind+1;
				if(_ind >= sprite_get_info(sprite_index).num_subimages-1){
					_indnext = 0;
				}
				if(_ind >= sprite_get_info(sprite_index).num_subimages){
					_ind = 0;
					_indnext = _ind+1;
				}
			}
		}
	}
}