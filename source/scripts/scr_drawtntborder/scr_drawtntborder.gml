///function scr_drawtntborder(x, y, size_x, size_y)
function scr_drawtntborder(xx, yy, sizex, sizey){
	//draw the puller
	draw_sprite_ext(spr_tntborder_top, global._tntmenuframe, xx, yy-(sprite_get_height(spr_tntborder)*(sizey*0.5)), 1, 1, 0, c_white, 1);
	
	//draw tnt border
	draw_sprite_ext(spr_tntborder, global._tntbordertimer, xx, yy, sizex, sizey, 0, c_white, 1);
}