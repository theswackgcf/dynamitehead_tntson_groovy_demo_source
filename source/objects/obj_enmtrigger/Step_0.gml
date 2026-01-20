{
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(_connectobj == noone){
		if(place_meeting(x,y,obj_enmtrigger_connect)){
			_connectobj = instance_place(x,y,obj_enmtrigger_connect);
		}
	} else {
		if(!_trigger){
			//getting triggered by dh
			if(place_meeting(x,y,obj_dh_mask)){
				_connectobj._trigger = true;
				_trigger = true;
			}
		}
	}
}