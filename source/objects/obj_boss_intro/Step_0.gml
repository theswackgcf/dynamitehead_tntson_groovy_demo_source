{
	depth = -5100;
	if(!global._pause){
		if(_freeze > 0){
			_freeze -= 1;
			image_speed = 0;
		} else {
			image_speed = 1;
		
			_timer ++;
		
			if(image_speed <> 0){
				if(_act == 0){
				image_index = 0;
				_act = 1;
			} else if(_act == 1){
				_anim = "intro1";
				if(image_index >= image_number-1){
					image_index = image_number-1
				}
			
				if(_timer >= 20/image_speed && !_vs){
					with(obj_vsscreen){
						_start = true;
					}
					_vs = true;
				}
			
				if(_timer >= 40/image_speed){
					image_index = 0;
					_timer = 0;
					_act = 2;
				}
				} else if(_act == 2){
					_anim = "intro2";
					if(image_index >= image_number-1){
						instance_destroy();
					}
				}
			}
		}
		
		sprite_index = asset_get_index("spr_"+_codename+"_"+_anim);
	} else {
		image_speed = 0;
	}
}