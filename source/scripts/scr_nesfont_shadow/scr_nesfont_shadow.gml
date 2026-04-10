function scr_nesfont_shadow(x, y, text, shadow = false, color = make_color_rgb(255,255,255), shadcolor = make_color_rgb(0,0,0), alpha = 1, scale_x = 1, scale_y = 1){
	scr_textrender_type(x+scale_x, y+scale_y, text, shadow, shadcolor, alpha, scale_x, scale_y);
	scr_textrender_type(x, y, text, shadow, color, alpha, scale_x, scale_y);
}