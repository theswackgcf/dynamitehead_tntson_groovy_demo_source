///function scr_mousehover(x1, y1, x2, y2, [screen], [zoom]);
function scr_mousehover(x1,y1,x2,y2,screen = false, zoomval = global._cameraZoom){
	var mousepos = [0,0];
	if(!screen){
		mousepos = [mouse_x, mouse_y];
	} else {
		if(global._cameraZoom <> 0){
			mousepos = [(mouse_x-camera_get_view_x(global._camera))/global._cameraZoom, (mouse_y-camera_get_view_y(global._camera))/global._cameraZoom];
		}
		if(global._buildver == HTML){
			mousepos = [window_mouse_get_x(), window_mouse_get_y()];
		}
	}
	if(screen){
		zoomval = 1;
	}

	if(mousepos[0] >= x1*zoomval && mousepos[1] >= y1*zoomval && mousepos[0] <= x2*zoomval && mousepos[1] <= y2*zoomval){
		return true;
	} else {
		return false;
	}
}