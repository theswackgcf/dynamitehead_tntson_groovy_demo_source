///function scr_colliderect(x1, y1, x2, y2, screen);
function scr_colliderect(x1,y1,x2,y2, screen = false){
	//collide erect
	var addX = 0;
	var addY = 0;
	var multipl = 1;
	if(screen){
		addX = -global._cameraX;
		addY = -global._cameraY;
		multipl = global._defCamZoom;
	}
	if(x+addX >= x1*multipl && y+addY >= y1*multipl && x+addX <= x2*multipl && y+addY <= y2*multipl){
		return true;
	} else {
		return false;
	}
}