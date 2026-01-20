{
	if(!is_array(global._binds[_curkey])){
		draw_sprite(spr_keybinds, _curkey, sprite_get_xoffset(spr_keybinds), sprite_get_yoffset(spr_keybinds));
	} else {
		draw_sprite(global._binds[_curkey][1], global._binds[_curkey][2], sprite_get_xoffset(global._binds[_curkey][1]), sprite_get_yoffset(global._binds[_curkey][1]));
	}
	
	scr_textrender_type(0, 100, "current key num: "+string(_curkey));
	
	if(!is_array(global._binds[_curkey])){
		scr_textrender_type(0, 148, "current key code: "+string(global._binds[_curkey]));
		scr_textrender_type(0, 196, "current key string: "+string(key_to_string(global._binds[_curkey])));
	} else {
		scr_textrender_type(0, 148, "current key code: "+string(global._binds[_curkey][0]));
		scr_textrender_type(0, 196, "current key string: "+string(key_to_string(global._binds[_curkey][0])));
	}
	
	scr_textrender_type(0, 250, "Press keycode>LEFTkeycode and keycode>RIGHTkeycode to navigate this\nkeycode>ESCAPEkeycode to close.");
	
	var sides = [12, 365, WIDTH-12, HEIGHT-12];
	draw_rectangle(sides[0],sides[1],sides[2],sides[3],true);
	scr_textrender_type(sides[0],sides[1],"TOPLEFT keycode>ENTERkeycode");
	scr_textrender_halign("center");
	scr_textrender_type(sides[0]+((sides[2]-sides[0])/2),sides[1],"TOPCENTER keycode>ENTERkeycode");
	scr_textrender_halign("right");
	scr_textrender_type(sides[2],sides[1],"TOPRIGHT keycode>ENTERkeycode");
	
	scr_textrender_valign("center");
	scr_textrender_halign("left");
	scr_textrender_type(sides[0],sides[1]+((sides[3]-sides[1])/2),"MIDLEFT keycode>ENTERkeycode");
	scr_textrender_halign("center");
	scr_textrender_type(sides[0]+((sides[2]-sides[0])/2),sides[1]+((sides[3]-sides[1])/2),"CENTER keycode>ENTERkeycode");
	scr_textrender_halign("right");
	scr_textrender_type(sides[2],sides[1]+((sides[3]-sides[1])/2),"MIDRIGHT keycode>ENTERkeycode");
	
	scr_textrender_valign("bottom");
	scr_textrender_halign("left");
	scr_textrender_type(sides[0],sides[3],"BOTLEFT keycode>ENTERkeycode");
	scr_textrender_halign("center");
	scr_textrender_type(sides[0]+((sides[2]-sides[0])/2),sides[3],"BOTCENTER keycode>ENTERkeycode");
	scr_textrender_halign("right");
	scr_textrender_type(sides[2],sides[3],"BOTRIGHT keycode>ENTERkeycode");
	
	scr_textrender_halign("left");
	scr_textrender_valign("top");
}