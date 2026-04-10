{
	if(_drawloser > 0){
		_drawloserPos[0] += 4;
		_drawloserPos[1] -= 4;
			
		if(_drawloserPos[0] >= 0){
			_drawloserPos[0] = -412;
		}
		if(_drawloserPos[1] <= WIDTH+6){
			_drawloserPos[1] = WIDTH+700
		}
			
		if(_loseralpha < 1){
			_loseralpha += 0.07;
		}
		if(_loseralpha > 1){
			_loseralpha = 1;
		}
	}
	
	if(_drawloser == 2){
		if(!_retry){
			if(check_keypress(global._input[global._inptype][? "up"], global._inptype ) || check_keypress(global._input[global._inptype][? "menu_up"], global._inptype )){
				_loseOpt --;
				global._menubuttontimer = 0;
				if(_loseOpt < 0){
					_loseOpt = array_length(_loseOpts)-1;
				}
			} else if(check_keypress(global._input[global._inptype][? "down"], global._inptype ) || check_keypress(global._input[global._inptype][? "menu_down"], global._inptype )){
				_loseOpt ++;
				global._menubuttontimer = 0;
				if(_loseOpt > array_length(_loseOpts)-1){
					_loseOpt = 0;
				}
			} else if(check_keypress(global._input[global._inptype][? "confirm"], global._inptype ) || check_keypress(global._input[global._inptype][? "menu_select"], global._inptype )){
				switch(_loseOpt){
					case 0:
						mus_stop();
						sfx_play(snd_retry);
						_retrymenu = false;
						_retry = true;
					break;
					case 1:
						mus_stop();
						sfx_play(snd_retry);
						_retrymenu = true;
						_retry = true;
					break;
				}
			}
		}
	}
	
	if(_retry){
		_retrytimer ++;
		if(_retrytimer >= 100){
			if(!_retrymenu){
				var stages = [r_stage1, r_stage2];
				room_goto(stages[global._location]);
			} else {
				with(obj_music){
					global.music_bus.effects[0] = undefined;
				}
				audio_stop_all();
				global._loadState = "tomenu";
				room_goto(r_loading);
			}
		}
	}
}