{
	if(!global._pause){
		image_speed = 1;
		
		if(!_checkdelete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					instance_destroy();
				}
			}
		
			_checkdelete = true;
		}
	
		if(_freeze <= 0){
			if(_trigger){
				if(!_setpos){
					x -= 56;
					y -= 96;
				
					_setpos = true;
				}
				sprite_index = spr_st2_bw_sleep2;
				image_angle -= 8;
				x += 32;
				if(x >= global._cameraX+WIDTH+sprite_width+12){
					global._deletedStuff[? self.id] = 1;
					instance_destroy();
				}
			}
		} else {
			_freeze --;
		}
	} else {
		image_speed = 0;
	}
}