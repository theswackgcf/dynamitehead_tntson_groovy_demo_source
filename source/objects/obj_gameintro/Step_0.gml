{
	if(round(_rare) == 59){
		_frame = 1;
	}
	
	_timer ++;
	if(_act < 3 && global._swackygames){
		_timer = 25;
		_act = 3;
	}
	switch(_act){
		case 0:
			if(_timer >= 8){
				_timer = 0;
				_act = 1;
			}
		break;
		case 1:
			sfx_play(snd_swackygames);
			_timer = 0;
			_act = 2;
		break;
		case 2:
			if(_timer >= 90){
				_timer = 0;
				_act = 3;
			}
		break;
		case 3:
			if(_timer >= 40){
				global._swackygames = true;
				sfx_play(snd_menuintro)
				_timer = 0;
				_act = 4;
			}
		break;
		case 4:
			_logoscale += 0.0003;
			if(!sfx_isplaying(snd_menuintro) || _timer >= 200){
				audio_stop_all();
				room_goto(r_menu);
			}
		break;
	}
	
	//skip
	if(check_keypress(global._input[global._inptype][? "confirm"], global._inptype)){
		global._swackygames = true;
		audio_stop_all();
		room_goto(r_menu);
	}
}