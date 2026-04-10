function minigame_lose_step(scoreval){
	_over_time ++;
	switch(_over_act){
		case 0:
			//slow down music
			_mus_spd -= 0.006;
					
			if(_over_time >= 170){
				sfx_play(snd_mg_lose);
							
				_over_time = 0;
				_over_act = 1;
				global._gameover_stopall = true;
				mus_fade(0, 1800);
			}
		break;
		case 1:
			if(_over_time >= 60){
				_over_time = 0;
				_over_act = 2;
			}
		break;
		case 2:
			//counting up
			if(_over_time >= 40){
				_lose_score_prev = _lose_score;
				_lose_score = lerp(_lose_score, scoreval, 0.04);
					
				if(floor(_lose_score) <> floor(_lose_score_prev) && _score_cd <= 0){
					sfx_stop(snd_mg_score);
					sfx_play(snd_mg_score);
					_score_cd = 4;
				}
					
				if(_score_cd > 0){
					_score_cd --;
				}
			}
				
			if(ceil(_lose_score) >= scoreval){
				if(!_sndscore && _wait >= 26){
					if(scoreval > 0){
						sfx_stop(snd_mg_score);
						sfx_play(snd_mg_score);
					}
					
					_sndscore = true;
				}
				_wait ++;
				if(_wait >= 110){
					//get monyx
					var snd = snd_mg_result1;
					if(_earned >= 250){
						snd = snd_mg_result2;
					}
					if(_earned >= 1000){
						snd = snd_mg_result3;
					}
					if(_earned >= 5000){
						snd = snd_mg_result4;
					}
					if(_earned >= 10000){
						snd = snd_mg_result5;
					}
						
					sfx_play(snd);
						
					_over_time = 0;
					_over_act = 3;
				}
			}
		break;
		case 3:
			//final earned amount
			if(_over_time >= 80){
				_over_time = 0;
				_over_act = 4;
			}
		break;
		case 4:
			//leaving
			if(!_over_exit){
				var canmouse = false;
				if(global._menumouse || global._buildver == HTML){
					canmouse = true;
				}
				if(global._minigame == "lode"){
					canmouse = false;
				}
				
				if(check_keypress(global._input[global._inptype][? "confirm"],global._inptype) || check_keypress(global._input[global._inptype][? "menu_select"],global._inptype) || (canmouse && mouse_check_button_pressed(mb_left))){							
					sfx_play(snd_comic_advance);
					mus_stop();
					with(obj_screen_tr){
						_show = true;
						_type = "out";
						global._loadState = "tomenu";
						_roomto = r_loading;
					}
						
					global._menuminigame = true;
						
					_over_exit = true;
				}
			}
		break;
	}
	
	_lose_score_string = string_pad(round(_lose_score), "0", 7);
}