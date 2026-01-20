///check_key(key, input type)
function check_key(key, inptype){
	var keys = ["stick1_l","stick1_r","stick1_u","stick1_d","stick2_l","stick2_r","stick2_u","stick2_d"];
	var yes = false;
	for(var k = 0; k < array_length(keys); k++){
		if(key == keys[k]){
			yes = true;
		}
	}
	if(yes){
		return scr_checkaxis(key, 0);
	} else {
		switch(inptype){
			case 0:
				if(typeof(key) == "number"){
					if(keyboard_check(key)){
						return true;
					} else {
						return false;
					}
				}
			break;
			case 1:
				if(typeof(key) == "number"){
					if(gamepad_button_check(global._padnum, key)){
						return true;
					} else {
						return false;
					}
				}
			break;
		}
	}
}