///@function ease_out(start, dest, duration, [ease_title]){

//if end position and duration stay static. leave ease_title empty
function ease_out(start, dest, duration, ease_title = ""){
	if(ease_title == ""){
		ease_title = "out"+string(dest)+string(duration);
	}
	if(!ds_map_exists(global._easings, ease_title)){
		global._easings[? ease_title] = 0;
		return start;
	} else {
		if(global._easings[? ease_title] < duration){
			var time = global._easings[? ease_title];
			global._easings[? ease_title] ++;
			
			time /= duration;
			return (dest - start) * (1 - power(1 - time, 3)) + start;
		} else {
			return dest;
		}
	}
}