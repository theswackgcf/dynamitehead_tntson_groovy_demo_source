{
	if(_parentobj != noone && instance_exists(_parentobj)){
		if(_parentobj._timer > 0){
			draw_sprite_ext(spr_boss1_shockwave_back, _parentobj._shframe, x, y, image_xscale, image_yscale, 0, #FFFFFF, image_alpha);
		}
	}
}