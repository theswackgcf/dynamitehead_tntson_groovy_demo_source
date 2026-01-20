///@function ease_out_elastic(start, dest, duration, [damping], [ease_title]){

//if end position and duration stay static. leave ease_title empty
function ease_out_elastic(start, dest, duration, damping = 0.5, ease_title = ""){
	if(ease_title == ""){
		ease_title = "out_elastic"+string(dest)+string(duration);
	}
	if(!ds_map_exists(global._easings, ease_title)){
		global._easings[? ease_title] = 0;
		return start;
	} else {
		if(global._easings[? ease_title] < duration){
			var time = global._easings[? ease_title];
			global._easings[? ease_title] ++;
			
			var a = start;
			var b = dest;
			
			var s = 1.7;
			var p = 0;
			var aa = (b - a);
			if(time == 0) return a;
			time /= duration;
			if(time == 1) return a + (b - a);
			if(!p) p = duration * damping;
			if(a < abs((b - a))){
				aa = (b - a);
				s = p / 4;
			}
			else{
				if(a <> 0 && !is_nan((b - a) / aa)){
					s = p / (2 * pi) * arcsin(clamp((b - a) / aa,-1,1));
				}
			}
	
			return aa * power(2, -10 * time) * sin((time * duration - s) * (2 * pi) / p) + (b - a) + a;
		} else {
			return dest;
		}
	}
}