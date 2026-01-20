{
	if(global._buildver == HTML){
		if(_init){
			//draw sprites (HTML)
			draw_set_alpha(0);
			if(_spritedraw != -1){
				draw_sprite(_spritedraw,0,0,0);
			}
			draw_set_alpha(1);
			draw_set_color(#000000);
			draw_rectangle(-245, -256, WIDTH+256, HEIGHT+256, false);
			draw_set_color(#FFFFFF);
		}
	}
	
	if(_init && !_silent){
		//bg
		if(_drawbg){
			draw_sprite_part_ext(_load_spr, _loadbg+2, 0, 0, WIDTH, HEIGHT*_total_progress,0,HEIGHT,1,-1,#FFFFFF,1);
			draw_sprite(_load_spr, _loadbg+1, 0,0);
			draw_sprite_part_ext(_load_spr, _loadbg+0, 0, 0, WIDTH, HEIGHT*_total_progress,0,HEIGHT,1,-1,#FFFFFF,1);
		
			//bar
			draw_sprite(spr_menu_desc, 0, 0, 64);
		}
		
		draw_set_color(c_black);
		draw_rectangle(0,HEIGHT-24-8,WIDTH,HEIGHT,false);
		draw_set_color(#ffb30f);
		draw_rectangle(0,HEIGHT-24,WIDTH*_total_progress,HEIGHT,false);
		draw_set_color(c_white);
		
		scr_textrender_switchfont("dh_font1");
		var top = "";
		var deftop = "Currently loading:\n";
		var curload = "";
		if(_current_pass < 2){
			top = "Currently loading:\n";
		} else {
			if(!_shaders){
				top = "Compiling shaders...";
			}
		}
		if(_current_pass == 0){
			if(array_length(_load_textures) > 0){
				top = deftop;
				curload = "Texture group: "+_load_textures[_assetnum];
			}
		} else if(_current_pass == 1){
			if(array_length(_load_audio) > 0){
				top = deftop;
				curload = "Audio group: "+audio_group_name(_load_audio[_assetnum]);
			}
		}
		var textoffset = -6;
		scr_textrender_valign("bottom");
		scr_textrender_type(12, HEIGHT-24+textoffset,top+curload);
		scr_textrender_valign("top");
		scr_textrender_switchfont(global._defaultFont);
	}
}