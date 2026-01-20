{
	draw_sprite(spr_betatester, 0, 0, 0);
	
	scr_textrender_switchfont("dh_font2");
	scr_textrender_halign("right");
	scr_textrender_valign("bottom");
	scr_textrender_shake(4);

	scr_textrender_type(WIDTH-64,HEIGHT-64,"keycode@CONFIRMkeycode");

	scr_textrender_shake(0);
	scr_textrender_halign("left");
	scr_textrender_valign("top");
	scr_textrender_switchfont(global._defaultFont);
}