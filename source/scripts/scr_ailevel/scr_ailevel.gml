///function scr_ailevel(min_val, val, [instance])
function scr_ailevel(min_val, val, instance = noone){
	var avg_level = 5;
	var newval = 999;
	var mult = 1;
	var addmult = 0.55; //enemy is smart
	if(instance != noone && instance_exists(instance)){
		if(avg_level > instance._total_ailevel){
			//enemy is dumb
			addmult = 0.8;
		}
		if(instance._total_ailevel <> 0){
			mult = avg_level/instance._total_ailevel;
			newval = val*(mult*addmult);
		}
	} else {
		if(variable_instance_exists(self.id, "_total_ailevel")){
			if(avg_level > _total_ailevel){
				addmult = 0.7;
			}
			if(_total_ailevel <> 0){
				mult = avg_level/_total_ailevel;
				newval = val*(mult*addmult);
			}
		}
	}
	return max(min_val, newval);
}