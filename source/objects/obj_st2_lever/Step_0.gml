{
	image_speed = 0;
	
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				_trigger = true;
			}
		}
		_checkdelete = true;
	}
	
	if(!_init){
		for(var i = 0; i < instance_number(obj_stage_secret); i++){
			var inst = instance_find(obj_stage_secret, i);
			if(instance_exists(inst) && inst._triggertype == ST2_SECRET_TRIGGER_CROUCH){
				_parentobj = inst;
				break;
			}
		}
		_init = true;
	}
	
	visible = global._lightsout;
	
	if(!global._pause){
		if(!_trigger){
			image_index = 0;
		} else {
			image_index = 1;
		}
		
		//dh crouch kicks the trigger and the spot opens up
		if(_parentobj != noone && instance_exists(_parentobj)){
			if(visible && !_trigger && place_meeting(x,y,obj_punchhitbox)){
				var p = instance_place(x,y,obj_punchhitbox);
				if(instance_exists(p)){
					var parent = p._parentobj;
					if(instance_exists(parent)){
						if(p._active && parent._attacktype == "crouch"){
							global._deletedStuff[? self.id] = self.id;
								
							_trigger = true;
							_parentobj._trigger = true;
						}
					}
				}
			}
		}
	}
}