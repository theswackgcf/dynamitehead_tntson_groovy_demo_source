{
	if(round(_rare) == 59){
		_frame = 1;
	}
	
	_timer ++;
	if(_act < 3 && global._swackygames){
		_canskip = true;
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
			if(!global._swackygames){
				_load = instance_create_depth(0,0,0,obj_loading_new);
			}
			_timer = 0;
			_act = 2;
		break;
		case 2:
			if(_load != noone && instance_exists(_load)){
				if(_timer >= _timer_val && _load._loaded){
					if(mouse_check_button_pressed(mb_left)){
						_focus = true;
					}
					if(_focus){
						_canskip = true;
						instance_destroy(_load);
						_load = noone;
					
						_timer = 0;
						_act = 3;
					
						if(global._debug && !_gotodebugroom){
							var rmind = scr_loadvalue("string", "startuproom", "debug", "noone", "", true, true);
							if(!room_exists(asset_get_index(rmind))){
								roomto(r_menu);
							} else {
								roomto(asset_get_index(rmind));
							}
							_gotodebugroom = true;
						}
					}
				}
			}
		break;
		case 3:
			if(global._debug && !_gotodebugroom){
				var rmind = scr_loadvalue("string", "startuproom", "debug", "noone", "", true, true);
				if(room_exists(asset_get_index(rmind))){
					global._swackygames = true;
					roomto(asset_get_index(rmind));
				}
				_gotodebugroom = true;
			}
		
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
	if(_canskip && check_keypress(global._input[global._inptype][? "confirm"], global._inptype)){
		global._swackygames = true;
		audio_stop_all();
		room_goto(r_menu);
	}
}