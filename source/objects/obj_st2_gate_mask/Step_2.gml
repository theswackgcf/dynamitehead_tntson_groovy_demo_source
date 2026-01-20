{
	if(!global._pause){
		scr_enemyscript_animation("endstep");
		with(_displayobj){
			if(instance_number(obj_stageentrance) == 0){
				_sort = false;
				depth = 2200;
			}
		}
	}
}