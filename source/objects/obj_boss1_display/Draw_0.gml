{
	_shadowmult = clamp(0, 1-(_parentobj._height/HEIGHT), 1);
	if(!_parentobj._grabfall){
		if(_parentobj._startTimer <= 0){
			if(_parentobj._init){
				draw_sprite_ext(spr_shadow, 0, x+42, y, _parentobj._shadowsize*_shadowmult, _parentobj._shadowsize*_shadowmult, 0, $FFFFFF, 0.6);
				
				var drawY = y-_height;
				if(!_parentobj._begin){
					drawY = _parentobj._beginoffset + _offset[1];
				}
				draw_sprite_ext(sprite_index, image_index, x, drawY, image_xscale, image_yscale, image_angle, make_color_rgb(_parentobj._fadeCol[0],_parentobj._fadeCol[1],_parentobj._fadeCol[2]), image_alpha);
				//scr_textrender_type(x+96,y-96, "AI:"+string(_parentobj._ailevel)+"\n"+"STATE:"+string(_parentobj._state)+"\n"+"INT:"+string(_parentobj._plinterest));
			}
		}
	} else {
		draw_sprite_ext(spr_shadow, 0, x+42, y, _parentobj._shadowsize*_shadowmult, _parentobj._shadowsize*_shadowmult, 0, $FFFFFF, 0.6);

		draw_sprite_ext(sprite_index, image_index, x, y-_height, image_xscale, image_yscale, image_angle, make_color_rgb(_parentobj._fadeCol[0],_parentobj._fadeCol[1],_parentobj._fadeCol[2]), image_alpha);
	}
}