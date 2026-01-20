{
	if(_colorsinit){
		if(_enmtype != -1){
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
	
		draw_sprite_ext(sprite_index,image_index,x,y+_yoffs,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	
		if(_enmtype != -1){
			shader_reset();
		}
	}
}