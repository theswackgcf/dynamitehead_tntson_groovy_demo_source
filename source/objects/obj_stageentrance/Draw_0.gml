{
	if(_drawnorm){
		if(global._buildver != HTML){
			draw_set_color(#000000);
			draw_rectangle(global._cameraX-global._screenSideOffset,global._cameraY-global._screenSideOffset,global._cameraX+WIDTH+global._screenSideOffset,global._cameraY+HEIGHT+global._screenSideOffset, false);
			draw_set_color(#FFFFFF);
		} else {
			_drawnorm_alp -= 0.01;
			draw_set_alpha(clamp(_drawnorm_alp, 0, 1));
			draw_set_color(#000000);
			draw_rectangle(global._cameraX-global._screenSideOffset,global._cameraY-global._screenSideOffset,global._cameraX+WIDTH+global._screenSideOffset,global._cameraY+HEIGHT+global._screenSideOffset, false);
			draw_set_color(#FFFFFF);
			draw_set_alpha(1);
		}
	}
}