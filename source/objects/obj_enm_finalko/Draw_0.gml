{
	if(sprite_exists(sprite_index)){
		if(_enmtype != -1 || _docolors){
			//draw recolored version
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
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale+(sin(_sintimer/3)*0.04), image_yscale+(cos(_sintimer/3)*0.04), 0, #FFFFFF, clamp(0.2,_alpha,1));
		if(_enmtype != -1 || _docolors){
			shader_reset();
		}	
	}
}