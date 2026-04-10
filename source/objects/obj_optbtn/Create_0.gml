{
	_allsounds = ds_map_create();
	
	_optionsobj = noone;
	
	_getwidth = false;
	_getsize = false;
	
	_xpos = 0;
	_ypos = 0;
	
	_starty = _ypos;
	
	_text = "";
	_opt = 0;
	
	_id = "";
	_input = "";
	_desc = "";
	
	_state = "";
	_layer = 0;
	
	_maintextscale = 1;
	
	_multpl = [1,1];
	_xsize = 0;
	_ysize = 0;
	
	_bbox = [];
	_stretchleft = 0;
	_stretchright = 0;
	_stretchbottom = 0;
	
	_action = "";
	
	_on = false;
	_hover = false;
	
	_inifile = "settings";
	
	_pausebtn = false;
	_menubtn = false;
	
	_init = false;
	
	_unavailable = false;
	
	_showbtn = false;
	_btnonscreen = false;
	_dispbox = [_xpos-1,_xpos+1,_ypos-1,_ypos+1];
	_dispsize = [2,2];
	_disppos = [_xpos,_ypos];
	_surfaceoffs = [_xpos, _ypos];
	
	_scaleparam = [1,1];
	
	_lastbtn = -1;
}