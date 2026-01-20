{
	depth = -9990;
	x = _startX + global._cameraX;
	y = _startY + global._cameraY;
	
	_timer ++;
	if(_timer % 6 == 0){
		_spotlightframe ++;
		if(_spotlightframe >= 3){
			_spotlightframe = 0;
		}
	}
}