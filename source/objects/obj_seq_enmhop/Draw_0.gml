{
	//draw recolored version
	if(_colorsinit){
		if(_docolors || (ds_map_exists(global._enemyColors, _codename) && _enmtype != -1)){
			var _shdr = asset_get_index("shd_replace_col");
			if(global._buildver == HTML){
				_shdr = asset_get_index("shd_replace_col"+string(_maxcolors));
			}
			
			shader_set(_shdr);
				
			shader_set_uniform_i(shader_get_uniform(_shdr, "maxcolors"), _maxcolors);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorIn"), _mult_colorinArray);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorOut"), _mult_coloroutArray);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorTolerance"), _mult_tolrArray);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "blend"), _mult_blendArray);
		}
	
		//set color of sprite
		var blend = make_color_rgb(_fadeCol[0],_fadeCol[1],_fadeCol[2]);
		if(global._kohit > 0){
			blend = c_black;
		}
	
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, blend, image_alpha);

		if(_docolors || (ds_map_exists(global._enemyColors, _codename) && _enmtype != -1)){
			shader_reset();
		}
	}
}