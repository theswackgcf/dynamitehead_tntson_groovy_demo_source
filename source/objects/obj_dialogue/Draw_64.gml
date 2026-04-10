{
	depth = -9000;
	if(!global._stageentrance){
		if(_show){
			if(_diagstate > 0){
				//draw dialogue box
				draw_set_alpha(_diagfadereal);
				draw_sprite(sprite_index, image_index, _drawX,_drawY);
				draw_set_alpha(1);
			}
		
			switch(_diagstate){
				case 1:
					if(image_index >= image_number-1){
						scr_textrender_switchfont("dh_font1");
					}
				break;
				case 2:
					if(_noise <= 0){
						//draw text
						scr_textrender_halign("left");
						scr_textrender_switchfont("dh_font1");
						scr_textrender_type(_drawX-300, _drawY-56, _typetext, false, #FFFFFF, _diagfadereal);
						scr_textrender_switchfont("dh_font2");
						if(_canSkip && _curchar >= string_length(_curtext)+1){
							//draw confirm text
							scr_textrender_switchfont("dh_font2");
							scr_textrender_valign("middle");
							scr_textrender_type(_drawX-326, _drawY+110, "PRESS keycode@CONFIRMkeycode", true, #FFFFFF, _diagfadereal);
							scr_textrender_valign("top");
							scr_textrender_switchfont(global._defaultFont);
						}
				
						//draw dialogue head
						if(_curhead != -1){
							draw_sprite_ext(_curhead, _headframe, _drawX - 440, _drawY, _scaleX, _scaleY, -5+(sin(_sintimer/48)*2), #FFFFFF, _diagfadereal);
						}
					}
				break;
				case 3:
					sprite_index = spr_diag_popout;
					if(image_index >= image_number-1){
						_diagstate = 0;
					}
				break;
			}
	
			//static noise
			if(_noise > 0){
				draw_set_alpha(_diagfadereal);
				draw_sprite(spr_diag_noise, _noiseframe, _drawX,_drawY);
				draw_set_alpha(1);
			}
		}
	}
}