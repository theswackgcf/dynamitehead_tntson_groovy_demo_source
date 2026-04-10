{
	if(_starttimer >= _startval){
		if(_showbg){
			draw_set_color(#000000);
			draw_rectangle(-global._screenSideOffset,-global._screenSideOffset,WIDTH+global._screenSideOffset,HEIGHT+global._screenSideOffset, false);
			draw_set_color(#FFFFFF);
		}
	
		var offset = [WIDTH/2, HEIGHT/2];
		var scaley = 1;
		if(_poster_scaleup > 0){
			scaley = 1.05;
			offset[1] = (HEIGHT/2)+10;
		}
	
		if(_act > 0 && _poster){
			if(!_ripped){
				draw_sprite_ext(spr_wanted, global._location, offset[0], offset[1],_posterscale,_posterscale*scaley,0,c_white,1);
			} else {
				draw_sprite_ext(spr_wanted_ripped, 0, offset[0], offset[1],_posterscale,_posterscale*scaley,0,c_white,1);
			}
		}
	
		if(_act == 1){
			if(_postershow){
				draw_sprite_ext(spr_wanted_appear, _posterframe, offset[0], offset[1],_posterscale,_posterscale,0,c_white,1);
			}
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
		
			if(_act == 2){
				if(_handshow){
					draw_sprite(spr_wanted_dhhand, _handframe, 0, 0);
				}
			}
			if(_act == 3){
				if(_dynamiteshow && _setdir){
					if(!_end_anim){
						draw_sprite_ext(spr_dh_introflip, _dynamiteframe, _xpos, _ypos, _scale*_dir, _scale, 0, c_white, 1);
					} else {
						draw_sprite_ext(spr_dh_introflip_end, _dynamiteframe, _xpos, _ypos, _scale*_dir, _scale, 0, c_white, 1);
					}
				}
			}
	
			shader_reset();
		}
	} else {
		draw_set_color(#000000);
		draw_rectangle(-global._screenSideOffset,-global._screenSideOffset,WIDTH+global._screenSideOffset,HEIGHT+global._screenSideOffset, false);
		draw_set_color(#FFFFFF);
	}
	
	if(_starttimer < _startval+3){
		draw_set_color(#000000);
		draw_rectangle(-global._screenSideOffset,-global._screenSideOffset,WIDTH+global._screenSideOffset,HEIGHT+global._screenSideOffset, false);
		draw_set_color(#FFFFFF);
	}
}