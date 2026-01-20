{
	if(!_boxonly){
		_shadowmult = clamp(0, 1-(_height/HEIGHT), 1);
	
		var xscale = 1;
		if(_dir == "l"){
			xscale = -1;
		}
		
		if(_docolors && _inview){
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
				
			draw_sprite_ext(sprite_index, image_index, x, y-_height, image_xscale*xscale, image_yscale, image_angle, image_blend, image_alpha);
			
			shader_reset();
		}
	}
}