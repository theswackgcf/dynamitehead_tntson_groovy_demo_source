{
	if(_parentobj != noone && instance_exists(_parentobj)){
		if(global._cameraZoom <> 0){
			_mousepos = [(mouse_x-camera_get_view_x(global._camera))/global._cameraZoom, (mouse_y-camera_get_view_y(global._camera))/global._cameraZoom];
		}
		if(global._buildver == HTML){
			_mousepos = [window_mouse_get_x(),window_mouse_get_y()];
		}
		
		
		//bbox
		_bbox.up = [WIDTH-_barsz[0],0,WIDTH,_barsz[1]]; //l u r d
		_bbox.down = [WIDTH-_barsz[0],HEIGHT-_barsz[1],WIDTH,HEIGHT]; //l u r d
		_bbox.scroll = [WIDTH-_scrollwidth, _scrolloffs+_totaloffset, WIDTH, _scrolloffs+_totaloffset+_scrollheight]; //l u r d

		_upselect = 0;
		_downselect = 0;
		_scrollselect = 0;
	
		_prevpos = _scrollpos;
	
		if(_parentobj._scrheight > 0){
			_scrollspd = max(0.15, 1-(_parentobj._scrheight*0.0006));
			if(!_drag){
				_scrollpos = (-_parentobj._offsetYLerp) / _parentobj._scrheight;
			} else {
				_parentobj._scrolldrag = 2;
				
				_scrollselect = 1;
				_dragpos = lerp(_dragpos, _mousepos[1]-_scrolloffs-_dragoffset,0.4);
				if(_dragpos < 0){
					_dragpos = 0;
				} else if(_dragpos > _bottom){
					_dragpos = _bottom;
				}
				if(_bottom > 0){
					_scrollpos = _dragpos/_bottom;
					_parentobj._offsetY = -(_parentobj._scrheight * _scrollpos);
					_parentobj._offsetYLerp = _parentobj._offsetY;
				}
			}
		}
		
		//knob directions
		if(_scrollpos >= 0.05 && _scrollpos <= 0.95){
			if(_prevpos <> _scrollpos){
				if(_prevpos > _scrollpos){
					_dir = 1;
				} else {
					_dir = 2;
				}
			} else {
				_dir = 0;
			}
		
			var decayspd = 0.25;
			if(_scrollup > 0){
				_dir = 1;
				_scrollup -= decayspd;
			}
			if(_scrolldown > 0){
				_dir = 2;
				_scrolldown -= decayspd;
			}
		} else {
			_dir = 0;
		}

		_bottom = HEIGHT-_barsz[1]-_scrollheight-_scrolloffs;
		_totaloffset = _bottom*_scrollpos;

		if(_visibtimer > 0){
			if(global._menumouse){
				//hovering over
				if(scr_mousehover(_bbox.up[0],_bbox.up[1],_bbox.up[2],_bbox.up[3], true)){
					_upselect = 1;
				} else if(scr_mousehover(_bbox.scroll[0],_bbox.scroll[1],_bbox.scroll[2],_bbox.scroll[3], true)){
					_scrollselect = 1;
				} else if(scr_mousehover(_bbox.down[0],_bbox.down[1],_bbox.down[2],_bbox.down[3], true)){
					_downselect = 1;
				}
		
				if(_upselect == 1){
					//scroll up
					if(mouse_check_button(mb_left)){
						_mousetimer ++;
					} else {
						_mousetimer = 0;
					}
					if(mouse_check_button_pressed(mb_left) || _mousetimer >= _maxmousetimer){
						_scrollup = 1;
						_scrolldown = 0;
						go_direction(-1);
					}
				} else if(_downselect == 1){
					//scroll down
					if(mouse_check_button(mb_left)){
						_mousetimer ++;
					} else {
						_mousetimer = 0;
					}
					if(mouse_check_button_pressed(mb_left) || _mousetimer >= _maxmousetimer){
						_scrollup = 0;
						_scrolldown = 1;
						go_direction(1);
					}
				}
		
				//mouse wheel
				if(mouse_wheel_up()){
					_scrollup = 1;
					_scrolldown = 0;
					go_direction(-1);
				} else if(mouse_wheel_down()){
					_scrollup = 0;
					_scrolldown = 1;
					go_direction(1);
				}
			
				//drag
				if(!_drag && _scrollselect == 1 && mouse_check_button_pressed(mb_left)){
					_dragoffset = diff_abs(_bbox.scroll[1],_mousepos[1]);
					_drag = true;
				}
				if(!mouse_check_button(mb_left)){
					_drag = false;
				}
			
				//snap to
				if(!_drag && _upselect == 0 && _scrollselect == 0 && _downselect == 0){
					if(mouse_check_button(mb_left) && _mousepos[0] >= WIDTH-_barsz[0]){
						_dragoffset = _scrollheight/2;
						_drag = true;
					}
				}
			} else {
				_drag = false;
			}
		} else {
			_drag = false;
		}
	}
	
	if(global._state == "game" && !global._pause){
		if(surface_exists(_gui_surface)){
			surface_free(_gui_surface);
		}
		if(surface_exists(_resizegui_surface)){
			surface_free(_resizegui_surface);
		}
	}
}