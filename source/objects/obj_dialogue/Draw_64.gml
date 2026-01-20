{
	depth = -9000;
	if(!global._stageentrance){
		if(_show){
			if(global._buildver == WINDOWS){
				_dosurfacestuff = global._full;
			}
			if(global._buildver == HTML){
				_dosurfacestuff = false;
			}
	
			if(global._buildver == WINDOWS){
				if(surface_exists(_gui_surface)){
					if(_dosurfacestuff){
						surface_set_target(_gui_surface);
		
						draw_clear_alpha(c_black, 0);
		
						gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					}
			
					draw_gui();
			
					if(_dosurfacestuff){
						scr_surface_fullscreen_resolution();
					}
				} else {
					_gui_size = [WIDTH,HEIGHT];
					_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
				}
			}
			
			if(global._buildver == HTML){
				draw_gui();
			}
		}
	}
}