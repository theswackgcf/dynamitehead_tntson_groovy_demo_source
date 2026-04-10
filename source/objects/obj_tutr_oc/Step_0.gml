{
	image_xscale = _scale*_dir;
	image_yscale = _scale;
	
	if(!_init){
		//set all varialbes depending on oc
		switch(_codename){
			case "fella":
				_xspd_max = 5.6;
				_idletimer_max = 90;
				_walktimer_max = 560;
			break;
			case "gran":
				_xspd_max = 3.2;
				_idletimer_max = 250;
				_walktimer_max = 400;
			break;
			case "breadft":
				_xspd_max = 7;
				_idletimer_max = 45;
				_walktimer_max = 280;
			break;
			case "glassesinblue":
				_idletimer_max = 190;
				_walktimer_max = 240;
			break;
			case "icie145":
				_xspd_max = 10;
				_idletimer_max = 30;
				_walktimer_max = 140;
				_idletype = 1;
			break;
			case "lafonteyn":
				_xspd_max = 8;
			break;
			case "popkinsssussy":
				_idletimer_max = 120;
				_walktimer_max = 380;
			break;
			case "toki":
				_xspd_max = 9.6;
			break;
			case "yaysuu":
				_xspd_max = 14;
				_idletimer_max = 140;
				_walktimer_max = 999;
				_jump = true;
			break;
			case "junga":
				_xspd_max = 3.8;
				_idletimer_max = 140;
				_walktimer_max = 120;
			break;
			case "gizmo":
				_xspd_max = 6.4;
				_idletimer_max = 55;
				_walktimer_max = 380;
			break;
			case "booger":
				_xspd_max = 5;
				_idletimer_max = 24;
				_walktimer_max = 600;
			break;
		}
		
		_xspd_max += random_range(-0.3,0.3);
		
		_init = true;
	} else {
		if(!global._pause){
			image_speed = 1;
			
			//speed stuff
			if(x < 64){
				_dir = DIR_R;
				x = 64;
			} if(x > room_width-64){
				_dir = DIR_L;
				x = room_width-64;
			} else {
				if(_changedir){
					_dir = choose(DIR_L, DIR_R);
					_changedir = false;
				}
			}
		
			x += _xspd;
		
			if(_jump){
				y += _yspd;
				_yspd += 0.64;
			}
		
			if(y >= _starty){
				_yspd = 0;
				y = _starty;
			}
		
			//behavior
			_timer ++;
			_override = false;
			if(_act == 0){
				_anim = "idle";
				_xspd = 0;
			
				if(_codename == "toki"){
					if(image_index >= image_number-1){
						image_index = 1;
					}
				}
			
				//the other idle
				if(_idletype == 1){
					_idlet ++;
					if(_idlea == 0){
						if(_idlet >= random_range(60,180)){
							_idlet = 0;
							_idlea = 1;
						}
					} else if(_idlea == 1){
						if(_idlet >= 18){
							_idlet = 0;
							_idlea = 0;
						}
					}
					_override = true;
				}
			
				if(_timer >= max(30,_idletimer_max + random_range(-60,60))){
					_timer = 0;
					_act = 1;
					if(_jump){
						y -= 4;
						_yspd = -12;
					}
				}
			} else if(_act == 1){
				_anim = "walk";
				_xspd = _xspd_max*_dir;
				if(!_jump){
					if(_timer >= max(30,_walktimer_max + random_range(-60,60))){
						image_index = 0;
						_changedir = true;
						_timer = 0;
						_act = 0;
					}
				} else {
					if(y >= _starty){
						image_index = 0;
						_changedir = true;
						_timer = 0;
						_act = 0;
					}
				}
			}
		
			var sp = asset_get_index("spr_oc_"+_codename+"_"+_anim);
			if(sprite_exists(sp)){
				sprite_index = sp;
			}
			if(_override){
				image_index = floor(_idlea);
			}
		} else {
			image_speed = 0;
		}
	}
}