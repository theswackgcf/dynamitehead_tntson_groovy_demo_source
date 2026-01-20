{
	_offset = 0;
	_scale = 1;
	
	switch(global._location){
		case 0:
			sprite_index = spr_lv2intro_fg;
		break;
		case 1:
			sprite_index = spr_lv2intro_fg;
		break;
	}
	
	image_xscale = _scale;
	image_yscale = _scale;
	
	image_index = round(random(image_number-1));
	image_speed = 0;
}