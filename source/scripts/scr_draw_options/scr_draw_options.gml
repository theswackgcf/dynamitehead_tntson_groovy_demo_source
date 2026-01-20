function scr_draw_options(){
	draw_set_color(c_black);
	draw_rectangle(-128, -128, WIDTH+128, HEIGHT+128, false);
	draw_set_color(c_white);
	draw_sprite_ext(spr_menu_settingbg, global._screenOffsetY, global._screenOffsetY, 0, 1, 1, 0, c_white, 1);
	if(_state == "main"){
		scr_drawtntborder(floor(WIDTH/2)+global._screenOffsetX,(floor(HEIGHT/2)+global._screenOffsetY)+40, 1.85, 1.37);
	}
	scr_textrender_switchfont("dh_font1");
	if(!_getinput){
		if(_state != "main"){
			draw_sprite(spr_menu_settingsart, _statenum-1, global._screenOffsetX, global._screenOffsetY);
		}
		if(scr_compareinput("pause","menu_back")){
			scr_textrender_type(24+global._screenOffsetX, 24+global._screenOffsetY, "keycode@PAUSEkeycode - Back");
		} else {
			scr_textrender_type(24+global._screenOffsetX, 24+global._screenOffsetY, "keycode@MENU_BACKkeycode / keycode@PAUSEkeycode - Back");
		}
	} else {
		switch(global._inptype){
			case 0:
				if(!global._padfound){
					scr_textrender_type(24+global._screenOffsetX, 24+global._screenOffsetY, "keycode>DELETEkeycode - Back");
				} else {
					scr_textrender_type(24+global._screenOffsetX, 24+global._screenOffsetY, "keycode>DELETEkeycode / keycode>SELECTkeycode - Back");
				}
			break;
			case 1:
				scr_textrender_type(24+global._screenOffsetX, 24+global._screenOffsetY, "keycode>SELECTkeycode - Back");
			break;
		}
	}
	scr_textrender_switchfont(global._defaultFont);
		
	if(_getinput){
		scr_textrender_shake(0);
		scr_textrender_halign("center");
		scr_textrender_valign("middle");
		scr_textrender_switchfont("dh_font2_big");
		scr_textrender_type(floor(WIDTH/2),floor(HEIGHT/2),"Setting input for: "+_getinputkey[1]+"\n\nkeycode@"+_getinputkey[0]+"\n\nPress any key ...");
		if(_inputassigned > 0){
			_inputassigned --;
			scr_textrender_switchfont("dh_font2");
			scr_textrender_shake(3);
			scr_textrender_type(floor(WIDTH/2),floor(HEIGHT/2)+290,"That key has already\nbeen assigned");
			scr_textrender_shake(0);
		}
		scr_textrender_switchfont(global._defaultFont);
		scr_textrender_halign("left");
		scr_textrender_valign("top");
	} else {
		if(_state != "main"){
			if(_scrheight > 0){
				with(obj_opt_scrollbar){
					_visibtimer = 2;
				}
			}
		}
	}
}