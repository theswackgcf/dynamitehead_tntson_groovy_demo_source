function scr_player_setinput(){
	if(instance_number(obj_input) > 0){
		//setting up input
		setinput();
		
		_collidesolid = global._solidArray;
		
		//spawn at checkpoint
		if(global._checkpoint != noone){
			x = global._checkPos[0];
			y = global._checkPos[1];
		} else {
			with(obj_music){
				_musicstart = global._died;
			}
		}
				
		if(global._tutorial){
			_deffloortype = "floor";
		}
		
		_init = true;
	}
}