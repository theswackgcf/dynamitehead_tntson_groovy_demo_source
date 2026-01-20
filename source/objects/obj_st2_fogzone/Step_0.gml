{
	depth = -3500;
	
	if(!global._pause){
		var dh = instance_nearest(x,y,obj_dh_mask);
		if(instance_exists(dh)){
			if(distance_to_object(dh) <= WIDTH*2){
				_active = true;
			} else {
				_active = false;
			}
		} else {
			_active = false;
		}
		
		if(_active){
			_fogtimer ++;
			if(global._stopFog <= 0){
				var range = [12,40];
				if(image_yscale > image_xscale){
					range = [60,170];
				}
				if(_fogtimer >= random_range(range[0],range[1])){
					if(ds_map_size(_fogmap) <= 36){
						_curfog ++;
						var offs = 256;
						_fogmap[? _curfog] = [
							irandom_range(0,sprite_get_info(spr_st2_fog).num_subimages),
							clamp(bbox_left,random_range(global._cameraX-offs,global._cameraX+WIDTH+offs),bbox_right),
							clamp(bbox_top,random_range(global._cameraY-offs,global._cameraY+HEIGHT+offs),bbox_bottom),
							choose(random_range(-4,-7),random_range(4,7)),
							0,
							false
						];
					
						_fogtimer = 0;
					}
				}
			}
			
			var dsmapkeys = ds_map_keys_to_array(_fogmap);
			for(var i = 0; i < array_length(dsmapkeys); i++){
				var curind = _fogmap[? dsmapkeys[i]];
				curind[1] += curind[3];
				if(!curind[5]){
					curind[4] += 0.012;
					if(curind[4] >= 0.9){
						curind[5] = true;
					}
				} else {
					curind[4] -= 0.007;
					if(curind[4] <= 0){
						ds_map_delete(_fogmap, dsmapkeys[i]);
					}
					if(curind[1] <= global._cameraX - ((WIDTH/2)+512) && curind[3] < 0){
						ds_map_delete(_fogmap, dsmapkeys[i]);
					}
					if(curind[1] >= global._cameraX + ((WIDTH*1.5)+512) && curind[3] > 0){
						ds_map_delete(_fogmap, dsmapkeys[i]);
					}
				}
			}
		}
	}
}