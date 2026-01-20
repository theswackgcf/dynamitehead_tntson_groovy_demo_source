{
	if(_inview){
		var pos = [
			((sprite_width*0.25)+_windoffset[0]),
			(sprite_height*0.25)+_windoffset[1],
			
			(sprite_width+_windoffset[0]),
			(sprite_width*0.25)+_windoffset[1],
			
			sprite_width,
			sprite_height,
			
			(sprite_width*0.25),
			sprite_height,
		];
		draw_set_color(image_blend);
		if(surface_exists(_surf)){
			surface_set_target(_surf);
			draw_clear_alpha(c_black, 0);
			draw_sprite_pos(sprite_index,_index,pos[0],pos[1],pos[2],pos[3],pos[4],pos[5],pos[6],pos[7],1);
			surface_reset_target();
			var scale = 1.25;
			draw_surface_ext(_surf, x-(sprite_xoffset*scale), y-(sprite_yoffset*scale), scale, scale, 0, image_blend, image_alpha);
		} else {
			_surf = surface_create(sprite_width*1.5,sprite_height*1.5);
		}
		draw_set_color(c_white);
	}
}