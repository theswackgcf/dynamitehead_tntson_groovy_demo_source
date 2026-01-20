{
	_freeze = 0;
	
	_codename = "";
	_anim = "intro1";
	
	_act = 0;
	_timer = 0;
	
	_vs = false;
	
	sprite_index = asset_get_index("spr_"+_codename+"_"+_anim);
	
	_dosurfacestuff = true;
	
	_gui_size = [WIDTH,HEIGHT];
	_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
	
	_resizegui_size = [1,1];
	_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
}