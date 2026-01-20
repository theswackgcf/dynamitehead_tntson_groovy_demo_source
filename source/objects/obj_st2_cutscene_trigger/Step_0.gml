{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				instance_destroy();
			}
		}
		_checkdelete = true;
	}
	
	if(!global._pause){
		if(!global._battlezone && place_meeting(x,y,obj_dh_mask)){
			if(!_trigger){
				with(obj_st2_cutscene){
					_trigger = true;
				}
				global._deletedStuff[? self.id] = self.id;
				
				_trigger = true;
			}
		}
	}
}