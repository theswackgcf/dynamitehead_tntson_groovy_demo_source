{
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		if(!global._lode_editor){
			_sintimer ++;
			
			if(_visibtimer > 0){
				_visibtimer --;
			
				_show = true;
			} else {
				_show = false;
			}
			
			if(_parentobj != noone && instance_exists(_parentobj)){
				scr_lode_digbox_offset();
			}
		}

		scr_lode_project(sprite_index,image_index,[x+(sprite_width*0.5),y+(sprite_height*0.5)],[image_xscale+(sin(_sintimer/18)*0.05),image_yscale+(sin(_sintimer/18)*0.05)],_depth,0,c_white,0.65);
	} else {
		image_speed = 0;
	}
}