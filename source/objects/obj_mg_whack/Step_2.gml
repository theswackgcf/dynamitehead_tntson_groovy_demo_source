{
	if(!global._pause){
		if(_cursorframe > 0){
			_cursorframe -= 0.3;
		} else {
			_cursorframe = 0;
		}
		if(_inptype == WHACK_INPUT_MOUSE){
			cursor_sprite = -1;
			
			if(mouse_check_button_pressed(mb_left)){
				_cursorframe = 2;
			}
		}
	}
}