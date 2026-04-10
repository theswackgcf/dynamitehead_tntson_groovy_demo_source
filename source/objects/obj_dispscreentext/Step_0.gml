{
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				instance_destroy();
			}
			_checkdelete = true;
		}
	}
	
	if(!global._pause){
		if(place_meeting(x,y,obj_dh_mask)){
			with(obj_gui){
				_uitextshow = true;
				_uitext = other._text;
			}
			
			global._deletedStuff[? self.id] = self.id;
			
			instance_destroy();
		}
	}
}