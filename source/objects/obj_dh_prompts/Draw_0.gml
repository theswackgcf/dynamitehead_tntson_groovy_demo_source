{
	//prompts
	if(global._showtips || global._tutorial){
		if(_help_prompt > 0 && _prompt_type != ""){
			var texttodraw = "";
			var posoffset = [0,-180];
			var scale = 1.3;
			switch(_prompt_type){
				case "grab":
					posoffset[1] = -365;
					texttodraw = "keycode@GRABkeycode";
					scale = 1.6;
				break;
				case "slamleft":
					posoffset[0] = -360;
					texttodraw = "keycode@LEFTkeycode";
				break;
				case "slamright":
					posoffset[0] = 360;
					texttodraw = "keycode@RIGHTkeycode";
				break;
			}
				
			scr_textrender_halign("center");
			scr_textrender_wave_y(12, 4, true);
			scr_textrender_type(x+posoffset[0], y+posoffset[1], texttodraw, true, c_white, 1, scale, scale);
			scr_textrender_wave_y(0, 0);
			scr_textrender_halign("left");
		}
	}
}