{
	depth = -32;
	
	var shadoffset = 4;
	var logo1pos = [_logooffsetx,HEIGHT-110];
	draw_sprite_ext(spr_menulogo, 0, logo1pos[0]+shadoffset, logo1pos[1]+shadoffset, _logoscale[0], _logoscale[0], 0, #000000, 1);
	draw_sprite_ext(spr_menulogo, 0, logo1pos[0], logo1pos[1], _logoscale[0], _logoscale[0], 0, #FFFFFF, 1);
	var logo2pos = [(_logooffsetx+(_logosizex*_logoscale[0])-64)+_offsetdemo,HEIGHT-128];
	draw_sprite_ext(spr_menulogo, 1, logo2pos[0]+shadoffset, logo2pos[1]+shadoffset, _logoscale[1], _logoscale[1], 0, #000000, 1);
	draw_sprite_ext(spr_menulogo, 1, logo2pos[0], logo2pos[1], _logoscale[1], _logoscale[1], 0, #FFFFFF, 1);
	scr_textrender_valign("bottom");
	scr_textrender_halign("right");
	scr_textrender_switchfont("dh_font2");
	scr_textrender_type((_logooffsetx+(_logosizex*_logoscale[0])+84)+_offsetdemo, HEIGHT-12, string_upper(global._version), true, #FFAF23);
	scr_textrender_switchfont(global._defaultFont);
	scr_textrender_valign("top");
	scr_textrender_halign("left");
}