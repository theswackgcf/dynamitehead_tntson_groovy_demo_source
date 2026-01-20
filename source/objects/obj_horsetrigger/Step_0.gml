{
	if(!_trigger){
		if(place_meeting(x, y, obj_dh_mask)){
			var horse = instance_find(obj_horse, 0);
			if(horse != noone && instance_exists(horse)){
				horse._appear = true;
				_trigger = true;
			}
		}
	}
}