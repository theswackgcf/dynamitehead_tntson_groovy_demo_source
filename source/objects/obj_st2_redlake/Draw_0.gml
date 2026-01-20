{
	if(_inview){
		draw_sprite_ext(sprite_index,_ind,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
		draw_sprite_ext(sprite_index,_indnext,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha*_alp);
	}
}