{
	scr_textrender_switchfont("dh_font4");
	scr_textrender_halign("center");
	scr_textrender_valign("middle");
	scr_textrender_type(floor(WIDTH/2), _text1pos, "THANKS FOR\nPLAYING");
	scr_textrender_halign("left");
	scr_textrender_valign("top");
	
	
	for(var i = 2; i >= 0; i--){
		draw_sprite(spr_enddemo_cards, i, _cardpos[i], 340);
	}
	for(var i = 0; i < 3; i++){
		scr_textrender_switchfont("dh_font2_big");
		scr_textrender_type(_cardpos[i]+_cardtext[i][1],516, _cardtext[i][0], true, global._menuColorYes);
	}
	scr_textrender_switchfont("dh_font4");
	scr_textrender_halign("center");
	scr_textrender_type(floor(WIDTH/2), _text2pos, "COMING SOON: NEW BOSSES");
	scr_textrender_halign("left");
	
	if(_confirmexit){
		scr_textrender_switchfont("dh_font2");
		scr_textrender_halign("right");
		if(scr_compareinput("confirm","menu_select")){
			scr_textrender_type(WIDTH-24, HEIGHT-55, "keycode@CONFIRMkeycode - Back to menu");
		} else {
			scr_textrender_type(WIDTH-24, HEIGHT-55, "keycode@MENU_SELECTkeycode / keycode@CONFIRMkeycode - Back to menu");
		}
		scr_textrender_halign("left");
	}
	scr_textrender_switchfont(global._defaultFont);
}