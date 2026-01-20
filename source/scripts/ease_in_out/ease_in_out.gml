///@function ease_in_out(start, dest, duration, [ease_title]){

//if end position and duration stay static. leave ease_title empty
function ease_in_out(start, dest, duration, ease_title = ""){
	if(ease_title == ""){
		ease_title = "in_out"+string(dest)+string(duration);
	}
	if(!ds_map_exists(global._easings, ease_title)){
		global._easings[? ease_title] = 0;
		return start;
	} else {
		if(global._easings[? ease_title] < duration){
			var change = dest-start;
			var time = global._easings[? ease_title];
			global._easings[? ease_title] ++;
			
			time = time / (duration/2);
			if(time < 1) return change/2 * power(time,2) + start;
			time --;
			return -change/2 * (time * (time-2) -1) + start;
		} else {
			return dest;
		}
	}
}