{
	if(global._battlezone){
		//if battlezone, get current battlezone object
		_bzone = instance_place(x,y,obj_battlezone);
		if(_bzone != noone && instance_exists(_bzone)){
			//find out if the current wave matches
			if(array_contains(_waves, _bzone._curwave)){
				_active = true;
			} else {
				_active = false;
			}
		} else {
			_active = false;
		}
	} else {
		_bzone = noone;
		_active = false;
	}
}