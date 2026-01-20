{	
	if(global._buildver == WINDOWS){
		_dosurfacestuff = global._full;
	}
	if(global._buildver == HTML){
		_dosurfacestuff = false;
	}
	
	if(_start && _act >= 2){		
		if(surface_exists(_gui_surface)){
			if(_dosurfacestuff){
				surface_set_target(_gui_surface);
		
				draw_clear_alpha(c_black, 0);
		
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
			}
			
			//draw screen
			if(global._buildver == WINDOWS){
				scr_textrender_switchfont("dh_font4_big");
			} else if(global._buildver == HTML){
				scr_textrender_switchfont("dh_font4");
			}
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			
			if(!global._pause){
				scr_textrender_shake(10+_addamp, _addamp);
			}
			
			if(global._buildver == WINDOWS){
				scr_textrender_type(_bosspos[0],_bosspos[1],_bossname,true,c_white,1,0.78,0.78);
			} else if(global._buildver == HTML){
				scr_textrender_type(_bosspos[0],_bosspos[1],_bossname,true,c_white,1,1.54,1.54);
			}
			scr_textrender_shake(0);
			
			scr_textrender_halign("left");
			scr_textrender_valign("top");
			scr_textrender_switchfont(global._defaultFont);
			
			if(_dosurfacestuff){
				scr_surface_fullscreen_resolution();
			}
		} else {
			_gui_size = [WIDTH,HEIGHT];
			_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
		}
	}
}