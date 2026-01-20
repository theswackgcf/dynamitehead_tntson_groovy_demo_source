function gamepad_anykey(device){
	for(var i = gp_face1; i <= gp_padr; i++){
		if(gamepad_button_check_pressed(device, i)){
			return true;
	    }
	}
	return false;
}