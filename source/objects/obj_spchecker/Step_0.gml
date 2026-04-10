{
	_timer ++;
	
	if(sprite_exists(_curspr)){
		_allframes = sprite_get_info(_curspr).num_subimages;
		_curframe += 0.25;
	}
	
	if(_run){
		_timer ++;
		
		//advance sprites and frames
		if(!sprite_exists(_curspr)){
			_sprtime = 0;
			_curframe = 0;
			_curspr ++;
		} else {
			_sprtime ++;
			
			if(_curframe >= _allframes){
				_curframe = _allframes;
				if(_sprtime >= 8){
					_curspr ++;
					_curframe = 0;
					_sprtime = 0;
				}
			}
		}
	} else {
		if(_curframe >= _allframes){
			_curframe = 0;
		}
		
		if(keyboard_check(vk_left)){
			_curspr --;
			_curframe = 0;
			_sprtime = 0;
		} else if(keyboard_check(vk_right)){
			_curspr ++;
			_curframe = 0;
			_sprtime = 0;
		}
	}
	
	if(keyboard_check_pressed(vk_space)){
		_run = !_run;
	}
}