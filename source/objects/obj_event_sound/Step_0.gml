{
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(place_meeting(x, y, obj_dh_mask)){
		_dh = instance_place(x,y,obj_dh_mask);
		if(!_trigger){
			global.sfx_effect = _event;
		}
	}
	if(_dh != noone && instance_exists(_dh)){
		if(!place_meeting(x, y, _dh)){
			if(global.sfx_effect == _event){
				global.sfx_effect = "";
				global.sfx_bus.effects[0] = undefined;
			}
			_dh = noone;
		}
	}
}