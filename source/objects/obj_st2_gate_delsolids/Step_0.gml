{
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				_trigger = true;
			}
		}
		_checkdelete = true;
	}
	
	if(_trigger){
		if(place_meeting(x,y,obj_solid)){
			var inst = instance_place(x,y,obj_solid);
			instance_destroy(inst.id);
		}
		if(place_meeting(x,y,obj_slope)){
			var inst = instance_place(x,y,obj_slope);
			instance_destroy(inst.id);
		}
		
		global._deletedStuff[? self.id] = self.id;
		instance_destroy();
	}
}