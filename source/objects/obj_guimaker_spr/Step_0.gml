{
	if(!mouse_check_button(mb_left)){
		_offset = [x - mouse_x, y - mouse_y];
		_drag = false;
	}
	if(_drag){
		x = mouse_x+_offset[0];
		y = mouse_y+_offset[1];
	}
	if(string_length(_text) == 0){
		if(scr_mousehover(bbox_left, bbox_top, bbox_right, bbox_bottom) && mouse_check_button_pressed(mb_left)){
			if(global._dragobj == noone){
				_drag = true;
				global._curobj = self.id;
				global._dragobj = self.id;
				global._dragdepth = depth;
			}
			if(global._dragobj != noone && global._dragdepth > depth){
				with(obj_guimaker_spr){
					_drag = false;
				}
				_drag = true;
				global._curobj = self.id;
				global._dragobj = self.id;
				global._dragdepth = depth;
			}
		}
	} else {
		scr_textrender_switchfont(_font);
		if(scr_mousehover(_text_bbox[0], _text_bbox[1], _text_bbox[2], _text_bbox[3]) && mouse_check_button_pressed(mb_left)){
			if(global._dragobj == noone){
				_drag = true;
				global._curobj = self.id;
				global._dragobj = self.id;
			}
			if(global._dragobj != noone && global._dragdepth > depth){
				with(obj_guimaker_spr){
					_drag = false;
				}
				_drag = true;
				global._curobj = self.id;
				global._dragobj = self.id;
				global._dragdepth = depth;
			}
		}
		scr_textrender_switchfont(global._defaultFont);
	}
}