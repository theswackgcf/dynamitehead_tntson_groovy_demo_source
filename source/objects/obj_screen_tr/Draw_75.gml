{
	if(_type == "in" && _timer <= _starttime){
		global._doLoading = false;
		image_speed = 0;
		draw_set_color(#000000);
		draw_rectangle(-128, -128, WIDTH+global._screenSideOffset, HEIGHT+global._screenSideOffset, false)
		draw_set_color(#FFFFFF);
	}
	
	if(global._state == "minigame" && global._minigame == "lode"){
		if(_type == "in"){
			image_index = image_number-1;
		}
		visible = false;
	}
	
	if(_show){
		_timer ++;
		if(_timer > _starttime){
			image_speed = 1;
			if(!_init){
				image_index = 0;
			
				var spr;
				if(_type == "in"){
					spr = spr_screen_in;
				} else if(_type == "out"){
					spr = spr_screen_out;
				}
				sprite_index = spr;
				
				_init = true;
			} else {
				draw_sprite(sprite_index, image_index, 0, 0);
			
				if(_type == "out"){
					_timer = _starttime+1;
					visible = true;
				}
				if(image_index >= image_number-1){
					if(_type == "in"){
						global._doLoading = true;
						_init = false;
						_show = false;
					} else if(_type == "out"){
						if(_audiostop){
							audio_stop_all();
						}
						if(_exit){
							game_end();
						} else if(_restart){
							audio_stop_all();
							room_goto(room_first);
						} else {
							room_goto(_roomto);
						}
					}
				}
			}
		}
	}
}