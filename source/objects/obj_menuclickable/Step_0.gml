{
	depth = -11000;
	
	if(_parentbtn != noone){
		if(!_main){
			_xpos = _parentbtn._xpos + _offsetx;
			_ypos = _parentbtn._ypos + _offsety;
		} else {
			_xpos = _offsetx;
			_ypos = _offsety;
		}
		
		if(_backbutton){
			var offsright = 1.85;
			if(scr_compareinput("pause","menu_back")){
				_xsize = scr_textrender_width("keycode@PAUSEkeycode")*offsright;
			} else {
				_xsize = scr_textrender_width("keycode@MENU_BACKkeycode / keycode@PAUSEkeycode")*offsright;
			}
			if(variable_instance_exists(_parentbtn, "_getinput")){
				if(_parentbtn._getinput){
					switch(global._inptype){
						case 0:
							_xsize = scr_textrender_width("keycode>DELETEkeycode")*offsright;
							if(global._padfound){
								_xsize = scr_textrender_width("keycode>DELETEkeycode / keycode>SELECTkeycode")*offsright;
							}
						break;
						case 1:
							_xsize = scr_textrender_width("keycode>SELECTkeycode")*offsright;
						break;
					}
				}
			}
		}
	}
	
	_bbox = [_xpos-(_xsize/2),_ypos-(_ysize/2),_xpos+(_xsize/2),_ypos+(_ysize/2)];
	//left top right bottom
	
	if(_coold > 0){
		_coold -= 1;
	} else if(_coold < 0){
		_coold = 0;
	}
	
	if(_canrapidfire){
		if(global._menumouse){
			if(_active && scr_mousehover(_bbox[0],_bbox[1],_bbox[2],_bbox[3], true) && mouse_check_button(mb_left)){
				_rapidfire[1] ++;
				if(_rapidfire[1] >= 25){
					_rapidfire[0] = true;
				}
			}
			if(!_active || !scr_mousehover(_bbox[0],_bbox[1],_bbox[2],_bbox[3], true) || !mouse_check_button(mb_left)){
				_rapidfire = [false, 0];
			}
		}
	} else {
		_rapidfire = [false, 0];
	}
	
	if(_parentbtn != noone){
		_active = _parentbtn._on;
		
		if(!global._padfound && _action == "change-inp"){
			_active = false;
		}
		if(variable_instance_exists(_parentbtn, "_monyx_screen")){
			if(!_parentbtn._monyx_screen && _monyx_screen){
				_active = false;
			}
		}
	
		if(_active && _coold == 0){
			_timer ++;
			if(global._menumouse){
				if(scr_mousehover(_bbox[0],_bbox[1],_bbox[2],_bbox[3], true)){
					with(obj_options){
						_mouselect = 2;
					}
					if(mouse_check_button_pressed(mb_left) || (mouse_check_button(mb_left) && _rapidfire[0] && _timer % (global._rapidtimer*_rapidfactor) == 0)){
						_coold = global._rapidtimer-1;
						_parentbtn._action = _action;
					}
				}
			}
		}
	}
}