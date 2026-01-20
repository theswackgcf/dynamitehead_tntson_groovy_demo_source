{
	if(!global._pause){
		if(place_meeting(x,y,obj_lockcamera)){
			var lock = instance_place(x,y,obj_lockcamera);
			if(instance_exists(lock)){
				_offsetX = lock._offsetX;
				_offsetY = lock._offsetY;
			}
		}
		x = _startx + _offsetX;
		y = (_starty + _offsetY)+116;
	}
}