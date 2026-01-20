{
	depth = -11003;
	if(_optionsobj._show && string_length(_desc) > 0){
		if(global._buildver == WINDOWS){
			_dosurfacestuff = global._full;
		}
		if(global._buildver == HTML){
			_dosurfacestuff = false;
		}
		
		if(surface_exists(_gui_surface)){
			if(_dosurfacestuff){
				surface_set_target(_gui_surface);
		
				draw_clear_alpha(c_black, 0);
		
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
			}

			draw_sprite(spr_menu_desc, 0, 0, 0);
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			scr_textrender_switchfont("dh_font1");
		
			var text = scr_wordwrap(_desc, WIDTH-480, "\n", false);
		
			scr_textrender_type(floor(WIDTH/2), HEIGHT-48, text, false, c_white, 1, 0.85,0.85);
		
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_halign("left");
			scr_textrender_valign("top");

			if(_dosurfacestuff){
				scr_surface_fullscreen_resolution();
			}
		} else {
			_gui_size = [WIDTH,HEIGHT];
			_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
		}
	} else {
		if(surface_exists(_gui_surface)){
			surface_free(_gui_surface);
		}
		if(surface_exists(_resizegui_surface)){
			surface_free(_resizegui_surface);
		}
	}
}