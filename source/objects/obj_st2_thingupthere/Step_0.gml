{
	depth = -3400;
	
	if(_secret){
		if(!_checkdelete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					_trigger = true;
				}
			}
		
			_checkdelete = true;
		}
	}
	
	if(!global._pause){
		if(_secret){
			if(!_init){
				for(var i = 0; i < instance_number(obj_stage_secret); i++){
					var inst = instance_find(obj_stage_secret, i);
					if(instance_exists(inst) && inst._triggertype == ST2_SECRET_TRIGGER_AIR){
						_parentobj = inst;
						break;
					}
				}
				_init = true;
			}
		}
		
		if(!_trigger){
			_timer ++;
		}
		
		var spd = 28;
		image_blend = #551694;
		if(_secret){
			spd = 8;
			image_blend = #914ad9;
		}
		if(global._kohit > 0){
			image_blend = c_black;
		}
		y = _starty + sin(_timer/spd)*20;
		
		//get punched
		if(_secret){
			if(_parentobj != noone && instance_exists(_parentobj)){
				if(!_trigger && place_meeting(x,y,obj_dh_mask)){
					var p = instance_place(x,y,obj_dh_mask);
					if(instance_exists(p)){
						if(p._attacktype == "air" && p._height >= 30){
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