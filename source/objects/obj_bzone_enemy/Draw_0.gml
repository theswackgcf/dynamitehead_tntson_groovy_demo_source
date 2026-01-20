{
	depth = -999;
	if(_disp_index != -1){
		if(sprite_index <> _disp_index){
			draw_sprite(sprite_index, _imgindex, x, y);
		}
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
			
			draw_sprite_ext(_disp_index, _imgindex, x, y,image_xscale,image_yscale,0,image_blend,1);
			var type = "undefined";
			if(_spawntype < array_length(_spawntype_array)){
				type = _spawntype_array[_spawntype];
			}
			var fade = "false";
			if(_startFade){ fade = "true" }
			scr_textrender_type(x,y-42,"Order: "+string(_order)+"\nSpawn type: "+type+"\nFade in: "+fade);
			
			if(_enmtype != -1){
				shader_reset();
			}
		}
		
		if(_dir != "c"){
			var angl = 0;
			switch(_dir){
				case "l":
					angl = 0;
				break;
				case "d":
					angl = 90;
				break;
				case "r":
					angl = 180;
				break;
				case "u":
					angl = 270;
				break;
			}
			draw_sprite_ext(spr_bzone_dirs, 0, x, y, 1, 1, angl, image_blend, 1);
		}
		
		draw_set_color(c_aqua);
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true);
		draw_set_color(c_white);
	}
}