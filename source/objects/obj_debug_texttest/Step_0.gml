{
	_timer ++;
	if(keyboard_check_pressed(vk_left)){
		_page -= 1;
		if(_page < 0){
			_page = 0;
		}
	} else if(keyboard_check_pressed(vk_right)){
		_page += 1;
	}
	
	if(_page == 7){
		//typewriter effect
		if(_curchar < string_length(_curtext)+1){
			var text_typewrite = scr_textrender_typewrite(_curtext, _typetext, _curchar, _keysArray);
			_typetext = text_typewrite[0];
			_curchar = text_typewrite[1];
		}
	}
	
	if(_page == 4){
		if(keyboard_check_pressed(vk_down)){
			_textval ++;
			if(_textval > 2){
				_textval = 0;
			}
		} else if(keyboard_check_pressed(vk_up)){
			_textval --;
			if(_textval < 0){
				_textval = 2;
			}
		}
		var rang = random_range(3,8);
		var wav = [4+(sin(_timer/30)*8), 1.2];
		switch(_textval){
			case 0:
				_shakeval = [rang,0];
				_waveval = [wav,[0,0]];
			break;
			case 1:
				_shakeval = [0,rang];
				_waveval = [[0,0],wav];
			break;
			case 2:
				_shakeval = [rang,rang];
				_waveval = [wav,wav];
			break;
		}
	} else {
		_shakeval = [0,0];
		_waveval = [[0,0],[0,0]];
	}
}