{
	scr_textrender_shake(0);
	
	switch(_menustate){
		case "main":
			with(obj_menudh){
				visible = true;
			}
			with(obj_menulogo){
				visible = true;
			}
			
			scr_textrender_halign("right");
			scr_textrender_valign("bottom");
			scr_textrender_switchfont("dh_font2");
	
			scr_textrender_type(WIDTH-16, HEIGHT-16, "swackygames - 2026", true);
	
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_halign("top");
			scr_textrender_valign("left");
		break;
		case "setting":
			with(obj_menudh){
				visible = false;
			}
			with(obj_menubtn){
				visible = false;
			}
			with(obj_menulogo){
				visible = false;
			}
		break;
		case "credits":
			with(obj_menudh){
				visible = false;
			}
			with(obj_menubtn){
				visible = false;
			}
			with(obj_menulogo){
				visible = false;
			}
			draw_sprite(spr_menu_settingbg, 0, 0, 0);
		
			scr_textrender_halign("top");
			scr_textrender_valign("left");
			scr_textrender_switchfont("dh_font2");
			
			if(scr_compareinput("pause","menu_back")){
				scr_textrender_type(24, 24, "keycode@PAUSEkeycode - Back");
			} else {
				scr_textrender_type(24, 24, "keycode@MENU_BACKkeycode / keycode@PAUSEkeycode - Back");
			}
		
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
	
			scr_textrender_shake(3);
			if(_curopt[1] > 0){
				scr_textrender_type(320-_credits_arowoffs, floor(HEIGHT/2), "keycode@LEFTkeycode");
			}
			if(_curopt[1] < array_length(_creditsinfo)-1){
				scr_textrender_type(WIDTH-320+_credits_arowoffs, floor(HEIGHT/2), "keycode@RIGHTkeycode");
			}
			scr_textrender_shake(0);
	
			for(var i = 0; i < array_length(_creditsinfo); i++){
				if(_creditsinfo[i][1] != ""){
					scr_textrender_valign("top");
					draw_sprite_ext(_creditsinfo[i][1], _creditsframe, floor(WIDTH/2)+_creditsoffset[i]+_creditscuroffset, floor(HEIGHT/2)+100, 0.65, 0.65, 0, #FFFFFF, 1);
					scr_textrender_switchfont("dh_font1");
					scr_textrender_type(floor(WIDTH/2)+_creditsoffset[i]+_creditscuroffset, floor(HEIGHT/2)+145, _creditsinfo[i][2]);
				} else {
					scr_textrender_valign("middle");
					scr_textrender_switchfont("dh_font1");
					scr_textrender_type(floor(WIDTH/2)+_creditsoffset[i]+_creditscuroffset, floor(HEIGHT/2), _creditsinfo[i][2]);
				}	
				scr_textrender_switchfont("dh_font2_big");
				scr_textrender_type(floor(WIDTH/2)+_creditsoffset[i]+_creditscuroffset, 64, _creditsinfo[i][0]);
			}
	
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_valign("top");
			scr_textrender_valign("left");
		break;
	}
}