{
	scr_textrender_halign("left");
	scr_textrender_valign("top");
	
	if(global._state == "game"){
		if(global._flashbang > 0){
			draw_set_alpha(_flashalp);
			draw_rectangle(-global._screenSideOffset, -global._screenSideOffset, WIDTH+global._screenSideOffset, HEIGHT+global._screenSideOffset, false);
			draw_set_alpha(1);
		}
	}

	//gamepads
	if(global._padtime > 0){
		var text = "";
		if(global._padmsgtype == 0){
			text = "GAMEPAD CONNECTED";
		} else if(global._padmsgtype == 1){
			text = "GAMEPAD DISCONNECTED";
		}
		scr_textrender_switchfont("dh_font2");
		scr_textrender_halign("right");
		scr_textrender_valign("top");
		scr_textrender_type(WIDTH, 0, text, true, #FFFFFF, _gp_alp);
		scr_textrender_halign("left");
		scr_textrender_switchfont(global._defaultFont);
	}
}