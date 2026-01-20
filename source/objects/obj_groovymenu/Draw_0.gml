{
	if(_displaymenu){
		scr_textrender_shake(0,0);
	
		switch(_menustate){
			case "main":
				var topoffset = HEIGHT / 2 + 108;
				var btnspacing = 150;
			
				_lerpedoption = lerp(_lerpedoption, _option, 0.15);
				var vertoffset = (1 - _lerpedoption * btnspacing) + btnspacing;
			
				//bg stuff
				var bgsprite = spr_lv2_bg1;
				if(global._buildver == HTML){
					bgsprite = spr_lv2_bg1_html;
				}
				for(var j = 0; j < 2; j++){
					for(var i = 0; i < sprite_get_info(bgsprite).num_subimages; i++){
						if(bgsprite == spr_lv2_bg1){
							_bgrot[i] += _bgspd[i];
						}
						if(global._buildver != HTML){
							if(j == 1 && i >= sprite_get_info(bgsprite).num_subimages-1) continue;
						}
						draw_sprite_ext(bgsprite,i,640,(360+((j-1)*(sprite_get_height(bgsprite)*1.6)))+_mainmenuoffset,0.9,0.9,_bgrot[i],c_white,1);
					}
				}
				//pan effect
				draw_sprite_ext(spr_menu_pandown1, 0, 640, (-2360+_mainmenuoffset) + vertoffset, 1, 1, 0, c_white, 1);
				draw_sprite_ext(spr_menu_pandown1, 0, 640, (-500+_mainmenuoffset) + vertoffset, 1, -1, 0, c_white, 1);
				
				draw_sprite_ext(spr_menu_pandown2, 0, 640, (-1860+_mainmenuoffset) + vertoffset, 1.35, 1, 0, c_white, 1);
				
				draw_sprite_ext(spr_menu_bg2, 0, 0, (-600+_mainmenuoffset) + (vertoffset*0.7), 1, 1, 0, c_white, 1);
				draw_sprite_ext(spr_menu_bg2, 1, 0, (-700+_mainmenuoffset) + vertoffset, 1, 1, 0, c_white, 1);
				
				//top menu
				var centerpos = -_mainmenuoffset_start + 180;
				draw_sprite_ext(spr_menulogo, 0, floor(WIDTH/2), ((centerpos-128)+_mainmenuoffset) + vertoffset, 0.85, 0.85, 0, c_white, 1);
				draw_sprite_ext(spr_demologo, 0, floor(WIDTH/2), ((centerpos+107)+_mainmenuoffset) + vertoffset, 0.8, 0.8, 0, c_white, 1);
				scr_textrender_switchfont("dh_font2_big");
				scr_textrender_halign("center");
				scr_textrender_valign("middle");
				scr_textrender_type(floor(WIDTH/2), ((centerpos+247)+_mainmenuoffset) + vertoffset, "PRESS ANY KEY", true, c_white, _anykey_alp, 0.7*_anykey_scale, 0.7*_anykey_scale);
				scr_textrender_halign("left");
				scr_textrender_valign("top");
				scr_textrender_switchfont(global._defaultFont);
			
				//dh
				draw_sprite_ext(spr_groovymenu_dh_shadow, 0, 1030, 700 + vertoffset + _mainmenuoffset, 1, 1, 0, c_white, 1);
				draw_sprite_ext(_dhsprite, floor(_dhindex), 1030, 700 + vertoffset + _mainmenuoffset, 1, 1, 0, c_white, 1);
			
				//wall
				draw_sprite_ext(spr_menu_wall, 0, 0, -160 + vertoffset + _mainmenuoffset, 1, 1.18, 0, c_white, 1);
			
				//logo
				draw_sprite_ext(spr_menulogo, 0, 280, 0 + vertoffset + _mainmenuoffset, 0.7, 0.7, 0, c_white, 1);
				draw_sprite_ext(spr_demologo, 0, 280, 190 + vertoffset + _mainmenuoffset, 0.6, 0.6, 0, c_white, 1);
			
				//buttons
				_optionhovered = false;
				for(var i = array_length(_btninfo)-1; i >= 0; i--){
					var col = make_color_rgb(51, 3, 17);
					var sine = 0;
					var ind = "1";
					var xoffset = -50;
					if(_option == i){
						col = c_white;
						sine = 5;
						ind = "2";
					
						scr_textrender_shake(0, 2);
						scr_textrender_wave_x(sine, 10);
						scr_textrender_wave_y(sine, 10);
					}
					var text = _btninfo[i][1];
					var xx = 252 + _btninfo[i][2] + xoffset;
					var yy = topoffset + (1 - _lerpedoption * btnspacing) + btnspacing * i;
				
					scr_textrender_halign("center");
					scr_textrender_valign("middle");
				
					if(global._timer % 5 < 2){
						scr_textrender_switchfont("dh_fontmenu1");
					} else {
						scr_textrender_switchfont("dh_fontmenu"+ind);
					}
				
					//draw menu icon
					if(_option != i){
						drawbtn(xx, yy, text, col, i);
					} else {
						if(surface_exists(_menubtn_surface)){
							surface_set_target(_menubtn_surface);
							draw_clear_alpha(c_black, 0);
						
							drawbtn(xx, yy, text, col, i);
						
							surface_reset_target();
						
							draw_surface_ext(_menubtn_surface, _enteroffset[0]+(sin(random(480))*_enteramp), _enteroffset[1]+(sin(random(480))*_enteramp), _enterscale[0], _enterscale[1], _enterangle, c_white, 1);
						} else {
							_menubtn_surface = surface_create(WIDTH, HEIGHT);
						}
					}
				
					//check hover
					var boxx = xx - scr_textrender_width(text) / 2;
					var boxy = yy - scr_textrender_height(text) / 2;
					if(_doinput){
						if(!_enter && point_in_rectangle(mouse_x, mouse_y, boxx, boxy, boxx + scr_textrender_width(text), boxy + scr_textrender_height(text))){
							if(_mouseactive){
								_option = i;
							}
							_optionhovered = true;
						}
					}
				
					scr_textrender_halign("left");
					scr_textrender_valign("top");
					scr_textrender_switchfont(global._defaultFont);
				}
			
				scr_textrender_switchfont("dh_font2_big");
				scr_textrender_halign("right");
				scr_textrender_valign("top");
			
				global._addSpacing = 3;
				scr_textrender_type(WIDTH - 8, 8, "swackygames - 2026", true, c_white, 1, 0.6,0.6);
			
				scr_textrender_halign("right");
				scr_textrender_valign("bottom");
			
				scr_textrender_type(WIDTH - 8, HEIGHT - 8, string_upper(global._version), true, c_white, 1, 0.6,0.6);
				global._addSpacing = 0;
				
				scr_textrender_switchfont(global._defaultFont);
			break;
			case "manual":
				draw_sprite(spr_menu_settingbg, 0, 0, 0);
				
				//draw manual
				if(_init){
					draw_sprite_ext(_manual_imgs[_manual_page], 0, floor(WIDTH/2),floor(HEIGHT/2)+_manual_offset, 0.85,0.85,0,c_white,1);
				}
				
				scr_textrender_halign("left");
				scr_textrender_valign("top");
				scr_textrender_switchfont("dh_font1");
			
				if(scr_compareinput("pause","menu_back")){
					scr_textrender_type(24, 24, "keycode@PAUSEkeycode - Back");
				} else {
					scr_textrender_type(24, 24, "keycode@MENU_BACKkeycode / keycode@PAUSEkeycode - Back");
				}
				
				scr_textrender_shake(3);
				if(_manual_page > 0){
					scr_textrender_type(225, floor(HEIGHT/2), "keycode@LEFTkeycode");
				}
				if(_manual_page < array_length(_manual_imgs)-1){
					scr_textrender_type(WIDTH-276, floor(HEIGHT/2), "keycode@RIGHTkeycode");
				}
				scr_textrender_shake(0);
				
				scr_textrender_switchfont(global._defaultFont);
			break;
			case "credits":
				draw_sprite(spr_menu_settingbg, 0, 0, 0);
		
				//draw all the credit stuff
				for(var i = 0; i < array_length(_creditsinfo); i++){
					for(var j = 0; j < array_length(_creditsinfo[i]); j++){
						var curelem = _creditsinfo[i][j];
						if(curelem._type == "spr"){
							draw_sprite(curelem.sprite, curelem.ind, curelem.pos[0]+_creditsoffset[i]+_creditscuroffset, curelem.pos[1]);
						} else if(curelem._type == "text"){
							scr_textrender_switchfont(curelem.font);
							scr_textrender_halign(curelem.align[0]);
							scr_textrender_valign(curelem.align[1]);
							
							scr_textrender_type(curelem.pos[0]+_creditsoffset[i]+_creditscuroffset,curelem.pos[1],curelem._text, false, c_white, 1, curelem.scale, curelem.scale);
							
							scr_textrender_halign("left");
							scr_textrender_valign("top");
							scr_textrender_switchfont(global._defaultFont);
						}
					}
				}
		
				scr_textrender_halign("left");
				scr_textrender_valign("top");
				scr_textrender_switchfont("dh_font1");
			
				if(scr_compareinput("pause","menu_back")){
					scr_textrender_type(24, 24, "keycode@PAUSEkeycode - Back");
				} else {
					scr_textrender_type(24, 24, "keycode@MENU_BACKkeycode / keycode@PAUSEkeycode - Back");
				}
				
				scr_textrender_shake(3);
				if(_creditsoption > 0){
					scr_textrender_type(48, HEIGHT-96, "keycode@LEFTkeycode");
				}
				if(_creditsoption < array_length(_creditsinfo)-1){
					scr_textrender_type(WIDTH-96, HEIGHT-96, "keycode@RIGHTkeycode");
				}
				scr_textrender_shake(0);
				
				scr_textrender_switchfont(global._defaultFont);
			break;
		}
		
		if(_menustate == "main" && _introact == -1 && _changedinput){
			var whichkey;
			if(global._inptype == 0){
				whichkey = vk_escape;
			} else if(global._inptype == 1){
				whichkey = gp_select;
			}
			var textinput = "Default input has been changed.\nHold "+key_to_string(whichkey)+" to reset your input";
			var drawpos = [4,HEIGHT-4];
			scr_textrender_switchfont("dh_font1");
			scr_textrender_halign("left");
			scr_textrender_valign("bottom");
			scr_textrender_type(drawpos[0],drawpos[1],textinput,true,c_white,1,0.55,0.55);
			scr_textrender_switchfont(global._defaultFont);
			
			if(_changehold > 0){
				var rectpos = [4,HEIGHT-64];
				draw_set_color(#000000);
				draw_rectangle(rectpos[0], rectpos[1], 260, rectpos[1]+18, false);
				draw_set_color(#FFFF00);
				draw_rectangle(rectpos[0], rectpos[1], rectpos[0]+((_changehold/60)*256), rectpos[1]+18, false);
			}
			
			scr_textrender_valign("top");
		}
		
		if(_menustate == "main"){
			if(global._newgrounds){
				var logname = "Guest";
		
				if(global._nglogin){
					logname = ng_get_username();
				}
		
				scr_textrender_switchfont("dh_font1");
				scr_textrender_halign("right");
				scr_textrender_valign("bottom");
				scr_textrender_type(WIDTH,HEIGHT-64,"Logged in as: "+logname,true,c_white,1,1,1);
				scr_textrender_switchfont(global._defaultFont);
				scr_textrender_halign("left");
				scr_textrender_valign("top");
			}
		}
		
		if(_begin && _sqr_size > 0){
			draw_set_color(c_black);
			draw_rectangle(-256, floor(HEIGHT/2)-((HEIGHT/2)*_sqr_size),WIDTH+256,floor(HEIGHT/2)+((HEIGHT/2)*_sqr_size), false);
			draw_set_color(c_white);
		}
	}
}