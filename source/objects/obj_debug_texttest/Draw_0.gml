{
	if(_page <> 7){
		_typetext = "";
		_curchar = 1;
		
		_keysArray = [];
	}
	switch(_page){
		case 0:
			//intro page
			scr_textrender_switchfont("dh_font4");
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			
			scr_textrender_type(floor(WIDTH/2),floor(HEIGHT/2),"DynamiteHead Text Engine\nTest room");
		break;
		case 1:
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(32,32,"Font switching\nYou can switch fonts on the fly");
			
			scr_textrender_switchfont("dh_font1");
			scr_textrender_type(32,164,"The quick brown fox jumps over the lazy dog.");
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(32,240,"Sphinx of black quartz, judge my vow.");
			scr_textrender_switchfont("dh_font4");
			scr_textrender_type(32,320,string_upper("The five boxing wizards\njump quickly."));
			scr_textrender_switchfont("dh_fontnes");
			scr_textrender_type(32,HEIGHT-96,string_upper("By Jove, my quick study of\nlexicography won a prize!"), false, c_white, 1, 3, 3);
		break;
		case 2:
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(32,32,"Align text with textrenderer align scripts");
			
			scr_textrender_switchfont("dh_font1");
			
			scr_textrender_type(32,120,"left top");
			
			scr_textrender_halign("center");
			scr_textrender_valign("top");
			scr_textrender_type(WIDTH/2,120,"center top");
			
			scr_textrender_halign("right");
			scr_textrender_valign("top");
			scr_textrender_type(WIDTH-32,120,"right top");
			
			
			scr_textrender_halign("left");
			scr_textrender_valign("middle");
			scr_textrender_type(32,(HEIGHT/3)+96,"left middle");
			
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			scr_textrender_type(WIDTH/2,(HEIGHT/3)+96,"center middle");
			
			scr_textrender_halign("right");
			scr_textrender_valign("middle");
			scr_textrender_type(WIDTH-32,(HEIGHT/3)+96,"right middle");


			scr_textrender_halign("left");
			scr_textrender_valign("bottom");
			scr_textrender_type(32,HEIGHT-96,"left bottom");
			
			scr_textrender_halign("center");
			scr_textrender_valign("bottom");
			scr_textrender_type(WIDTH/2,HEIGHT-96,"center bottom");
			
			scr_textrender_halign("right");
			scr_textrender_valign("bottom");
			scr_textrender_type(WIDTH-32,HEIGHT-96,"right bottom");
		break;
		case 3:
			scr_textrender_halign("left");
			scr_textrender_valign("top");
		
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(32,32,"Check width and height of your text\nNative screen size is 1280x720.");
			
			scr_textrender_switchfont("dh_font1");
			var text = "";
			var w = 0;
			var h = 0;
			var xx = 0;
			var yy = 0;
			
			text = "This is a textbox number one\nPress keycode>SPACEkeycode if you're feeling lucky.\nPress keycode>UPkeycode or keycode>DOWNkeycode to do nothing.";
			w = scr_textrender_width(text);
			h = scr_textrender_height(text);
			xx = 32;
			yy = 120;
			
			draw_set_color(c_red);
			draw_rectangle(xx,yy,xx+w,yy+h,true);
			scr_textrender_type(xx,yy,text);
			draw_set_color(c_white);
			draw_text(xx+w,yy+h,string(w)+"\n"+string(h));
			
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			text = "This is a textbox number two\nkeycode>CAPS LOCKkeycode keycode>L CTRLkeycode keycode>SHIFTkeycode\n all these keys do something.";
			w = scr_textrender_width(text);
			h = scr_textrender_height(text);
			xx = WIDTH/2;
			yy = (HEIGHT/2)+72;
			
			draw_set_color(c_green);
			draw_rectangle(xx-(w/2),yy-(h/2),xx+(w/2),yy+(h/2),true);
			scr_textrender_type(xx,yy,text);
			draw_set_color(c_white);
			draw_text(xx+(w/2),yy+(h/2),string(w)+"\n"+string(h));
			
			scr_textrender_halign("right");
			scr_textrender_valign("bottom");
			text = "This is a textbox number three\nThis is how it keycode>ENDkeycodes.";
			w = scr_textrender_width(text);
			h = scr_textrender_height(text);
			xx = WIDTH-64;
			yy = HEIGHT-64;
			
			draw_set_color(c_blue);
			draw_rectangle(xx-w,yy-h,xx,yy,true);
			scr_textrender_type(xx,yy,text);
			draw_set_color(c_white);
			draw_text(xx,yy,string(w)+"\n"+string(h));
		break;
		case 4:
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(32,32,"Text can have visual effects too");
			
			scr_textrender_switchfont("dh_font1");
			scr_textrender_type(32,180,"COLORED TEXT! This text can display\nall kinds of colors. Like /rRED/w, /gGREEN/w, /bBLUE/w.. and even /yYELLOW/w!");
			
			scr_textrender_type(32, 300, "Press keycode>UPkeycode or keycode>DOWNkeycode to switch shake and wave modes");
			
			scr_textrender_switchfont("dh_font2");
			scr_textrender_shake(_shakeval[0],_shakeval[1]);
			scr_textrender_type(32,400,"An /yearthquake/w? In /bmarch/w?! /rNo way/w!");
			scr_textrender_shake(0,0);
			
			scr_textrender_switchfont("dh_font2_big");
			scr_textrender_wave_x(_waveval[1][0], _waveval[1][1]);
			scr_textrender_wave_y(_waveval[0][0], _waveval[0][1]);
			scr_textrender_type(32,480,"Feel the /bwaves.../w");
			scr_textrender_wave_x(0,0);
			scr_textrender_wave_y(0,0);
			
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(32,640,"Transparent text", false, c_white, 0.3);
			scr_textrender_type(132,640,"Transparent text", false, c_white, 0.3);
			scr_textrender_type(232,640,"Transparent text", false, c_white, 0.3);
		break;
		case 5:
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(32,32,"Text is also resizable");
			
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			
			scr_textrender_type(WIDTH/2, (HEIGHT/2)-300, "X SCALING keycode>LEFTkeycode keycode>RIGHTkeycode", false, c_white, 1, 1+(sin(_timer/20)*0.6),1);
			scr_textrender_type(WIDTH/2, (HEIGHT/2), "Y SCALING keycode>UPkeycode keycode>DOWNkeycode", false, c_white, 1, 1, 1+(cos(_timer/20)*0.6));
			scr_textrender_type(WIDTH/2, (HEIGHT/2)+300, "keycode>LEFTkeycode keycode>RIGHTkeycodeX&Y SCALING keycode>UPkeycode keycode>DOWNkeycode", false, c_white, 1, 1+(sin(_timer/20)*0.6), 1+(cos(_timer/20)*0.6));
		break;
		case 6:
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(32,32,"Space text out in all kinds of ways");

			scr_textrender_halign("center");

			var statickey1 = "keycode>LEFTkeycode";
			var statickey2 = "keycode>RIGHTkeycode";

			global._addSpacing = -5;
			scr_textrender_type(WIDTH/2,140,statickey2+"It's really thin"+statickey1);
			
			global._addSpacing = 20;
			scr_textrender_type(WIDTH/2,260,statickey1+"It's really wide"+statickey2);
			
			global._addSpacing = sin(_timer/25)*10;
			var key1 = "keycode>RIGHTkeycode";
			var key2 = "keycode>LEFTkeycode";
			if(global._addSpacing > 0){
				key1 = "keycode>LEFTkeycode";
				key2 = "keycode>RIGHTkeycode";
			}
			scr_textrender_type(WIDTH/2,380,key1+"The spacing is changing"+key2);
		break;
		case 7:
			if(array_length(_keysArray) < 1){
				_keysArray = scr_dialogue_setkeys(_curtext, _keysArray);
			}
		
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(32,32,"Typewriting effect");
			
			scr_textrender_switchfont("dh_font1");
			
			scr_textrender_type(32,96,_typetext);
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			scr_textrender_type(WIDTH/2,400,_typetext);
			scr_textrender_halign("right");
			scr_textrender_valign("bottom");
			scr_textrender_type(WIDTH-32,HEIGHT-24,_typetext);
		break;
		case 8:
			_page -= 1;
		break;
	}
	
	global._addSpacing = 0;
	scr_textrender_halign("left");
	scr_textrender_valign("top");
	scr_textrender_switchfont(global._defaultFont);
	
	scr_textrender_switchfont("dh_font2");
}