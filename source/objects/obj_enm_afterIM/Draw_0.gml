{
	if(_init){
		image_speed = 0;
		if(sprite_index != -1 && sprite_exists(sprite_index)){
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		}
	}
}