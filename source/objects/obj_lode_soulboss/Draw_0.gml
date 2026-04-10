{
	if(_init){
		if(surface_exists(_drawsurface)){
			surface_set_target(_drawsurface);
			
			draw_clear_alpha(c_black,0);
			
			draw_sprite_stretched_ext(spr_lode_gradient,0,_grad_x,0,_surf_dim[0],_surf_dim[1],c_white,1);
			
			var dskeys = ds_map_keys_to_array(_surf_sprites);
			for(var i = 0; i < array_length(dskeys); i++){
				var curkey = i;
				if(ds_map_exists(_surf_sprites,curkey)){
					var curspr = _surf_sprites[? curkey];
					draw_sprite_ext(curspr.spr,curspr.img,curspr.xx-sprite_xoffset,curspr.yy-sprite_yoffset,1,1,0,curspr.col,1);
				}
			}
			
			surface_reset_target();
		
			scr_lode_project_surface(_drawsurface,x,y);
		} else {
			_drawsurface = surface_create(_surf_dim[0],_surf_dim[1]);
		}
	}
}