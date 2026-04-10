{
	depth = -11004;
	if(_visibtimer > 0){
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
		
		_visibtimer --;
	}
}