{
	if(_init){
		draw_set_halign(fa_center);
		for(var i = array_length(_charw)-1; i >= 0; i--){
			draw_sprite_ext(spr_gui_checkpoint, _nummap[? i][0], _nummap[? i][1]+_shakeoff[0], _nummap[? i][2]+_shakeoff[1], image_xscale, image_yscale, image_angle, c_white, 1);
		}
	}
}