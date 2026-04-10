{
	depth = -11003;
	if(_optionsobj._state == "main"){
		_desc = "";
	}
	if(_optionsobj._show && string_length(_desc) > 0){
		draw_sprite(spr_menu_desc, 0, 0, 0);
		scr_textrender_halign("center");
		scr_textrender_valign("middle");
		scr_textrender_switchfont("dh_font1");
		
		var text = scr_wordwrap(_desc, WIDTH-480, "\n", false);
		
		scr_textrender_type(floor(WIDTH/2), HEIGHT-48, text, false, c_white, 1, 0.85,0.85);
		
		scr_textrender_switchfont(global._defaultFont);
		scr_textrender_halign("left");
		scr_textrender_valign("top");
	}
}