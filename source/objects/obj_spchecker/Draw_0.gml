{
	scr_textrender_valign("bottom");
	
	if(sprite_exists(_curspr)){
		var pos = [sprite_get_xoffset(_curspr), sprite_get_yoffset(_curspr)];
		var bbox = [
			sprite_get_info(_curspr).bbox_left,
			sprite_get_info(_curspr).bbox_top,
			sprite_get_info(_curspr).bbox_right,
			sprite_get_info(_curspr).bbox_bottom,
		];
		draw_set_alpha(0.5);
		draw_set_color(c_green);
		draw_rectangle(bbox[0],bbox[1],bbox[2],bbox[3],false);
		draw_set_color(c_white);
		draw_set_alpha(1);
		
		draw_sprite(_curspr, _curframe, pos[0], pos[1]);
	
		scr_textrender_switchfont("dh_font1");
		var runtext = "RUNNING/nPress spacebar to pause/play";
		if(!_run){
			runtext = "PAUSED/nPress spacebar to pause/play/nPress left / right to change sprite";
		}
		scr_textrender_type(0,HEIGHT,"Index: "+string(_curspr)+"\nSprite Name: "+sprite_get_name(_curspr)+"\nDimensions: "+string(sprite_get_width(_curspr))+"x"+string(sprite_get_height(_curspr))+"\n"+runtext);
		scr_textrender_switchfont(global._defaultFont);
	} else {
		scr_textrender_type(0,HEIGHT,"Index: "+string(_curspr));
	}
	
	scr_textrender_valign("top");
}