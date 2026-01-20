{
	_collide = [];
	if(place_meeting_array(x,y,[obj_dh_mask], false, true)){
		var dh = place_meeting_array(x,y,[obj_dh_mask],true,true);
		if(instance_exists(dh) && !array_contains(_collide,dh.id)){
			array_push(_collide,dh.id);
		}
	}
	if(array_length(_collide) >= instance_number(obj_dh_mask)){
		global._stopFog = 2;
	}
}