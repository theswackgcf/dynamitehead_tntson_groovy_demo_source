{
	if(_active){
		if(!_shadowsinit){
			//shadows
			global._gameshadows[? _occupy_id] = ds_map_create();
			global._gameshadows[? _occupy_id][? "draw"] = false;
			global._gameshadows[? _occupy_id][? "x"] = x;
			global._gameshadows[? _occupy_id][? "y"] = y;
			global._gameshadows[? _occupy_id][? "scalex"] = _shadowsize;
			global._gameshadows[? _occupy_id][? "scaley"] = _shadowsize;
		
			_shadowsinit = true;
		}
	
		_shadowmult = clamp(0, 1-(_height/HEIGHT), 1);
	
		image_xscale = _xscale;
		image_yscale = 1;
	
		if(_codename != ""){
			sprite_index = asset_get_index("spr_"+string(_codename)+"_skull");
		}
	
		_colorblend = c_white;
		if(global._kohit > 0){
			_colorblend = c_black;
		}
	
		if(_shadowsinit){
			if(ds_map_exists(global._gameshadows,_occupy_id)){
				global._gameshadows[? _occupy_id][? "draw"] = true;
				global._gameshadows[? _occupy_id][? "x"] = x;
				global._gameshadows[? _occupy_id][? "y"] = y;
				global._gameshadows[? _occupy_id][? "scalex"] = _shadowsize*_shadowmult;
				global._gameshadows[? _occupy_id][? "scaley"] = _shadowsize*_shadowmult;
			}
		}

		function drawSprite(){
			draw_sprite_ext(sprite_index, image_index, x+_dispoffset[0], (y-_height)+_dispoffset[1], image_xscale, image_yscale, image_angle, _colorblend, image_alpha);
		}

		if(array_contains(global._skullrecolor, _codename) && _difftype){
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
				
			drawSprite();
			
			shader_reset();
		} else {
			//draw default version
			drawSprite();
		}
	} else {
		if(_shadowsinit){
			if(ds_map_exists(global._gameshadows,_occupy_id)){
				global._gameshadows[? _occupy_id][? "draw"] = false;
			}
		}
	}
}