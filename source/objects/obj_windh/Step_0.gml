{
	depth = -9999;
	x = (_posx + global._cameraX) + _offset;
	y = _posy + global._cameraY;
	
	switch(_state){
		case "idle":
			_anim = "idle";
		break;
		case "hurt":
			_anim = "punch"+string(_hurtanim);
			if(image_index >= image_number-1){
				image_index = image_number-1;
				if(_ranking){
					image_index = 0;
					_state = "rank";
				}
			}
		break;
		case "rank":
			if(_punches > 0 && _punches < 3){
				_rank = 1;
			} else if(_punches >= 3 && _punches < 6){
				_rank = 2;
			} else if(_punches >= 6 && _punches < 9){
				_rank = 3;
			} else if(_punches >= 9){
				_rank = 4;
			}
			
			_timer ++;
			
			_anim = "rank"+string(_rank);
			if(_timer > 8 && image_index >= image_number-1){
				image_index = 2;
			}
		break;
		case "hellyeah1":
			_anim = "hellyeah1";
			if(image_index >= image_number-1){
				image_index = 1;
			}
		break;
		case "hellyeah2":
			_anim = "hellyeah2";
			if(image_index >= image_number-1){
				image_index = 1;
			}
		break;
	}
	
	//explosion behind
	if(_hellyeahexp == 1){
		_hellyeahexp_time ++;
		if(_hellyeahexp_time % 8 == 7){
			_hellyeahexp_frame ++;
			if(_hellyeahexp_frame >= sprite_get_info(spr_p_explosion_screen).num_subimages-1){
				_hellyeahexp = 2;
			}
		}
	}
	
	sprite_index = asset_get_index("spr_"+_codename+"results_"+_anim);
}