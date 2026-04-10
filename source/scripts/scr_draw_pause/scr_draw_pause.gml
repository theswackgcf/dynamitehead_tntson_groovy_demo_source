function scr_draw_pause(){
	if(global._buildver != HTML){
		draw_set_color(#000000);
		draw_set_alpha(0.86);
		draw_rectangle(-256, -256, WIDTH+512, HEIGHT+512, false);
		draw_set_color(#FFFFFF);
		draw_set_alpha(1);
	} else {
		draw_sprite(spr_menu_settingbg, 0, global._screenOffsetX, global._screenOffsetY);
	}
	
	//pics
	if(_state == "main"){
		draw_sprite(spr_pausepics, _pauseOpts[_curOpt][3], _picspos+global._screenOffsetX, global._screenOffsetY);
			
		//pause letters
		_pauseTimer ++;
		
		//spinning
		if(_pauseTimer % 180 == 120){
			_pauseLetters[? 0][2] = 16;
		}
		if(_pauseTimer % 180 == 130){
			_pauseLetters[? 1][2] = 16;
		}
		if(_pauseTimer % 180 == 140){
			_pauseLetters[? 2][2] = 16;
		}
		if(_pauseTimer % 180 == 150){
			_pauseLetters[? 3][2] = 16;
		}
		if(_pauseTimer % 180 == 160){
			_pauseLetters[? 4][2] = 16;
		}
		
		var drawY = 210;
		var addX = 0;
		for(var i = 0; i < ds_map_size(_pauseLetters); i++){
			if(i > 0){
				addX += sprite_get_width(_pauseLetters[? i][0]);
			}
			
			_pauseLetters[? i][1] += _pauseLetters[? i][2];
			_pauseLetters[? i][2] -= 0.6;
			if(_pauseLetters[? i][2] <= 0){
				_pauseLetters[? i][2] = 0;
			}
			if(_pauseLetters[? i][1] >= 36){
				_pauseLetters[? i][1] = 0;
			}
			
			if(_pauseLetters[? i][2] <= 0){
				_pauseLetters[? i][1] = lerp(_pauseLetters[? i][1], 0, 0.05);
			}
			
			_pauseLetters[? i][3] ++;
			
			draw_sprite(_pauseLetters[? i][0], round(_pauseLetters[? i][1]), (floor(WIDTH/2-((_combinedWidth-86)/2))+addX)+_xoffset+global._screenOffsetX, drawY+(sin(_pauseLetters[? i][3]/12)*24)+global._screenOffsetY);
		}
		
		var bordsizey = array_length(_pauseOpts)/5;
		scr_drawtntborder(floor(WIDTH/2)+_xoffset+global._screenOffsetX, floor(HEIGHT/2)+96+global._screenOffsetY, 2.4, 1.6*bordsizey);
		
		scr_textrender_switchfont("dh_font2");
		scr_textrender_halign("right");
		var kos = string(global._knockouts);
		if(global._knockouts >= 10){
			kos = "9+";
		}
		var noun = "times";
		if(global._knockouts == 1){
			noun = "time";
		}
		
		if(global._state == "game"){
			scr_textrender_type(WIDTH-16, 12, "You've been\n/r'NOCKED/w "+kos+" "+noun+".", true, c_white, 1, 1.25, 1.25);
					
			if(array_length(global._plusmoney.cur) > 0){
				var totalmon = 0;
				var drawx = WIDTH-32;
				var drawy = HEIGHT-48;
				for(i = 0; i < array_length(global._plusmoney.cur); i++){
					totalmon += global._plusmoney.cur[i];
							
					draw_sprite_ext(spr_gui_dollar,0,drawx,drawy-55,0.55,0.55,0,c_white,1);
							
					drawx -= 72;
				}
				scr_textrender_type(WIDTH-16, drawy, "Extra cash: /y"+string(totalmon)+"/w", true, c_white, 1, 1.25, 1.25);
			}
		}
		if(global._state == "minigame"){
			scr_textrender_switchfont("dh_font1");
			
			var val = string(clamp(_curmonyx - _totalmonyx, 0, 9999999));
			var txt = val;
			if(_curmonyx > _totalmonyx){
				txt = "/y"+val+"/w";
			}
			scr_textrender_type(WIDTH-24, 24, string_pad(_curmonyx,"0",7)+"/"+string_pad(_totalmonyx,"0",7)+"/nMONYX EARNED: "+txt, true, c_white, 1, 1.25, 1.25);
			
			scr_textrender_switchfont(global._defaultFont);
		}
					
		scr_textrender_halign("left");
		scr_textrender_switchfont(global._defaultFont);
	}
		
	if(_state == "confirm"){
		draw_set_color(#000000);
		draw_set_alpha(0.5);
		draw_rectangle(-256, -256, WIDTH+512, HEIGHT+512, false);
		draw_set_color(#FFFFFF);
		draw_set_alpha(1);
			
		scr_drawtntborder(floor(WIDTH/2)+global._screenOffsetX, (floor(HEIGHT/2)+global._screenOffsetY)-12, 1.88, 0.96);
		
		scr_textrender_switchfont("dh_font2");
		scr_textrender_halign("center");
		scr_textrender_wave_y(global._menuSineAmp/2, global._menuSineSpd/2);
		scr_textrender_type(floor(WIDTH/2)+global._screenOffsetX, (floor(HEIGHT/2)-220)+global._screenOffsetY, string_upper(_confirmtitle), true, global._menuColorYes);
		scr_textrender_wave_y(0,0);
		
		var addtext = "";
		var addy = 0;
		if(_confirmbtn == "id_restart" && global._state == "minigame" && global._minigame == "lode"){
			addtext = "/nYOU WILL LOSE A LIFE!";
			addy = -20;
		}
		
		scr_textrender_type(floor(WIDTH/2)+global._screenOffsetX, (floor(HEIGHT/2)-96)+global._screenOffsetY+addy, "HEY! ARE YOU SURE?"+addtext, true, global._menuColorYes);
		scr_textrender_halign("left");
		scr_textrender_switchfont(global._defaultFont);
	}
				
	if(global._debug){
		scr_textrender_type(0,0,"ALT+P: hide/unhide pause");
	}
}