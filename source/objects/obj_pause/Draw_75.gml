{
	if(global._pause){
		if(global._buildver == WINDOWS){
			_dosurfacestuff = global._full;
		}
		if(global._buildver == HTML){
			_dosurfacestuff = false;
		}
		
		if(!global._debughidepause){
			if(global._buildver == WINDOWS){
				if(surface_exists(_gui_surface)){
					if(_dosurfacestuff){
						surface_set_target(_gui_surface);
		
						draw_clear_alpha(c_black, 0);
						
						gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					}
		
					scr_draw_pause();

					if(_dosurfacestuff){
						scr_surface_fullscreen_resolution();
					}
				} else {
					_gui_size = [WIDTH,HEIGHT];
					_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
				}
			}
			
			if(global._buildver == HTML){
				scr_draw_pause();
			}
		}
	} else {
		_pauseTimer = 0;
		for(var i = 0; i < ds_map_size(_pauseLetters); i++){
			_pauseLetters[? i][1] = 0;
			_pauseLetters[? i][2] = 0;
			_pauseLetters[? i][3] = random(512);
		}
	}
}