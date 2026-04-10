function minigame_lose_draw(width,height,losespr,monyxval,textscale){
	if(global._gameover_stopall){
		//lost
		draw_set_alpha(0.76);
		draw_set_color(c_black);
		draw_rectangle(0, 0, width, height, false);
		draw_set_color(c_white);
		draw_set_alpha(1);
			
		draw_sprite(losespr, 0, floor(width/2), height*0.28);
			
		if(_over_act == 2){
			//counting up
			scr_textrender_halign("center");
			var st = _lose_score_string;
			if(_lose_score > monyxval){
				st = "/y"+_lose_score_string+"/w";
			}
			scr_textrender_type(floor(width/2),floor(height*0.54),"SCORE:\n"+st+"/"+_monyx_string, true, c_white, 1, textscale, textscale);
			scr_textrender_halign("left");
		}
		if(_over_act >= 3){
			//final earned amount
			scr_textrender_halign("center");
			var num = string_pad(_earned, "0", 7);
			var st = num;
			if(_lose_score > monyxval){
				st = "/y"+num+"/w";
			}
			scr_textrender_type(floor(width*0.5)-(width*0.22),floor(height*0.54),"YOUR SCORE:\n"+_lose_score_string, true, c_white, 1, textscale, textscale);
			scr_textrender_type(floor(width*0.5)+(width*0.22),floor(height*0.54),"MONYX EARNED:\n"+st, true, c_white, 1, textscale, textscale);
			scr_textrender_halign("left");
		}
		if(_over_act >= 4){
			//press to leave
			scr_textrender_halign("right");
			scr_textrender_valign("bottom");
				
			var confirmkey = "keycode@CONFIRMkeycode";
			var menuselectkey = "keycode@MENU_SELECTkeycode";
				
			if(global._font == "dh_fontnes" || global._font == "dh_fontnes_lode"){
				confirmkey = key_to_string(global._input[global._inptype][? "confirm"]);
				menuselectkey = key_to_string(global._input[global._inptype][? "menu_select"]);
			}
				
			var conpos = [width-(width*0.009),height-(height*0.038)];
			if(scr_compareinput("confirm","menu_select")){
				scr_textrender_type(conpos[0], conpos[1], "Press "+confirmkey+" - Back to menu", true);
			} else {
				scr_textrender_type(conpos[0], conpos[1], "Press "+menuselectkey+" or "+confirmkey+" - Back to menu", true);
			}
				
			scr_textrender_halign("left");
			scr_textrender_valign("top");
		}
	}
}