// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_adjustguiscale(){
	var scale = [];
	if(global._buildver == HTML){
		scale = [HTML_W,HTML_H];
	
		global._guisizeX = scale[0]/WIDTH;
		global._guisizeY = scale[1]/HEIGHT;
	
		surface_resize(application_surface, WIDTH,HEIGHT);
		display_set_gui_size(HTML_W,HTML_H);
		display_set_gui_maximize(global._guisizeX,global._guisizeY);
	} else {
		if(!global._full){
			scale = [global._res[global._curres][0],global._res[global._curres][1]];
		} else {
			scale = [display_get_width(),display_get_height()];
		}
	
		global._guisizeX = scale[0]/WIDTH;
		global._guisizeY = scale[1]/HEIGHT;
	
		surface_resize(application_surface, global._res[global._curres][0],global._res[global._curres][1]);
		display_set_gui_size(global._res[global._curres][0],global._res[global._curres][1]);
		display_set_gui_maximize(global._guisizeX,global._guisizeY);
	}
}