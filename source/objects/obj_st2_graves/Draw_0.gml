{
	if(global._kohit > 0){
		image_blend = c_black;
	} else {
		image_blend = _colfade;
	}
	gpu_set_texfilter(false);
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	gpu_set_texfilter(global._texfilter);
}