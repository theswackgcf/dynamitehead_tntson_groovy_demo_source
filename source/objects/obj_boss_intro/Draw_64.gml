{
	if(global._buildver == WINDOWS){
		_dosurfacestuff = global._full;
	}
	if(global._buildver == HTML){
		_dosurfacestuff = false;
	}
	
	if(global._buildver == WINDOWS){
		if(surface_exists(_gui_surface)){
			if(_dosurfacestuff){
				surface_set_target(_gui_surface);
		
				draw_clear_alpha(c_black, 0);
		
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
			}
		
			if(global._seteffect > 0){
				switch(global._effect){
					case EFFECT_SEPIA:
						shader_set(shd_sepia);
						shader_set_uniform_f(shader_get_uniform(shd_sepia, "u_SepiaAmount"), 1);
					break;
				}
			}
	
			var camzoom = instance_find(obj_camera,0)._cameraZoom;
			if(camzoom <> 0){
				if(sprite_exists(sprite_index)){
					draw_sprite_ext(sprite_index, image_index, (x-(global._cameraX))/camzoom, (y-(global._cameraY))/camzoom, image_xscale/camzoom, image_yscale/camzoom, 0, #FFFFFF, 1);
				}
			}
	
			if(global._seteffect > 0){
				shader_reset();
			}
			
			if(_dosurfacestuff){
				scr_surface_fullscreen_resolution();
			}
		} else {
			_gui_size = [WIDTH,HEIGHT];
			_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
		}
	}
	
	if(global._buildver == HTML){
		if(global._seteffect > 0){
			switch(global._effect){
				case EFFECT_SEPIA:
					shader_set(shd_sepia);
					shader_set_uniform_f(shader_get_uniform(shd_sepia, "u_SepiaAmount"), 1);
				break;
			}
		}
	
		var camzoom = instance_find(obj_camera,0)._cameraZoom;
		if(camzoom <> 0){
			if(sprite_exists(sprite_index)){
				draw_sprite_ext(sprite_index, image_index, (x-(global._cameraX))/camzoom, (y-(global._cameraY))/camzoom, image_xscale/camzoom, image_yscale/camzoom, 0, #FFFFFF, 1);
			}
		}
	
		if(global._seteffect > 0){
			shader_reset();
		}
	}
}