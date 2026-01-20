{
	draw_sprite_ext(spr_shadow, 0, x, y, global._defShadowSize, global._defShadowSize, 0, c_white, 0.4);
	draw_sprite(sprite_index, image_index, x, y-_height);
}