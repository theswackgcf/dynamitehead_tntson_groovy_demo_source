{
	if(!global._pause){
		if(_timer < 8){
			if(_bzone == noone){
				if(place_meeting(x, y, obj_battlezone)){
					_bzone = instance_place(x,y,obj_battlezone);
				}
			}
			_timer ++;
		}
	}
	
	if(!global._debug){
		visible = false;
	} else {
		visible = global._showHitbox;
	}
}