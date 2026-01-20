{
	if(_displayselect && !_end){
		//bg
		_bgtint = merge_colour(_bgtint, _stages[_curoption].tint, 0.05);
		draw_sprite_ext(spr_menu_stageselect_bg, 0, 0, 0, 1, 1, 0, _bgtint, _bg_alp);
		
		scr_textrender_switchfont("dh_fontmenu1");
		scr_textrender_halign("center");
		global._addSpacing = 9;
		scr_textrender_wave_y(5, 1.5);
		scr_textrender_type(floor(WIDTH/2), 42, "MAKE A CHOICE", false, c_white, _other_alp, 0.6, 0.6);
		scr_textrender_wave_y(0, 0);
		global._addSpacing = 0;
		scr_textrender_halign("left");
		scr_textrender_switchfont(global._defaultFont);
		
		//stages
		if(_showstages){
			var drawx = floor(WIDTH/2);
			var drawx_left = drawx - (sprite_get_width(spr_menu_stageframe)/2);
			var drawy = (floor(HEIGHT/2)+64) - ((sprite_get_height(spr_menu_stageframe)*_stscale)/2) * (array_length(_stages)-1);
			var drawy_offset = (sprite_get_height(spr_menu_stageframe)*_stscale)/2;
			var drawy_top = drawy-drawy_offset;
			
			_optionhovered = false;
			for(var i = 0; i < array_length(_stages); i++){
				if(scr_mousehover(drawx_left, drawy_top, drawx_left+sprite_get_width(spr_menu_stageframe), drawy_top + (sprite_get_height(spr_menu_stageframe)*_stscale))){
					if(_mouseactive){
						_curoption = i;
					}
					_optionhovered = true;
				}
				
				var col = #333333;
				var wave = [0,0];
				if(_input_active && _curoption == i){
					col = c_white;
					wave = [3,5];
				}
				
				if(surface_exists(_stages[i].surf)){
					surface_set_target(_stages[i].surf);
					draw_clear_alpha(c_black, 0);
					
					//scrolling stage
					for(var j = 0; j < sprite_get_info(_stages[i].bg[0]).num_subimages; j++){
						draw_sprite_ext(_stages[i].bg[0], j, _stages[i].bg[1][0], _stages[i].bg[1][1], _stages[i].bg[2], _stages[i].bg[2], 0, col, 1);
					}
					
					//parallax back
					var par1s = 0.4;
					var par1w = (sprite_get_width(_stages[i].parallax[0])-12)*par1s;
					
					if(_curoption == i){
						_stages[i].scroll_1_pos -= _scrollspd*0.5;
						if(_stages[i].scroll_1_pos <= -par1w){
							_stages[i].scroll_1_pos = 0;
						}
					}
					
					for(var p = 0; p < 3; p++){
						draw_sprite_ext(_stages[i].parallax[0], 0, (par1w*p)+_stages[i].scroll_1_pos, 0, par1s, par1s, 0, col, 1);
					}
					
					//parallax front
					var par2s = 0.4;
					var par2w = (sprite_get_width(_stages[i].parallax[1][0])+_stages[i].parallax[1][1][0])*par2s;
					
					if(_curoption == i){
						_stages[i].scroll_2_pos -= _scrollspd;
						if(_stages[i].scroll_2_pos <= -par2w){
							_stages[i].scroll_2_pos = 0;
						}
					}
					
					for(var p = 0; p < 3; p++){
						draw_sprite_ext(_stages[i].parallax[1][0], 0, (par2w*p)+_stages[i].scroll_2_pos, _stages[i].parallax[1][1][1], par2s, par2s, 0, col, 1);
					}
					
					surface_reset_target();
					
					draw_surface(_stages[i].surf, drawx_left+_surfoffset[0], drawy_top+_surfoffset[1]);
				} else {
					_stages[i].surf = surface_create(_surfsize[0],_surfsize[1]);
				}
				
				//stage frame
				draw_sprite_ext(spr_menu_stageframe, floor(_stageframeind+i), drawx, drawy, 1, _stscale, 0, col, 1);
				
				//stage title
				scr_textrender_wave_x(wave[0],wave[1]);
				scr_textrender_wave_y(wave[0],wave[1]);
				scr_textrender_switchfont("dh_font4");
				scr_textrender_type(drawx_left, drawy_top-16, _stages[i].title, true, col, 1, 0.65, 0.65);
				scr_textrender_wave_x(wave[0]*0.4,wave[1]);
				scr_textrender_wave_y(wave[0]*0.4,wave[1]);
				scr_textrender_type(drawx_left, drawy_top+42, _stages[i].subtitle, true, col, 1, 0.4, 0.4);
				scr_textrender_switchfont(global._defaultFont);
				scr_textrender_wave_x(0,0);
				scr_textrender_wave_y(0,0);
				
				drawy += sprite_get_height(spr_menu_stageframe)*_stscale;
				drawy_top = drawy-drawy_offset;
			}
		}
		
		draw_sprite_ext(spr_menu_desc,0,0,64,1,1,0,c_white,_other_alp);
		scr_textrender_switchfont("dh_font1");
		scr_textrender_halign("center");
		scr_textrender_valign("middle");
		scr_textrender_type(floor(WIDTH/2), HEIGHT-50, _stages[_curoption].desc, true, c_white, _other_alp);
		scr_textrender_halign("left");
		scr_textrender_valign("top");
		scr_textrender_switchfont(global._defaultFont);
		
		if(_staticact > -1){
			draw_sprite_ext(spr_menu_stagestatic, floor(_staticind), floor(WIDTH/2),floor(HEIGHT/2), 1, _staticscale, 0, c_white, 1);
		}
		
		if(scr_compareinput("pause","menu_back")){
			scr_textrender_type(24+global._screenOffsetX, 24+global._screenOffsetY, "keycode@PAUSEkeycode - Back", false, c_white, _other_alp);
		} else {
			scr_textrender_type(24+global._screenOffsetX, 24+global._screenOffsetY, "keycode@MENU_BACKkeycode / keycode@PAUSEkeycode - Back", false, c_white, _other_alp);
		}
		
		if(_back){
			draw_set_color(c_black);
			draw_rectangle(-global._screenSideOffset,-global._screenSideOffset,WIDTH+global._screenSideOffset,HEIGHT+global._screenSideOffset, false);
			draw_set_color(c_white);
			
			draw_sprite_ext(spr_menu_stagestatic, floor(_staticind), floor(WIDTH/2),floor(HEIGHT/2), 1, 1, 0, c_white, 1);
		}
	}
}