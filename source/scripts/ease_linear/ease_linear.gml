///@function ease_linear(start, dest, duration, [ease_title]){

//if end position and duration stay static. leave ease_title empty
function ease_linear(start, dest, duration, ease_title = ""){
	if(ease_title == ""){
		ease_title = "linear"+string(dest)+string(duration);
	}
	if(!ds_map_exists(global._easings, ease_title)){
		global._easings[? ease_title] = 0;
		return start;
	} else {
		if(global._easings[? ease_title] < duration){
			var change = dest-start;
			var time = global._easings[? ease_title];
			global._easings[? ease_title] ++;
			
			time = time / duration;
			return change * time + start;
		} else {
			return dest;
		}
	}
}