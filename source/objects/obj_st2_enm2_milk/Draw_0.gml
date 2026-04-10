{
	if(_shadowsinit){
		if(ds_map_exists(global._gameshadows,_occupy_id)){
			_shadowmult[0] = clamp(0, _shadsize[0]-(_height/HEIGHT), _shadsize[0]);
			_shadowmult[1] = clamp(0, _shadsize[1]-(_height/HEIGHT), _shadsize[1]);
			global._gameshadows[? _occupy_id][? "draw"] = true;
			global._gameshadows[? _occupy_id][? "x"] = x;
			global._gameshadows[? _occupy_id][? "y"] = y;
			global._gameshadows[? _occupy_id][? "scalex"] = _shadsize[0]*_shadowmult[0];
			global._gameshadows[? _occupy_id][? "scaley"] = _shadsize[1]*_shadowmult[1];
		}
	}
	
	if(_enmtype != -1){
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
				
	if(_alt_tutorial){
		scr_draw_outline(sprite_index,image_index,x+_dispoffset[0],y+_dispoffset[1]-_height,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	}
				
	draw_sprite_ext(sprite_index,image_index,x+_dispoffset[0],y+_dispoffset[1]-_height,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
			
	if(_alt_tutorial){
		scr_textrender_switchfont("dh_font1");
		scr_textrender_halign("center");
		scr_textrender_valign("middle");
		scr_textrender_type(x+_dispoffset[0],y+_dispoffset[1]-_height-110, "keycode@PUNCHkeycode", true, c_white, 1, 1.38,1.38);
		scr_textrender_halign("left");
		scr_textrender_valign("top");
		scr_textrender_switchfont(global._defaultFont);
	}
			
	if(_enmtype != -1){
		shader_reset();
	}
}