{
	global._addSpacing = _lerpspacing;
	scr_textrender_halign("center");
	scr_textrender_halign("middle");
	scr_textrender_switchfont("dh_font4");
	var pos = [WIDTH/2, (HEIGHT/2)-160];
	var text = "NexT LocAtIoN :\n"+global._locations[global._location];
	scr_textrender_type(pos[0]+8, pos[1]+8, text, true, c_black);
	scr_textrender_type(pos[0], pos[1], text, true);
	scr_textrender_switchfont(global._defaultFont);
	scr_textrender_halign("left");
	scr_textrender_halign("top");
	global._addSpacing = 0;
}