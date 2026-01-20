{
	if(global._buildver != HTML && global._lightsout){
		if(surface_exists(_surface)){
			surface_set_target(_surface);

			draw_clear_alpha(c_black, 0);

			draw_sprite_ext(spr_gui_whitescreen,image_index,0,0,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
			
			//light
			var dskeys = ds_map_keys_to_array(_instmap);
			for(var i = 0; i < array_length(dskeys); i++){
				if(_instmap[? dskeys[i]][0]){
					draw_sprite_ext(_instmap[? dskeys[i]][1], 0, _instmap[? dskeys[i]][2]-global._cameraX, _instmap[? dskeys[i]][3]-global._cameraY, 1, 1, 0, c_black, 1);
				}
			}
			
			surface_reset_target();
		} else {
			_surface = surface_create(_surfdim[0], _surfdim[1]);
		}
		
		//blendmode
		gpu_set_blendmode(bm_subtract);
		draw_set_alpha(0);
		draw_surface(_surface, x-sprite_get_xoffset(sprite_index), y-sprite_get_yoffset(sprite_index));
		draw_set_alpha(1);
		gpu_set_blendmode(bm_normal);
	} else {
		if(ds_map_size(_instmap) > 0){
			_instmap = ds_map_create();
		}
		draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	}
}