event_inherited();

if(!global._pause){
	if(place_meeting(x-64,y,obj_dh_mask)){
		var dh = instance_place(x-64,y,obj_dh_mask);
		if(instance_exists(dh) && dh._attack){
			var p = instance_create_depth(x-128, y-128-_dispoffset[1], depth, obj_particle);
			p._type = "vanish";
			
			instance_destroy();
		}
	}
}