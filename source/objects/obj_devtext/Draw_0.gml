if(distance_to_object(obj_dh_mask) <= WIDTH*1.5){
	scr_textrender_switchfont(global._defaultFont);
	scr_textrender_halign("center");
	scr_textrender_valign("middle");

	scr_textrender_type(x, y, text);

	scr_textrender_halign("left");
	scr_textrender_valign("top");
}