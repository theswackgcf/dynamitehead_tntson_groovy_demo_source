{
	_timer ++;
	if(_timer > 3){
		x = floor(global._cameraX + WIDTH/2);
		y = floor(global._cameraY + HEIGHT/2);
	}
	image_alpha = 0.2;
	
	visible = false;
	if(global._debug && global._showHitbox){
		visible = true;
	}
}