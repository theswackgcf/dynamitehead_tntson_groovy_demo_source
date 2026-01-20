{
	depth = -11004;
	if(_visibtimer > 0){
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

			//draw scrollbar
			draw_sprite_ext(spr_gui_scroll_bg, 0, WIDTH, _scrolloffs, 1, 3.55, 0, #FFFFFF, 0.6);
			draw_sprite_ext(spr_gui_scroll_arw, _upselect, WIDTH, 0, 1, 1, 0, #FFFFFF, 1);
			var pos = 0;
			if(!_drag){
				pos = _scrolloffs+_totaloffset;
			} else {
				pos = _scrolloffs+_dragpos;
			}
			draw_sprite_ext(spr_gui_scroll_arw, _downselect, WIDTH, HEIGHT, 1, -1, 0, #FFFFFF, 1);
			
			var sprite = spr_gui_scroll;
			if(_scrollselect == 1){
				sprite = spr_gui_scroll_select;
			}
			draw_sprite(sprite, _dir, WIDTH, pos);

			if(_dosurfacestuff){
				scr_surface_fullscreen_resolution();
			}
		} else {
			_gui_size = [WIDTH,HEIGHT];
			_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
		}
		
		_visibtimer --;
	}
}