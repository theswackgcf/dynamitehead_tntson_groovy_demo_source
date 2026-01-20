{
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				instance_destroy();
			}
		}
		_checkdelete = true;
	}
	
	if(_active && !global._dialogue){
		if(!_battlezone || (_battlezone && global._battlezone)){
			if(place_meeting(x,y,obj_dh_mask)){
				_delay --;
				if(_delay <= 0){
					//show corresponding prompt
					if(ds_map_exists(global._gametips, _prompt)){
						if(!global._gametips[? _prompt][1]){
							global._prompt_desc_show = global._help_prompt_time;
							global._prompt_desc_type = _prompt;
							global._gametips[? _prompt][0] = true;
						}
					} else {
						global._prompt_desc_show = global._help_prompt_time;
						global._prompt_desc_type = _prompt;
					}
				}
			}
		}
	}
}