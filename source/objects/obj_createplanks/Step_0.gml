{
	if(!_check){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				for(var i = 0; i < 5; i++){
					var plank = instance_create_depth(x+random_range(-64,64), y+random_range(-64,64), 0, obj_lv1_plank);
					plank._createtype = 1;
				}
			}
			_check = true;
		}
	}
	
	if(place_meeting(x, y, obj_dh_mask)){
		global._deletedStuff[? self.id] = self.id;
		instance_destroy();
	}
}