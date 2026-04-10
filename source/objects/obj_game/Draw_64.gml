{
	draw_set_color(#000000);
	draw_rectangle(-global._screenSideOffset, -global._screenSideOffset, WIDTH+global._screenSideOffset, HEIGHT+global._screenSideOffset, false);
	draw_set_color(#FFFFFF);
	
	if(global._seteffect > 0){
		switch(global._effect){
			case EFFECT_SEPIA:
				shader_set(shd_sepia);
				shader_set_uniform_f(shader_get_uniform(shd_sepia, "u_SepiaAmount"), 1);
			break;
			case EFFECT_CONTRAST:
				if(global._kdeffect){
					shader_set(shd_highcontrast);
					shader_set_uniform_f(shader_get_uniform(shd_highcontrast, "contrast"), global._contrasthit_val);
				}
			break;
		}
		
		if(!global._pause){
			global._seteffect --;
		}
	}
	
	draw_surface_stretched(application_surface, global._screenOffsetX, global._screenOffsetY, WIDTH, HEIGHT);
	
	if(global._seteffect > 0 || global._contrasthit > 0){
		shader_reset();
	}
	
	if(variable_global_exists("_kohit_after") && global._kohit_after > 0){
		if(!global._pause){
			global._kohit_after --;
		}
		if(global._state == "game"){
			draw_set_color(#000000);
			draw_rectangle(-global._screenSideOffset, -global._screenSideOffset, WIDTH+global._screenSideOffset, HEIGHT+global._screenSideOffset, false);
			draw_set_color(#FFFFFF);
		}
	}
	
	if(global._fadeout){
		draw_set_color(#000000);
		draw_set_alpha(clamp(0,global._fadeout_alp,1));
		draw_rectangle(-global._screenSideOffset, -global._screenSideOffset, WIDTH+global._screenSideOffset, HEIGHT+global._screenSideOffset, false);
		draw_set_alpha(1);
		draw_set_color(#FFFFFF);
	}
	
	if(global._drawBlackScreen > 0){
		draw_set_color(#000000);
		draw_rectangle(-global._screenSideOffset, -global._screenSideOffset, WIDTH+global._screenSideOffset, HEIGHT+global._screenSideOffset, false);
		draw_set_color(#FFFFFF);
	}
}