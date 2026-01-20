{
	if(_active){
		_colorblend = c_white;
		if(global._kohit > 0){
			_colorblend = c_black;
		}
	
		if(_freeze <= 0){
			draw_sprite_ext(sprite_index, _boneframe, x, y-_height, image_xscale, image_yscale, image_angle, _colorblend, image_alpha);
		}
	}
}