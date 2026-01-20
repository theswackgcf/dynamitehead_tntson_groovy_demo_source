function scr_orderspawn(){
	if(global._location == 1){
		if(instance_number(obj_boss2_mask) == 0){
			if(instance_number_array(global._enemyArray) == 0){
				_canspawn ++;
			} else {
				_canspawn = 0;
			}
		} else {
			if(instance_number_array(global._enemyArray) == instance_number(obj_boss2_mask)){
				_canspawn ++;
			} else {
				_canspawn = 0;
			}
		}
	}
}