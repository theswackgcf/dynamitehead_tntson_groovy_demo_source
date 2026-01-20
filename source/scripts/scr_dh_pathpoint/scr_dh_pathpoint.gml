function scr_dh_pathpoint(){
	if(x < _dh.x){
		_pathpoint[0] = _dh.x-_dhdist[0];
	} else {
		_pathpoint[0] = _dh.x+_dhdist[0];
	}
	if(y < _dh.y){
		_pathpoint[1] = _dh.y+16;
	} else {
		_pathpoint[1] = _dh.y-16;
	}
}