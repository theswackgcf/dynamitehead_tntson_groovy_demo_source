///function place_meeting_array(x, y, array, return object, loop instances){
function place_meeting_array(_x, _y, _array, _returnobj = false, _loopinstance = false){
	for(var _ii = 0; _ii < array_length(_array); _ii++){
		if(!_loopinstance){
			if(place_meeting(_x, _y, _array[_ii])){
				if(!_returnobj){
					return true;
				} else {
					return _array[_ii];
				}
			}
		} else {
			for(var io = 0; io < instance_number(_array[_ii]); io++){
				var inst = instance_find(_array[_ii], io);
				if(place_meeting(_x, _y, inst)){
					if(!_returnobj){
						return true;
					} else {
						return inst;
					}	
				}
			}
		}
	}
	return false;
}