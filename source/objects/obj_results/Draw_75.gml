{
	if(global._winscreen){	
		scr_textrender_halign("center");
		scr_textrender_valign("middle");
		if(!_hellyeah){
			if(global._buildver == WINDOWS){
				scr_textrender_switchfont("dh_font4_big");
				scr_textrender_type(850, _winy, "YoU DiD IT");
			} else if(global._buildver == HTML){
				scr_textrender_switchfont("dh_font4");
				scr_textrender_type(850, _winy, "YoU DiD IT", false, c_white, 1, 1.98, 1.98);
			}
		}
			
		if(!_hellyeah){
			if(_winact >= 6){	
				scr_textrender_switchfont("dh_font2_big");
				global._addSpacing = _textspacing[0];
				scr_textrender_type(floor(WIDTH/2)+224, 280, "Great job. Here's your", false, #FFCC00);
						
				var str = string(floor(global._reward));
						
				var doloffsetx = 0;
				if(string_length(str) >= 5){
					for(var i = 0; i < string_length(str)-4; i++){
						doloffsetx -= sprite_get_width(spr_gui_dollarnum)*0.5;
					}
				}
						
				draw_sprite_ext(spr_gui_dollar, 0, (floor(WIDTH/2)-27)+doloffsetx+(sin(random(480))*_addcash_amp), 432+(sin(random(480))*_addcash_amp), _textsize[0]*1.2, _textsize[0]*1.2, 0, #FFFFFF, 1);
						
				var offset = [(floor(WIDTH/2)+106)+doloffsetx, 430];
				for(var i = 0; i < string_length(str)+1; i++){
					if(i > 0){
						draw_sprite_ext(spr_gui_dollarnum, real(string_char_at(str, i)), offset[0]+(i*86)+(sin(random(480))*_addcash_amp), offset[1]+(sin(random(480))*_addcash_amp), _textsize[0], _textsize[0], 0, #FFFFFF, 1);
					} else {
						draw_sprite_ext(spr_gui_dollarnum, 10, offset[0]+(i*86)+(sin(random(480))*_addcash_amp), offset[1]+(sin(random(480))*_addcash_amp), _textsize[0], _textsize[0], 0, #FFFFFF, 1);
					}
				}
			}
					
			var floornum = 560;
			if(_winact >= 7){
				global._addSpacing = _textspacing[1];
				if(global._knockouts > 0){
					var drawspace = "";
					if(_tempKO >= 10){
						drawspace = " ";
					}
					var noun = "times";
					if(_tempKO == 1){
						noun = "time";
					}
					scr_textrender_type(floor(WIDTH/2)+205, floornum, "...But you got /r'NOCKED    /w"+drawspace+noun, false, #FFCC00, 1, 0.8,0.8);
					var drawKO = string(_tempKO)+" ";
					var drawoffset = -16;
					if(_tempKO >= 10){
						drawKO = "9+";
						drawoffset = -30;
					}
					scr_textrender_type(floor(WIDTH/2)+205+drawoffset, floornum+_koHeight, "/i...But you got /r'NOCKED   /i"+drawKO+"/i"+noun, false, #FFCC00, 1, 0.8,0.8);
				} else {
					draw_sprite_ext(spr_guiwintext, 2, floor(WIDTH/2)+180, floornum, _textsize[1], _textsize[1], 0, #FFFFFF, 1);
				}
			}
			
			global._addSpacing = 0;
		} else {
			//HELL YEAH!!!
			if(_winact >= 5){
				scr_textrender_switchfont("dh_font2_big");
				scr_textrender_type(floor(WIDTH/2)+224, 460, "You got 'NOCKED 0 times!\nHere's your", false, #FFCC00, 1, 0.85, 0.85);
				
				var str = string(floor(global._reward));
						
				var doloffsetx = 0;
				if(string_length(str) >= 5){
					for(var i = 0; i < string_length(str)-4; i++){
						doloffsetx -= sprite_get_width(spr_gui_dollarnum)*0.5;
					}
				}
						
				draw_sprite_ext(spr_gui_dollar, 0, (floor(WIDTH/2)+22)+doloffsetx+(sin(random(480))*_addcash_amp), 612+(sin(random(480))*_addcash_amp), 1.2, 1.2, 0, #FFFFFF, 1);
						
				var offset = [floor(WIDTH/2)+130, 610];
				var dlrtext = "";
				var dlrx = 0;
				var dlry = 0;
				for(var i = 0; i < string_length(str)+1; i++){
					dlrx = offset[0]+(i*86);
					dlry = offset[1] + sin((-current_time / 80) + (i * 7.5)) * 10;
					if(i > 0){
						dlrtext = real(string_char_at(str, i));
					} else {
						dlrtext = 10;
					}
					draw_sprite_ext(spr_gui_dollarnum, dlrtext, dlrx+doloffsetx+(sin(random(480))*_addcash_amp), dlry+16+(sin(random(480))*_addcash_amp), 1, 1, 0, #000000, 1);
					draw_sprite_ext(spr_gui_dollarnum, dlrtext, dlrx+doloffsetx+(sin(random(480))*_addcash_amp), dlry+(sin(random(480))*_addcash_amp), 1, 1, 0, #FFFFFF, 1);
				}
			}
		}
			
		if(_addcash_total > 0){
			var drawx = WIDTH-28;
			for(var i = _addcash_total-1; i >= 0; i--){
				draw_sprite_ext(spr_gui_dollar, 0, drawx, HEIGHT-28, 0.45, 0.45, 0, c_white, 1);
				drawx -= 60;
			}
		}
			
		if(_confirmexit){
			scr_textrender_switchfont("dh_font2");
			scr_textrender_halign("left");
			scr_textrender_halign("top");
			var conpos = [20,40];
			if(scr_compareinput("confirm","menu_select")){
				scr_textrender_type(conpos[0], conpos[1], "Press keycode@CONFIRMkeycode to continue", true);
			} else {
				scr_textrender_type(conpos[0], conpos[1], "Press keycode@MENU_SELECTkeycode or keycode@CONFIRMkeycode to continue", true);
			}
		}
			
		scr_textrender_switchfont(global._defaultFont);
		scr_textrender_halign("left");
		scr_textrender_valign("top");
	}
			
	if(_addcash_draw){
		draw_sprite_ext(spr_gui_dollar, 0, _addcash_pos[0],_addcash_pos[1], max(0,_addcash_scale), max(0,_addcash_scale), 0, c_white, 1);
	}
}