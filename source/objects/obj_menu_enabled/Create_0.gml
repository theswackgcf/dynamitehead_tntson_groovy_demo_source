{
	_optionsobj = noone;
	_ampX = 1.4;
	_ampY = 1.2;
	
	_state = 0;
	
	_timer = 0;
	_startx = 0;
	
	_xpos = 0;
	_ypos = 0;
	
	_alpha = 1;
	
	_offsetx = -96;
	_offsety = 24;
	
	_dosurfacestuff = true;
	
	_gui_size = [WIDTH,HEIGHT];
	_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
	
	_resizegui_size = [1,1];
	_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
}