{
	if(_parentobj != noone && instance_exists(_parentobj)){
		if(global._kohit > 0){
			image_blend = c_black;
			_spblend = c_black;
		} else {
			image_blend = _hpcolor;
			_spblend = c_white;
		}
		draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
		var ind = -1;
		if(ds_map_exists(_enemyicons, _codename)){
			ind = _enemyicons[? _codename];
		}
		if(ind != -1){
			var spscale = 1;
			if(floor(image_index) == 0){
				spscale = 1.2;
			}
			if(floor(image_index) == 1){
				spscale = 0.9;
			}
			var multscale = 1;
			if(_dir == "l"){
				multscale = -1;
			}
			
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
				
			draw_sprite_ext(spr_gui_enemynear_icons,ind,x,y,image_xscale*spscale*multscale,image_yscale*spscale,0,_spblend,image_alpha);
			
			if(_enmtype != -1){
				shader_reset();
			}
		}
	}
}