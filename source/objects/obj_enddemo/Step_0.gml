{
	if(!_init){
		with(obj_music){
			global.music_bus.effects[0] = _ef_muffled;
		}
		_init = true;
	}
	
	_timer ++;
	switch(_act){
		case 0:
			if(_timer >= 90){
				_timer = 0;
				_act = 1;
				_text1lerp = -512;
				_text2lerp = 28;
			}
		break;
		case 1:
			if(_timer >= 20){
				_act = 2;
				_cardlerp[0] = 338;
			}
		break;
		case 2:
			if(_timer >= 35){
				_act = 3;
				_cardlerp[1] = 638;
			}
		break;
		case 3:
			if(_timer >= 50){
				_timer = 0;
				_act = 4;
				_cardlerp[2] = 938;
			}
		break;
		case 4:
			if(_timer >= 100){
				_timer = 0;
				_act = 5;
				_confirmexit = true;
			}
		break;
	}
	_text1pos = lerp(_text1pos, _text1lerp, 0.12);
	_text2pos = lerp(_text2pos, _text2lerp, 0.12);
	
	for(var i = 0; i < 3; i++){
		_cardpos[i] = lerp(_cardpos[i], _cardlerp[i], 0.06);
	}
	
	if(_confirmexit && (check_keypress(global._input[global._inptype][? "confirm"], global._inptype) || check_keypress(global._input[global._inptype][? "menu_select"], global._inptype))){
		with(obj_music){
			global.music_bus.effects[0] = undefined;
		}
		audio_stop_all();
		global._loadState = "enddemo";
		room_goto(r_loading);
	}
}