{
	if(_drawbg){
		draw_set_color( make_color_rgb(99,97,132) );
		if(_bgwhite){
			draw_set_color(c_white);
			draw_set_alpha(_bgalp);
		}
		draw_rectangle(-32,-32,WIDTH+32,HEIGHT+32,false);
		draw_set_color(c_white);
		draw_set_alpha(1);
	}
	
	if(_colorsinit){
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
	
		if(_zoom <> 0){
			draw_sprite_ext(sprite_index, image_index, x, y, (image_xscale*(_scaleTo*1.15))/_zoom, (image_yscale*(_scaleTo*1.15))/_zoom, 0, #FFFFFF, 1);
		}

		shader_reset();
	}
}