{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!_trigger){
		if(place_meeting(x,y,obj_dh_mask)){
			var dh = instance_place(x,y,obj_dh_mask);
			if(instance_exists(dh)){
				dh._forcetnt = true;
				_trigger = true;
			}
		}
	}
}