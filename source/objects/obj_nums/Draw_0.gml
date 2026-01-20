{
	if(_init){
		draw_set_font(_fnt);
		draw_set_halign(fa_center);
		if(_drawback){
			draw_sprite_ext(spr_gui_numsback, 0, _boxx-(((_charw*string_length(_numstring))/2))+_addoffset, _boxy, string_length(_numstring)*0.9, 1, 0, c_black, 0.56);
		}
		for(var i = 0; i < string_length(_numstring); i++){
			draw_text_transformed_color(_nummap[? i][1]+_shakeoff[0], _nummap[? i][2]+_shakeoff[1], _nummap[? i][0], image_xscale, image_yscale, image_angle, _color, _color, _color, _color, 1);
		}
		draw_set_font(-1);
	}
}