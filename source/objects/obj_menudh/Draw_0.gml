{
	draw_sprite(sprite_index, image_index, x, y);
	
	if(_menuobj != noone){
		if(_menuobj._changedinput){
			var whichkey;
			if(global._inptype == 0){
				whichkey = vk_escape;
			} else if(global._inptype == 1){
				whichkey = gp_select;
			}
			var textinput = "Default input has been changed.\nHold "+key_to_string(whichkey)+" to reset your input";
			var drawpos = [4,4];
			scr_textrender_halign("left");
			scr_textrender_valign("top");
			scr_textrender_type(drawpos[0],drawpos[1],textinput,true,c_white,1,0.55,0.55);

			if(_menuobj._changehold > 0){
				var rectpos = [4,48];
				draw_set_color(#000000);
				draw_rectangle(rectpos[0], rectpos[1], 260, rectpos[1]+18, false);
				draw_set_color(#FFFF00);
				draw_rectangle(rectpos[0], rectpos[1], rectpos[0]+((_menuobj._changehold/60)*256), rectpos[1]+18, false);
			}
		}
	}
}