{
	if(global._kohit > 0){
		draw_set_color(#FF0000);
		draw_rectangle(global._cameraX-global._screenSideOffset,global._cameraY-global._screenSideOffset,global._cameraX+WIDTH+global._screenSideOffset,global._cameraY+HEIGHT+global._screenSideOffset, false);
		draw_set_color(#FFFFFF);
	}
}