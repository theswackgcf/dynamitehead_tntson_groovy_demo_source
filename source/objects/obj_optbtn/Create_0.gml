{
	_allsounds = ds_map_create();
	
	_optionsobj = noone;
	
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
	
	_init = false;
	
	_showbtn = false;
	_btnonscreen = false;
	_dispbox = [_xpos-1,_xpos+1,_ypos-1,_ypos+1];
	_dispsize = [2,2];
	_disppos = [_xpos,_ypos];
	_surfaceoffs = [_xpos, _ypos];
	
	_scaleparam = [1,1];
	
	_lastbtn = -1;
	
	_dosurfacestuff = true;
	
	_gui_size = [1,1];
	_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
	
	_resizegui_size = [1,1];
	_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
}