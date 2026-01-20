{
	depth = 9995;
	if(!global._pause){
		if(!_checkdelete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					instance_destroy();
				}
				_checkdelete = true;
			}
		}
		if(!_trigger){
			if(place_meeting(x, y, obj_dh_mask)){
				global._deletedStuff[? self.id] = self.id;
				instance_create_depth(x-WIDTH, 250, depth, obj_barrelfly);
				_trigger = true;
			}
		}
	}
}