{
	if(_guimaker != noone){
		if(string_length(_text) == 0){
			if(_guimaker._show && _guimaker._showborder){
				draw_set_color(#00FF00);
				if(global._curobj == self.id){
					draw_set_color(#FFFF00);
				}
				draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
				draw_set_color(#FFFFFF);
			}
			if(sprite_exists(sprite_index)){
				draw_sprite(sprite_index, image_index, x, y);
			}
		} else {
			scr_textrender_switchfont(_font);
			if(_guimaker._show && _guimaker._showborder){
				draw_set_color(#00FF00);
				if(global._curobj == self.id){
					draw_set_color(#FFFF00);
				}
				var w = scr_textrender_width(_text);
				var h = scr_textrender_height(_text);
				
				var x1 = 0;
				var x2 = 0;
				var y1 = 0;
				var y2 = 0;
				
				switch(_halign){
					case "left":
						x1 = x;
						x2 = x+w;
					break;
					case "center":
						x1 = x-(w/2);
						x2 = x+(w/2);
					break;
					case "right":
						x1 = x-w;
						x2 = x;
					break;
				}
				
				switch(_valign){
					case "top":
						y1 = y;
						y2 = y+h;
					break;
					case "middle":
						y1 = y-(h/2);
						y2 = y+(h/2);
					break;
					case "bottom":
						y1 = y-h;
						y2 = y;
					break;
				}
				
				_text_bbox = [x1,y1,x2,y2];
				
				draw_rectangle(x1, y1, x2, y2, true);
				draw_set_color(#FFFFFF);
			}
			if(global._guitrailer){
				scr_textrender_wave_x(8, 4);
				scr_textrender_wave_y(8, 4);
			}
			scr_textrender_halign(_halign);
			scr_textrender_valign(_valign);
			scr_textrender_type(x, y, _text, false, #FFFFFF, 1, _scale[0], _scale[1]);
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_wave_x(0,0);
			scr_textrender_wave_y(0,0);
			scr_textrender_halign("left");
			scr_textrender_valign("top");
		}
		if(_guimaker._show && _guimaker._showborder){
			draw_text(x,y-16, string(depth));
		}
	}
}