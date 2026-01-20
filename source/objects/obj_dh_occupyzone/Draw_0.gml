{
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	scr_textrender_type(x,y,string(_nocollide)+"\n"+string(_curenemyid));
}