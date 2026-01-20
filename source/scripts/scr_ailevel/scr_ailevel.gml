///function scr_ailevel(min_val, val, [instance])
function scr_ailevel(min_val, val, instance = noone){
	var avg_level = 5;
	var newval = 999;
	var mult = 1;
	var addmult = 0.6; //enemy is smart
	if(instance != noone && instance_exists(instance)){
		if(avg_level > instance._total_ailevel){
			//enemy is dumb
			addmult = 1;
		}
		if(instance._total_ailevel <> 0){
			mult = avg_level/instance._total_ailevel;
			newval = val*(mult*addmult);
		}
	} else {
		if(avg_level > _total_ailevel){
			addmult = 1.2;
		}
		if(_total_ailevel <> 0){
			mult = avg_level/_total_ailevel;
			newval = val*(mult*addmult);
		}
	}
	return max(min_val, newval);
}