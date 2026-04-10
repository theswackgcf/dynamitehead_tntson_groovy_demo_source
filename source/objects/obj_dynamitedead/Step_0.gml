{
	global.music_bus.effects[0] = undefined;
	
	if(!_init){
		sfx_play(snd_dead);
		_init = true;
	}
	
	if(!_colorsinit){
		if(global._tutorial){
			_rep = "st0";
		} else {
			_rep = "st"+string(global._location+1);
		}
		makecolors("def",_rep);
		
		_colorsinit = true;
	}
	
	x = lerp(x, _posTo[0]+(obj_lost._loseOpt*10), 0.05);
	y = lerp(y, _posTo[1], 0.05);
	_scaleTo = lerp(_scaleTo, clamp(1-obj_lost._loseOpt, 0.9, 1), 0.035);
	
	if(image_index >= image_number-1){
		image_index = image_number-3;
		if(_act == 0){
			_act = 1;
		}
	}
	if(image_index >= 14 && !_snd[0]){
		_bgwhite = true;
		
		global._pad_vibrate = 5;
		
		sfx_play(snd_explosion);
		_snd[0] = true;
	}
	if(image_index >= 19 && !_snd[1]){
		global._pad_vibrate = 2;
		
		sfx_play(snd_slimesplat);
		_snd[1] = true;
	}
	
	if(_act > 0){
		_timer ++;
	}
	
	if(_bgwhite && _bgalp > 0){
		_bgalp -= 0.14;
	}
	if(_bgalp <= 0){
		_bgalp = 0;
		_drawbg = false;
	}
	
	switch(_act){
		case 1:
			if(_timer > 40){
				with(obj_music){
					mus_play(mus_gameover);
				}
				with(obj_lost){
					_drawloserPos = [0-scr_textrender_width(_losertext),WIDTH+scr_textrender_width(_losertext)];
					_drawloser = 1;
				}
				instance_create_depth(0, 0, 99, obj_face);
				if(global._playerDir == "l"){
					_posTo = [(WIDTH/2)+145,(HEIGHT/2)+70];
				} else {
					_posTo = [(WIDTH/2)-150,(HEIGHT/2)+70];
				}
				_act = 2;
				_timer = 0;
			}
		break;
		case 2:
			if(_timer > 100){
				with(obj_lost){
					_drawloser = 2;
				}
				_act = 3;
				_timer = 0;
			}
		break;
	}
}