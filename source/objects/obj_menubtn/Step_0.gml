{
	if(!_tnt){
		depth = -25;
		_on = false;
		if(_menuobj._curopt[0] == _opt){
			_on = true;
		}
		if(_on){
			sprite_index = asset_get_index("spr_menu_"+_btn+"1");
		} else {
			sprite_index = asset_get_index("spr_menu_"+_btn+"2");
		}
		
		//mouse
		if(_menuobj._menustate == "main"){
			visible = true;
			if(global._inactivecursor < global._inactivecursortime && _menuobj._mouseactive && !_menuobj._enter && _menuobj._menutimer >= 16){
				if(!_hover){
					if(scr_mousehover(bbox_left+_sizeoffset[0], bbox_top+_sizeoffset[1], bbox_right+_sizeoffset[2], bbox_bottom+_sizeoffset[3])){
						_hover = true;
						_menuobj._prevopt[0] = _menuobj._curopt[0];
						_menuobj._curopt[0] = _opt;
					}
				} else {
					if(!scr_mousehover(bbox_left+_sizeoffset[0], bbox_top+_sizeoffset[1], bbox_right+_sizeoffset[2], bbox_bottom+_sizeoffset[3])){
						_hover = false;
					}
				}
				if(_hover && mouse_check_button_pressed(mb_left)){
					//confirm
					with(obj_menufinal){
						checkmenus();
					}
				}
			}
		}
		if(_menuobj._menustate != "main"){
			visible = false;
		}
	} else {
		depth = -26;
		_on = false;
		if(_menuobj._curopt[0] == _opt){
			_on = true;
		}
		if(_on){
			visible = true;
		} else {
			visible = false;
		}
		if(_menuobj._menustate != "main"){
			visible = false;
		}
		
		if(!_init){
			//sprite_index = spr_menu_tnt1;
			_init = true;
		}
		
		_timer ++;
		if(_amp > 0){
			_amp -= 0.04;
		} else if(_amp < 0){
			_amp = 0;
		}
		if(_amp > 0){
			image_xscale = 1+(sin(_timer/12)*_amp);
			image_yscale = 1+(cos(_timer/12)*_amp);
		} else {
			image_xscale = 1;
			image_yscale = 1;
		}
		
		//if(_on && sprite_index == spr_menu_tnt2 && image_index >= image_number-1){
			//_menuobj._transition = true;
		//}
		//if(sprite_index == spr_menu_tnt2 && image_index >= image_number-1){
			//sprite_index = spr_menu_tnt1;
		//}
	}
}