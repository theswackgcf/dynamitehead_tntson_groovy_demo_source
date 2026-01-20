{
	depth = -6500;
	
	if(_parentobj != noone && instance_exists(_parentobj)){
		x = _parentobj.x;
		y = _parentobj.y;
	}
	
	if(_help_prompt > 0){
		_help_prompt --;
	}
	if(_help_prompt <= 0){
		_prompt_type = "";
	}
}