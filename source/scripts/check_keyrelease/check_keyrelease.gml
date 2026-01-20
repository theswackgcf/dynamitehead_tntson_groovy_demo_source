///check_keyrelease(key, input type)
function check_keyrelease(key, inptype){
	var keys = ["stick1_l","stick1_r","stick1_u","stick1_d","stick2_l","stick2_r","stick2_u","stick2_d"];
	var yes = false;
	for(var k = 0; k < array_length(keys); k++){
		if(key == keys[k]){
			yes = true;
		}
	}
	if(yes){
		return scr_checkaxis(key, 2);
	} else {
		switch(inptype){
			case 0:
				if(typeof(key) == "number"){
					if(keyboard_check_released(key)){
						return true;
					} else {
						return false;
					}
				}
			break;
			case 1:
				if(typeof(key) == "number"){
					if(gamepad_button_check_released(global._padnum, key)){
						return true;
					} else {
						return false;
					}
				}
			break;
		}
	}
}