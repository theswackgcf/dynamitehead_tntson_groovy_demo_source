{
	_timer ++;
	if(_timer >= 16){
		_lerpspacing = lerp(_lerpspacing, 0, 0.17);
	}
	global._addSpacing = _lerpspacing;
	scr_textrender_halign("center");
	scr_textrender_halign("middle");
	scr_textrender_switchfont("dh_font4");
	scr_textrender_type(WIDTH/2, (HEIGHT/2)-160, "NexT LocAtIoN:\n"+global._locations[global._location], true);
	scr_textrender_switchfont(global._defaultFont);
	scr_textrender_halign("left");
	scr_textrender_halign("top");
	global._addSpacing = 0;
}