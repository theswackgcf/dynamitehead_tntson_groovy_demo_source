{
	sprite_index = spr_dh_idle;
	
	var drawX = WIDTH / 2;
	var drawY = HEIGHT / 1.25;
	
	draw_set_color(#222222);
	draw_rectangle(0,0,WIDTH,HEIGHT,false);
	draw_set_color(#FFFFFF);
	
	if(_init){
		var _shdr = asset_get_index("shd_replace_col");
		if(global._buildver == HTML){
			_shdr = asset_get_index("shd_replace_col"+string(global._maxcolors[? _entities[_curent]]));
		}
		
		shader_set(_shdr);

		shader_set_uniform_i(shader_get_uniform(_shdr, "maxcolors"), global._maxcolors[? _entities[_curent]]);
		shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorIn"), _mult_colorinArray);
		shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorOut"), _mult_coloroutArray);
		shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorTolerance"), _mult_tolrArray);
		shader_set_uniform_f_array(shader_get_uniform(_shdr, "blend"), _mult_blendArray);
	
		sprite_index = asset_get_index("spr_"+_entities[_curent]+"_idle");
		draw_sprite_ext(sprite_index, image_index, drawX, drawY, _zoom, _zoom, 0, #FFFFFF, 1);
		
		if(ds_map_exists(_addsprite, _entities[_curent])){
			draw_sprite_ext(_addsprite[? _entities[_curent]], 0, drawX+320, drawY, _zoom, _zoom, 0, #FFFFFF, 1);
		}
	
		shader_reset();
		
		//draw color squares
		for(var i = 0; i < floor(array_length(_mult_colorinArray)/4); i++){
			drawrect(i*16, 48, i*4, 0);
		}
		for(var i = 0; i < floor(array_length(_mult_coloroutArray)/4); i++){
			drawrect(i*16, 64, i*4, 1);
		}
		
		scr_textrender_valign("bottom");
		var ind = min(_curname*4,12);
		draw_set_color(#FFFF00);
		draw_rectangle((_curtolindex*48), HEIGHT-136, (_curtolindex*48)+16, (HEIGHT-136+48),false);
		draw_set_color(#FFFFFF);
		scr_textrender_type(24, HEIGHT-128, "TOLERANCE:\n"+string(_mult_tolrArray[ind])+","+string(_mult_tolrArray[ind+1])+","+string(_mult_tolrArray[ind+2])+","+string(_mult_tolrArray[ind+3]));
		scr_textrender_type(24, HEIGHT-24, "BLEND:\n"+string(_mult_blendArray[ind])+","+string(_mult_blendArray[ind+1])+","+string(_mult_blendArray[ind+2])+","+string(_mult_blendArray[ind+3]));
		scr_textrender_valign("top");
	}

	scr_textrender_halign("right");
	scr_textrender_type(WIDTH-64, 64, "FPS:"+string(fps));
	scr_textrender_halign("center");
	scr_textrender_type(WIDTH/2, 64, _names[? _entities[_curent]][_curname][1]);
	scr_textrender_type(floor(WIDTH/2), HEIGHT-64, "COLOR TEST", true);
	scr_textrender_halign("left");
	scr_textrender_valign("top");
}