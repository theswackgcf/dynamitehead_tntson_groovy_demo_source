///function place_meeting_num(x, y, array){
function place_meeting_num(_x, _y, _array){
	for(var _ii = 0; _ii < array_length(_array); _ii++){
		if(place_meeting(_x, _y, _array[_ii])){
			return _ii;
		}
	}
	return false;
}