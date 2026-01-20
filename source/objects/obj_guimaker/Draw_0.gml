{
	scr_textrender_halign("center");
	scr_textrender_valign("middle");
	var bg = layer_background_get_id(layer_get_id("Background"));
	if(_show){
		layer_background_blend(bg, #333333);
		scr_textrender_type(WIDTH/2, HEIGHT/2, "ESC: hide this   B: hide borders\nT: menu background\nSPACE: ADD NEW SPRITE\nBACKSPACE: ADD TEXT\nENTER: LOG\nUP: -DEPTH\nDOWN: +DEPTH\nDEL: DELETE\nCTRL+S: save gui\nCTRL+L: load gui");
	} else {
		layer_background_blend(bg, #000000);
	}
	scr_textrender_halign("left");
	scr_textrender_valign("top");

	if(_clipboard > 0){
		_clipboard --;
		scr_textrender_type(0, HEIGHT-48, "saved to clipboard");
	}
}