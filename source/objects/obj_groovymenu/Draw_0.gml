{
	if(_displaymenu){
		scr_textrender_shake(0,0);
	
		switch(_menustate){
			case "main":
			case "quit":
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
				draw_sprite_ext(spr_demologo, 0, floor(WIDTH/2), ((centerpos+107)+_mainmenuoffset) + vertoffset, 0.8, 0.8, 0, c_white, 1);
				draw_sprite_ext(spr_menulogo, 0, floor(WIDTH/2), ((centerpos-128)+_mainmenuoffset) + vertoffset, 0.85, 0.85, 0, c_white, 1);
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
				draw_sprite_ext(spr_menu_wall, 0, 0, -160 + vertoffset + _mainmenuoffset, 1, 1.34, 0, c_white, 1);
			
				//logo
				draw_sprite_ext(spr_demologo, 0, 280, 190 + vertoffset + _mainmenuoffset, 0.6, 0.6, 0, c_white, 1);
				draw_sprite_ext(spr_menulogo, 0, 280, 0 + vertoffset + _mainmenuoffset, 0.7, 0.7, 0, c_white, 1);
			
				//buttons
				_optionhovered = false;
				for(var i = array_length(_btninfo)-1; i >= 0; i--){
					var col = make_color_rgb(51, 3, 17);
					var sine = 0;
					var ind = "1";
					var xoffset = -50;
					var subtext = "";
					if(_option == i){
						var canchoose = true;
						if(_btninfo[i][0] == "login" && _didlogin){
							canchoose = false;
						}
						
						if(canchoose){
							col = c_white;
							sine = 5;
							ind = "2";
						}
						
						if(_menustate == "main"){
							scr_textrender_shake(0, 2);
							scr_textrender_wave_x(sine, 10);
							scr_textrender_wave_y(sine, 10);
						}
						
						if(_btninfo[i][0] == "patreon"){
							subtext = "(EXTERNAL LINK)";
						}
					}
					var text = _btninfo[i][1];
					var xx = 252 + _btninfo[i][2] + xoffset;
					var yy = topoffset + (1 - _lerpedoption * btnspacing) + btnspacing * i;
				
					if(_option == i){
						_enterpos = yy;
					}
				
					scr_textrender_halign("center");
					scr_textrender_valign("middle");
				
					if(_menustate == "main"){
						if(global._timer % 5 < 2){
							scr_textrender_switchfont("dh_fontmenu1");
						} else {
							scr_textrender_switchfont("dh_fontmenu"+ind);
						}
					} else {
						scr_textrender_switchfont("dh_fontmenu1");
					}
				
					//draw menu icon
					if(_option != i){
						drawbtn(xx, yy, text, col, i, subtext);
					} else {
						if(surface_exists(_menubtn_surface)){
							surface_set_target(_menubtn_surface);
							draw_clear_alpha(c_black, 0);
						
							drawbtn(xx, yy, text, col, i, subtext);
						
							surface_reset_target();
						
							draw_surface_ext(_menubtn_surface, _enteroffset[0]+(sin(random(480))*_enteramp), _enteroffset[1]+(sin(random(480))*_enteramp), _enterscale[0], _enterscale[1], _enterangle, c_white, 1);
						} else {
							_menubtn_surface = surface_create(WIDTH, HEIGHT);
						}
					}
				
					//check hover
					var boxx = xx - scr_textrender_width(text) / 2;
					var boxy = yy - scr_textrender_height(text) / 2;
					var offsets = [-146,-48];
					if(_doinput){
						scr_textrender_switchfont("dh_fontmenu1");
						if(!_enter && point_in_rectangle(mouse_x, mouse_y, offsets[0]+boxx, offsets[1]+boxy, offsets[0]+boxx + (scr_textrender_width(text)-65), offsets[1]+boxy + (scr_textrender_height(text)-22))){
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
			case "extra":
				draw_sprite(spr_menu_settingbg, 0, 0, 0);
				
				var info = {
					offsY: 40,
					sizeY: 1.2,
				};
				if(global._buildver == HTML){
					info = {
						offsY: -9,
						sizeY: 0.9,
					};
				}
				
				scr_drawtntborder(floor(WIDTH/2)+global._screenOffsetX,(floor(HEIGHT/2)+global._screenOffsetY)+info.offsY, 1.85, info.sizeY);
			
				scr_textrender_switchfont("dh_font1");
				
				if(scr_compareinput("pause","menu_back")){
					scr_textrender_type(24, 24, "keycode@PAUSEkeycode - Back");
				} else {
					scr_textrender_type(24, 24, "keycode@MENU_BACKkeycode / keycode@PAUSEkeycode - Back");
				}
				
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
			case "minigames":
				//bg
				draw_sprite(spr_menu_settingbg, 0, 0, 0);
				
				scr_textrender_switchfont("dh_font1");
				
				//description bg
				draw_set_alpha(0.7);
				draw_set_color(c_black);
				draw_rectangle(WIDTH-488, 0, WIDTH, HEIGHT, false);
				draw_set_color(c_white);
				draw_set_alpha(1);
				
				if(!_monyx_screen){
					scr_textrender_shake(3);
				}
				scr_textrender_halign("right");
				scr_textrender_type(805, 630, "keycode@LEFTkeycode   keycode@RIGHTkeycode");
				scr_textrender_shake(0);
				
				//mini game
				var framepos = [440, 360];
				for(var i = 0; i < array_length(_minigame_desc_loop); i++){
					var offs = WIDTH*i;
					
					draw_sprite(spr_minigame_thumb, _minigame_desc_loop[i][1], framepos[0]+offs+_minigame_offset, framepos[1]);
					draw_sprite(spr_menu_frame, floor(_minigame_frame%2), framepos[0]+offs+_minigame_offset, framepos[1]);
				
					draw_sprite(spr_minigame_title, _minigame_desc_loop[i][1], WIDTH-254+offs+_minigame_offset, 148);
					scr_textrender_halign("center");
					scr_textrender_type(WIDTH-230+offs+_minigame_offset, 314, _minigame_desc_loop[i][0], false, c_white, 1, 0.8, 0.8);	
				}
				
				//begin button
				var col = make_color_rgb(51, 3, 17);;
				if(!_monyx_screen){
					col = c_white;
					scr_textrender_wave_x(4, 8);
					scr_textrender_wave_y(4, 8);
				}
				
				scr_textrender_switchfont("dh_fontmenu1");
				
				global._addSpacing = 6;
				scr_textrender_type(WIDTH-240, HEIGHT-130, "BEGIN", false, col, 1, 0.65, 0.65);
				global._addSpacing = 0;
				
				scr_textrender_halign("left");
				
				scr_textrender_wave_x(0, 0);
				scr_textrender_wave_y(0, 0);
				
				scr_textrender_switchfont("dh_font2");
				
				scr_textrender_shake(sin(random(480))*_priceshake, 0);
				scr_textrender_type(58, 87, "PRICE: "+string_pad(_minigame_monyx_loop[_minigame_cur][0], "0", 7), false, make_color_rgb(_monyx_col[0],_monyx_col[1],_monyx_col[2]), 1, 1.2, 1.2);
				scr_textrender_shake(0, 0);
				
				draw_sprite_ext(spr_menu_dollar, 0, 108, HEIGHT-74, 0.6, 0.6, 0, c_white, 1);
				scr_textrender_shake(sin(random(480))*_monyxshake, 0);
				scr_textrender_type(140, HEIGHT-86, "x"+string_pad(_curmonyx, "0", 10), false, make_color_rgb(_monyx_col[0],_monyx_col[1],_monyx_col[2]), 1, 1.2, 1.2);
				scr_textrender_shake(0, 0);
				
				//monyx screen
				if(_monyx_screen){
					draw_sprite(spr_menu_settingbg, 0, 0, 0);
					
					draw_set_alpha(0.65);
					draw_set_color(c_black);
					draw_rectangle(0, 0, WIDTH, HEIGHT, false);
					draw_set_color(c_white);
					draw_set_alpha(1);
				
					draw_sprite_ext(spr_minigame_title, _curminigame, 220, HEIGHT-164, 1, 1, 0, #454545, 1);
				
					scr_textrender_switchfont("dh_fontmenu1");
				
					scr_textrender_halign("center");
					
					if(_start_on || _minigame_begin){
						col = c_white;
						scr_textrender_wave_x(4, 8);
						scr_textrender_wave_y(4, 8);
					}
				
					global._addSpacing = 6;
					if(!_minigame_begin || (_minigame_begin && _minigame_beginshow)){
						scr_textrender_type(floor(WIDTH/2), HEIGHT-200, "START", false, col, 1, 0.85, 0.85);
					}
					global._addSpacing = 0;
				
					scr_textrender_wave_x(0, 0);
					scr_textrender_wave_y(0, 0);
					
					if(!_start_on && !_minigame_begin){
						scr_textrender_switchfont("dh_font1");
						scr_textrender_type(floor(WIDTH/2)+12, HEIGHT-180, "Not enough Monyx!/nBeat stages to earn more.", false, c_white, 1, 1, 1);
					}
				
					//monyx & price
					scr_textrender_switchfont("dh_font2");
				
					var monyxpos = [480, 135];
				
					draw_sprite_ext(spr_menu_dollar, 0, monyxpos[0]-220, monyxpos[1]+43, 0.84, 0.84, 0, c_white, 1);
					scr_textrender_shake(sin(random(480))*_monyxshake, 0);
					scr_textrender_type(monyxpos[0], monyxpos[1], "YOUR MONYX:\nx"+string_pad(_curmonyx, "0", 10), false, make_color_rgb(_monyx_col[0],_monyx_col[1],_monyx_col[2]), 1, 1.42, 1.42);
					scr_textrender_shake(0, 0);
					
					var pricepos = [WIDTH-360, 135];
					
					scr_textrender_shake(0, sin(random(480))*_diffshake);
					scr_textrender_type(pricepos[0], pricepos[1], "GAME PRICE:\n"+string_pad(_pricediff, "0", 7), false, c_white, 1, 1.42, 1.42);
					scr_textrender_shake(0, 0);
				
					//difficulty adjuster
					scr_textrender_type(floor(WIDTH/2), floor(HEIGHT/2)-64, "Adjust difficulty:", false, c_white, 1, 1.42, 1.42);
					var diffpos = [floor(WIDTH/2), floor(HEIGHT/2)+24];
					scr_textrender_type(diffpos[0], diffpos[1], "keycode@LEFTkeycode            keycode@RIGHTkeycode", false, c_white, 1, 1.36, 1.36);
					
					scr_textrender_shake(0, sin(random(480))*_diffshake);
					scr_textrender_type(diffpos[0], diffpos[1], "x"+string(_curdiff), false, c_white, 1, 1.8, 1.8);
					scr_textrender_shake(0, 0);
				
					scr_textrender_halign("left");
				}
				
				//back
				scr_textrender_switchfont("dh_font1");
				if(scr_compareinput("pause","menu_back")){
					scr_textrender_type(24, 24, "keycode@PAUSEkeycode - Back");
				} else {
					scr_textrender_type(24, 24, "keycode@MENU_BACKkeycode / keycode@PAUSEkeycode - Back");
				}
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
		
		if(_menustate == "quit"){
			draw_set_alpha(0.6);
			draw_set_color(c_black);
			draw_rectangle(-64,-64,WIDTH+64,HEIGHT+64,false);
			draw_set_color(c_white);
			draw_set_alpha(1);
				
			scr_drawtntborder(floor(WIDTH/2)+global._screenOffsetX,(floor(HEIGHT/2)+global._screenOffsetY), 1.95, 0.7);
			
			scr_textrender_halign("center");
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(floor(WIDTH/2)+global._screenOffsetX, 324+global._screenOffsetY, _quitmessages[_quitmessage],true);
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_halign("left");
			
			draw_sprite(spr_menu_quit,0,382+global._screenOffsetX,446+global._screenOffsetY);
			draw_sprite(spr_menu_quit,1,1012+global._screenOffsetX,446+global._screenOffsetY);
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