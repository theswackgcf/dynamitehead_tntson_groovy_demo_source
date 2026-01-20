{
	if(surface_exists(_surface)){
		if(surface_exists(_tempsurf)){
			surface_set_target(_surface);
		
			draw_clear_alpha(c_black, 0);
		
			//set up temp surface and draw the screen on it for later
			surface_set_target(_tempsurf);
			draw_surface_ext(application_surface,0,0,global._appsurfScale,global._appsurfScale,0,c_white,1);
			surface_reset_target();
						
			shader_set(shd_stylized_light);
			
			//get texture from earlier surface
			var app_surf = _tempsurf;
			texture_set_stage(shader_get_sampler_index(shd_stylized_light, "backgroundTex"), surface_get_texture(app_surf));
			
			//draw lights
			var dskeys = ds_map_keys_to_array(global._groovylights);
			for(var i = 0; i < array_length(dskeys); i++){
				if(ds_map_exists(global._groovylights,dskeys[i])){
					if(global._groovylights[? dskeys[i]][? "draw"]){
						draw_sprite_ext(spr_lightsource, 0, global._groovylights[? dskeys[i]][? "x"]-global._cameraX,global._groovylights[? dskeys[i]][? "y"]-global._cameraY,global._groovylights[? dskeys[i]][? "scalex"],global._groovylights[? dskeys[i]][? "scaley"], 0, make_color_rgb(255,255,0), 1);
					}
				}
			}
			
			shader_reset();
			
			surface_reset_target();
		
			//draw the final result onto the screen
			draw_surface_ext(_surface, global._cameraX, global._cameraY, 1, 1, 0, c_white, 1);
		} else {
			_tempsurf = surface_create(_surfdim[0],_surfdim[1]);
		}
	} else {
		_surface = surface_create(_surfdim[0],_surfdim[1]);
	}
}