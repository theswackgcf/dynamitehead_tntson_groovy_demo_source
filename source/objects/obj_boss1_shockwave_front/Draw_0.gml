{
	if(_timer > 0){
		draw_sprite_ext(spr_boss1_shockwave_front, _shframe, x, y, image_xscale, image_yscale+(sin(_timer)*0.2), 0, #FFFFFF, _alp);
		if(global._debug){
			if(global._showHitbox){
				draw_sprite_ext(spr_boss1_shockwave_mask, _shframe, x, y, image_xscale, image_yscale+(sin(_timer)*0.2), 0, #FFFFFF, 1);
			}
		}
	}
}