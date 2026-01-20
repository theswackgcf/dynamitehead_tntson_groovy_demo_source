{
	if(global._state != "game" || (global._state == "game" && global._pause)){
		depth = -11001;
	
		if(!_pausebtn){
			if(_layer == 1){
				_multpl = [1.6,1.15];
			}
		} else {
			if(_state == "confirm"){
				_multpl[0] = 1.5;
				_multpl[1] = 1.3;
			}
		}
	
		_xsize = (scr_textrender_width(_text)*_multpl[0])+64;
		_ysize = (scr_textrender_height(_text)*_multpl[1])+32;
	
		//left top right bottom
		_bbox = [_xpos - (_xsize/2), _ypos - (_ysize/2), _xpos + (_xsize/2), _ypos + (_ysize/2)];
	
		_scaleparam = [global._res[global._curres][0]/WIDTH,global._res[global._curres][1]/HEIGHT];
	
	
		_dispbox = [_bbox[0]-96,_bbox[1]-48,_bbox[2]+164,_bbox[3]+_stretchbottom+48];
		if(_id == "inp"){
			_dispbox[0] = _bbox[0]-196;
			_dispbox[2] = _bbox[2]+196;
		}
		_dispsize = [_dispbox[2]-_dispbox[0],_dispbox[3]-_dispbox[1]];
		_disppos = [_dispbox[0],_dispbox[1]];
	
		//button no longer visible
		if(global._buildver != HTML){
			if(!_showbtn){
				_gui_size = [round(_dispsize[0]),round(_dispsize[1])];
				if(surface_exists(_gui_surface)){
					surface_free(_gui_surface);
				}
				_resizegui_size = [round(_dispsize[0]*_scaleparam[0]),round(_dispsize[1]*_scaleparam[1])];
				if(surface_exists(_resizegui_surface)){
					surface_free(_resizegui_surface);
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
	
		if(!_init){
			if(_id == "vol"){
				var btn = instance_create_depth(0, 0, 0, obj_menuclickable);
				btn._parentbtn = self;
				btn._offsetx = -170;
				btn._offsety = 80;
				btn._xsize = 85;
				btn._ysize = 75;
				btn._action = "leftvol";
				btn._canrapidfire = true;
				
				btn = instance_create_depth(0, 0, 0, obj_menuclickable);
				btn._parentbtn = self;
				btn._offsetx = 192;
				btn._offsety = 80;
				btn._xsize = 85;
				btn._ysize = 75;
				btn._action = "rightvol";
				btn._canrapidfire = true;
			}
			if(_id == "scr" || _id == "res" || _id == "aa" || _id == "blend" || _id == "shake" || _id == "dz" || _id == "inptype" || _id == "rmbl" || _id == "freeze"){
				var btn = instance_create_depth(0, 0, 0, obj_menuclickable);
				btn._parentbtn = self;
				btn._offsetx = -170;
				btn._offsety = 95;
				btn._xsize = 85;
				btn._ysize = 75;
				btn._action = "left-"+_id;
				if(_id == "scr"){
					btn._offsetx = -207;
				}
				if(_id == "inptype"){
					btn._offsetx = -210;
					btn._action = "change-inp";
				}
				if(_id == "freeze"){
					btn._offsetx = -270;
					btn._xsize = 270;
				}
				btn._canrapidfire = true;
				
				btn = instance_create_depth(0, 0, 0, obj_menuclickable);
				btn._parentbtn = self;
				btn._offsetx = 192;
				btn._offsety = 95;
				btn._xsize = 85;
				btn._ysize = 75;
				btn._action = "right-"+_id;
				if(_id == "scr"){
					btn._offsetx = 229;
				}
				if(_id == "inptype"){
					btn._offsetx = 210;
					btn._action = "change-inp";
				}
				if(_id == "freeze"){
					btn._offsetx = 280;
					btn._xsize = 270;
				}
				btn._canrapidfire = true;
			}
		
			_init = true;
		}
	
		_showbtn = false;
		if(!_pausebtn && _optionsobj._show && _optionsobj._state == _state){
			_showbtn = true;
		}
		if(_pausebtn){
			if(_optionsobj._state == "main" || _optionsobj._state == "confirm"){
				if(_optionsobj._state == _state){
					_showbtn = true;
				}
			}
		}
	
		if(_dispbox[0] <= WIDTH && _dispbox[2] >= 0 && _dispbox[1] <= HEIGHT && _dispbox[3] >= 0){
			if(_showbtn){
				_btnonscreen = true;
			} else {
				_btnonscreen = false;
			}
		} else {
			_btnonscreen = false;
		}
	
		var widthsize = false;
		if(global._res[global._curres][0] >= WIDTH){
			widthsize = true;
		}
	
		if(global._buildver == HTML || widthsize){
			_btnonscreen = true;
		
			_dosurfacestuff = false;
			_surfaceoffs = [0,0];
		}
	
		if(global._buildver == WINDOWS && !widthsize){
			if(surface_exists(_gui_surface)){
				if(_showbtn){
					if(surface_get_width(_gui_surface) <= 2){
						surface_resize(_gui_surface, round(_dispsize[0]),round(_dispsize[1]));
					}
			
					/*draw_set_alpha(0.5);
					draw_rectangle(_dispbox[0],_dispbox[1],_dispbox[2],_dispbox[3],false);
					draw_set_color(c_red);
					draw_rectangle(_disppos[0],_disppos[1],_disppos[0]+16,_disppos[1]+16, false);
					draw_set_color(c_white);
					draw_set_alpha(1);*/

					_dosurfacestuff = global._full;
					if(global._full){
						_surfaceoffs = [_dispbox[0],_dispbox[1]];
					} else {
						_surfaceoffs = [0,0];
					}

					if(_dosurfacestuff){
						if(_btnonscreen){
							surface_set_target(_gui_surface);
		
							draw_clear_alpha(c_black, 0);
		
							gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
						}
					}
				}
	
				scr_draw_options_btn();
	
				if(_dosurfacestuff && _showbtn && _btnonscreen){
					surface_reset_target();
					gpu_set_blendmode(bm_normal);
		
					//after all the gui stuff is done being drawn, check if resized surface exists
					if(surface_exists(_resizegui_surface)){
						//if the dimensions are too small, resize to the proper resolution
						if(surface_get_width(_resizegui_surface) <= 2){
							_resizegui_size = [round(_dispsize[0]*_scaleparam[0]),round(_dispsize[1]*_scaleparam[1])];
							surface_resize(_resizegui_surface, _resizegui_size[0], _resizegui_size[1]);
						}
						surface_set_target(_resizegui_surface);
			
						//draw all the scaled down gui on this surface
						draw_clear_alpha(c_black, 0);
			
						draw_surface_stretched(_gui_surface, 0, 0, surface_get_width(_resizegui_surface),surface_get_height(_resizegui_surface));
			
						surface_reset_target();
			
						//stretch the ui back, giving it proper scaled look that works with all resolutions
						draw_surface_stretched(_resizegui_surface, _disppos[0], _disppos[1], round(_dispsize[0]), round(_dispsize[1]));
					} else {
						_resizegui_size = [round(_dispsize[0]*_scaleparam[0]),round(_dispsize[1]*_scaleparam[1])];
						_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
					}
				}
			} else {
				_gui_size = [round(_dispsize[0]),round(_dispsize[1])];
				_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
			}
		}
	
		if(global._buildver == HTML || widthsize){
			scr_draw_options_btn();
		}
	
		if(_lastbtn != -1){
			with(obj_options){
				if(_lastbtn[other._lastbtn] == 0){
					_lastbtn[other._lastbtn] = other._starty+_btnscrolloffset;
				}
			}
		}
	}
}