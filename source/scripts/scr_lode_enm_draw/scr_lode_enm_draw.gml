function scr_lode_enm_draw(){
	draw_sprite(sprite_index,image_index,x,y);
	if(global._debug){
		if(_pathinit){
			var tilesize = 24;
			var offset = [0,0];
			for(var yy = 0; yy < array_length(_path_array); yy++){
				for(var xx = 0; xx < array_length(_path_array[yy]); xx++){
					if(_path_array[yy][xx] != -1 && _path_array[yy][xx] != 0){
						draw_set_alpha(0.22);
						draw_set_color(c_green);
						if(_path_array[yy][xx].closed){
							draw_set_color(c_red);
						}
					
						draw_rectangle((xx*tilesize)+offset[0],(yy*tilesize)+offset[1],(xx*tilesize)+offset[0]+tilesize,(yy*tilesize)+offset[1]+tilesize,false);
						
						scr_textrender_switchfont("dh_fontnes");
						scr_textrender_type((xx*tilesize)+offset[0],(yy*tilesize)+offset[1],string(_path_array[yy][xx].hcost)+"\n"+string(_path_array[yy][xx].gcost)+"\n/y"+string(_path_array[yy][xx].fcost)+"/w");
						scr_textrender_switchfont(global._defaultFont);
					
						draw_set_color(c_white);
						draw_set_alpha(1);
					}
				}
			}
		}
	}
}