{	
	switch(global._location){
		case 0:
			draw_set_color(#0C2720); //stage 1 bg color
		break;
		case 1:
			draw_set_color(#373470); //stage 2 bg color
		break;
	}
	draw_rectangle(0, 0, WIDTH, HEIGHT, false);
	draw_set_color(#FFFFFF);
	
	gpu_set_texrepeat(true);
	shader_set(shd_wavy);
	shader_set_uniform_f(t, _timer);
	switch(global._location){
		case 0:
			//shader_set_uniform_f(aX, 0.015);
			//shader_set_uniform_f(aY, 0.015);
			//shader_set_uniform_f(s, 0.07);
			//shader_set_uniform_f(fX, 120);
			//shader_set_uniform_f(fY, 120);
		
			//draw_sprite(spr_lv1_bg1, 0, _xpos, HEIGHT/2);
			//draw_sprite(spr_lv1_bg1, 0, _xpos+2000, HEIGHT/2);
		break;
		case 1:
			shader_set_uniform_f(aX, 0.007);
			shader_set_uniform_f(aY, 0.007);
			shader_set_uniform_f(s, 0.05);
			shader_set_uniform_f(fX, 40);
			shader_set_uniform_f(fY, 40);
		
			if(global._buildver != HTML){
				for(var b = 0; b < 5; b++){
					draw_sprite_ext(spr_lv2_bg1, b, _xpos, (HEIGHT/2)-720, 2, 2, 0, c_white, 1);
				}
			} else {
				draw_sprite_ext(spr_lv2_bg1_html, 0, _xpos, (HEIGHT/2)-720, 2, 2, 0, c_white, 1);
			}
		break;
	}
	shader_reset();
	gpu_set_texrepeat(false);
	
	var sp = -1;
	
	switch(global._location){
		case 0:
			sp = spr_lv2intro_bg;
		break;
		case 1:
			sp = spr_lv2intro_bg;
		break;
	}
	
	draw_sprite(sp, 0, _bgpos[0], 0);
	draw_sprite(sp, 0, _bgpos[0]+WIDTH, 0);
	draw_sprite(sp, 1, _bgpos[1], 0);
	draw_sprite(sp, 1, _bgpos[1]+WIDTH, 0);
	
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
		
		draw_sprite_ext(spr_dh_intro1, floor(_dhframe) % sprite_get_info(spr_dh_intro1).num_subimages, _dhpos, (HEIGHT-260)+sin(_dhtime / 12)*(sin(_dhtime/12)*28), 1.22, 1.22, 0, #FFFFFF, 1);
	
		shader_reset();
	}
}