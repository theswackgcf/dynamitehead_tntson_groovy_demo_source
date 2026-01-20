{
	if(!_gone){
		if(_fuse){
			draw_sprite_ext(spr_itembox_fuse, floor(_frame), x, y-_height, image_xscale*_scale, image_yscale*_scale, image_angle, image_blend, image_alpha);
		} else {
			draw_sprite_ext(sprite_index, 0, x, y-_height, image_xscale*_scale, image_yscale*_scale, image_angle, image_blend, image_alpha);
		}
	}
}