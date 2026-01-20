function scr_enemyscript_walkaway(){
	var multipl = 1.4;
	_dh = instance_nearest(x,y,obj_dh_mask);
	if(instance_exists(_dh)){
		if(x < _dh.x){
			_walkto[0] = _dh.x - random_range(-_walkdist[0]*multipl,_walkdist[0]*multipl);
		} else {
			_walkto[0] = _dh.x + random_range(-_walkdist[0]*multipl,_walkdist[0]*multipl);
		}
							
		if(y < _dh.y){
			_walkto[1] = _dh.y - random_range(-_walkdist[1]*multipl,_walkdist[1]*multipl);
		} else {
			_walkto[1] = _dh.y + random_range(-_walkdist[1]*multipl,_walkdist[1]*multipl);
		}
	}
}