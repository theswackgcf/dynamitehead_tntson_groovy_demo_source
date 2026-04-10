{
	if(!global._pause){
		if(_freeze > 0){
			_freeze -= 1;
			image_speed = 0;
		} else {
			if(string_starts_with(_type, "fx")){
				_depthoffset = _adddepth;
				if(_damage == ATK_MASH){
					_depthoffset = -_adddepth;
				}
			}
		
			image_speed = 1;
		
			_timer ++;
			sprite_index = asset_get_index("spr_p_"+_type);
			image_blend = _color;
			
			if(instance_number(obj_kohit) > 0){
				if(global._kohit > 0){
					image_blend = c_black;
				}
			}
			
			if(_rotate){
				_angle += _rotate_spd;
			}
			
			if(_alpha){
				image_alpha -= _alpha_spd;
				if(image_alpha <= 0){
					if(!_lode_particle){
						instance_destroy();
					} else {
						scr_lode_remove_project();
						_lode_project = false;
					}
				}
			}
			
			image_angle = _angle;
			if(_timer > 1){
				if(!_lode_particle){
					visible = true;
				}
				if(_timer >= 320 || (_frameend && image_index >= image_number-1)){
					if(!_lode_particle){
						instance_destroy();
					} else {
						scr_lode_remove_project();
						_lode_project = false;
					}
				}
	
				if(!_init){
					if(!_lode_particle){
						x += 64*_curdir;
					}
					_init = true;
				}
				
				if(_changescale){
					_scale += _changescale_spd;
				}
				
				image_xscale = (_scale+0.2)*_curdir;
				image_yscale = _scale+0.2;
			
				if(_move){
					x += _xspd;
					y += _yspd;
					if(_do_grav){
						_yspd += _grav_val;
					}
				}
			} else {
				visible = false;
			}
			
			//ind cases
			switch(_type){
				case "smile":
					_start_xscale = (_scale+0.2)*_curdir;
					_start_yscale = _scale+0.2;
					image_xscale = _start_xscale + random_range(-0.02,0.02);
					image_yscale = _start_yscale + random_range(-0.04,0.04);
				break;
			}
			
			if(_lode_particle){
				image_xscale = 1;
				image_yscale = 1;
				if(_lode_project){
					scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale],_lode_depth,image_angle,image_blend,image_alpha);
				} else {
					_lode_deadtimer ++;
					if(_lode_deadtimer >= 8){
						instance_destroy();
					}
				}
			}
		}
	} else {
		image_speed = 0;
	}
}