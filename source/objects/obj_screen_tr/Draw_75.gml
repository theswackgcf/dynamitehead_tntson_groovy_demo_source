{
	if(_type == "in" && _timer <= _starttime){
		global._doLoading = false;
		image_speed = 0;
		draw_set_color(#000000);
		draw_rectangle(-128, -128, WIDTH+global._screenSideOffset, HEIGHT+global._screenSideOffset, false)
		draw_set_color(#FFFFFF);
	}
	if(_show){
		if(global._buildver == WINDOWS){
			_dosurfacestuff = global._full;
		}
		
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
			
				if(global._buildver == WINDOWS){
					_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
					_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);	
				}
			
				_init = true;
			} else {
				if(global._buildver == WINDOWS){
					if(surface_exists(_gui_surface)){
						if(_dosurfacestuff){
							surface_set_target(_gui_surface);
		
							draw_clear_alpha(c_black, 0);
		
							gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
						}

						draw_sprite(sprite_index, image_index, 0, 0);

						if(_dosurfacestuff){
							scr_surface_fullscreen_resolution();
						}
					} else {
						_gui_size = [WIDTH,HEIGHT];
						_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
					}
				} else if(global._buildver == HTML){
					draw_sprite(sprite_index, image_index, 0, 0);
				}
			
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
	} else {
		if(global._buildver == WINDOWS){
			if(_gui_surface != 0){
				if(surface_exists(_gui_surface)){
					surface_free(_gui_surface);
				}
			}
			if(_resizegui_surface != 0){
				if(surface_exists(_resizegui_surface)){
					surface_free(_resizegui_surface);
				}
			}
		}
	}
}