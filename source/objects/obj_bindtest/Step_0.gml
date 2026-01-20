{
	if(keyboard_check_pressed(vk_left)){
		_curkey --;
		if(_curkey < 0){
			_curkey = 0;
		}
	} else if(keyboard_check_pressed(vk_right)){
		_curkey ++;
		if(_curkey >= array_length(global._binds)){
			_curkey = array_length(global._binds)-1;
		}
	}
	if(keyboard_check_pressed(vk_escape)){
		game_end();
	}
}