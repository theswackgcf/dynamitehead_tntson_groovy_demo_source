{
	if(_prompts != noone && instance_exists(_prompts)){
		instance_destroy(_prompts.id);
	}
}