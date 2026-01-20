function scr_surface_fullscreen_resolution(){
	surface_reset_target();
	gpu_set_blendmode(bm_normal);
		
	//after all the gui stuff is done being drawn, check if resized surface exists
	if(surface_exists(_resizegui_surface)){
		//if the dimensions are too small, resize to the proper resolution
		if(surface_get_width(_resizegui_surface) <= 1){
			surface_resize(_resizegui_surface, global._res[global._curres][0],global._res[global._curres][1]);
		}
		surface_set_target(_resizegui_surface);
			
		//draw all the scaled down gui on this surface
		draw_clear_alpha(c_black, 0);
			
				
		draw_surface_stretched(_gui_surface, 0, 0, surface_get_width(_resizegui_surface),surface_get_height(_resizegui_surface));
			
		surface_reset_target();
			
		//stretch the ui back, giving it proper scaled look that works with all resolutions
		draw_surface_stretched(_resizegui_surface, 0, 0, WIDTH, HEIGHT);
	} else {
		_resizegui_size = [global._res[global._curres][0],global._res[global._curres][1]];
		_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
	}
}