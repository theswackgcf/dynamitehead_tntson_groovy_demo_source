{
	if(_prompts != noone && instance_exists(_prompts)){
		instance_destroy(_prompts);
	}
	
	scr_enemyscript_clean();
}