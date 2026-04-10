{
	if(global._state == "debugminigames"){
		var yoffset = (0 - _curopt) * 48;
	
		scr_textrender_type(32, 16+yoffset, "oiled up minigame select", false, c_white);
	
		for(var i = 0; i < array_length(_minigames); i++){
			var col = c_white;
			if(_curopt == i){
				scr_textrender_type(32, 96+(i*48) + yoffset, "--- "+_minigames[i][1], false, col);
			} else {
				scr_textrender_type(32, 96+(i*48) + yoffset, _minigames[i][1], false, col);
			}
		}
	
		if(keyboard_check_pressed(vk_down)){
			_curopt ++;
			if(_curopt > array_length(_minigames)-1){
				_curopt = 0;
			}
		} else if(keyboard_check_pressed(vk_up)){
			_curopt --;
			if(_curopt < 0){
				_curopt = array_length(_minigames)-1;
			}
		}
	
		if(keyboard_check_pressed(vk_enter)){
			audio_stop_all();
			global._minigame = _minigames[_curopt][0];
			if(array_length(_minigames[_curopt]) >= 3){
				switch(_minigames[_curopt][2]){
					case LOAD.enum_lode_game:
						global._lode_editor = false;
						global._lode_playmode = true;
						global._lode_testmode = true;
						global._lode_testmode_load = false;
						
						global._lode_stage = 0;
					break;
					case LOAD.enum_lode_editor:
						global._lode_editor = true;
						global._lode_playmode = false;
						global._lode_testmode = false;
						global._lode_testmode_load = false;
					break;
				}
			}
			room_goto(r_minigames);
		}
	}
	
	if(global._state == "minigame" && global._minigame == ""){
		audio_stop_all();
		room_goto(r_debug_minigames);
	}
}