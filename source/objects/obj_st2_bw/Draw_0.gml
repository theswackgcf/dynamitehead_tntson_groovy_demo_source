{
	if(global._debug && global._showHitbox){
		if(mask_index != -1){
			draw_sprite_ext(mask_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
		}
	}
	if(sprite_index != -1){
		draw_sprite_ext(sprite_index,image_index,x,y+_offsety-_height,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	}
}