{
	if(_yolob_sol != noone && instance_exists(_yolob_sol)){
		_alt_tutorial = false;
		instance_destroy(_yolob_sol.id);
	}
	
	scr_enemyscript_clean();
}