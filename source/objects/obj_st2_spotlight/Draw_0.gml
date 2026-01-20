{
	depth = -9000;
	draw_set_color(c_black);
	draw_set_alpha(0.56*_alpha);
	draw_rectangle(global._cameraX-global._screenSideOffset,global._cameraY-global._screenSideOffset,global._cameraX+WIDTH+global._screenSideOffset,global._cameraY+HEIGHT+global._screenSideOffset,false);
	draw_set_alpha(1*_alpha);
	draw_sprite(spr_st2_spotlight, _spotframe, x, y);
	draw_set_alpha(1);
	draw_set_color(c_white);
}