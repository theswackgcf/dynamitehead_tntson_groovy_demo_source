{
	//battlezone maker
	if(global._bzmaker){
		var bzalp = clamp(sin(_bztimer)+1,0,1);
		scr_textrender_halign("center");
		var addtext = "";
		if(!global._battlezone){
			addtext = "\nEnter a battlezone to begin";
		}
		if(mouse_check_button(mb_left) && _hovertimer > 0){
			addtext = "\nPress any arrow key\nTo position enemy to the sides\nBackspace: center";
		}
		scr_textrender_type(floor(WIDTH/2),128, "Battlezone maker"+addtext, true, c_white, bzalp);
		scr_textrender_halign("left");
			
		if(global._battlezone){
			if(global._battleobj != noone && instance_exists(global._battleobj)){
				scr_textrender_type(0, 16, "Wave count: "+string(array_length(global._bzone_enemies))+"\nCurrent wave: "+string(global._battleobj._curwave)+"\nAdd wave: + (numpad)\nRemove wave: - (numpad)\n\nLeft Mouse Click: spawn enemy\nRight Mouse Click: destroy enemy\nMiddle scroll: Change enemy's alt\nQ/W: Change enemy's order\nR/T: Change enemy's spawn type\nY: Set fade in\nShift: Log spawn information\nEnter: Activate all enemies", true, #FFFFFF, 0.75, 0.6,0.6);
					
				//popup
				if(_bzpopup){
					var startpos = [_bz_mousestart[0],_bz_mousestart[1]];
					var enmpos = [startpos[0],startpos[1]];
					var maxwidth = 0;
					_popupopt = -1;
					for(var e = 0; e < array_length(global._bzenemies); e++){
						var enmtext = global._bzenemies[e].dispname;
						draw_set_color(c_black);
						draw_rectangle(enmpos[0], enmpos[1],enmpos[0]+scr_textrender_width(enmtext),enmpos[1]+scr_textrender_height(enmtext), false);
						if(scr_textrender_width(enmtext)> maxwidth){
							maxwidth = scr_textrender_width(enmtext);
						}
						draw_set_color(c_white);
						var colr = make_color_rgb(100,100,100);
							
						if(scr_mousehover(enmpos[0], enmpos[1],enmpos[0]+scr_textrender_width(enmtext),enmpos[1]+scr_textrender_height(enmtext), true)){
							colr = c_white;
							_popupopt = e;
						}
							
						scr_textrender_type(enmpos[0], enmpos[1], enmtext, true, colr);
						enmpos[1] += scr_textrender_height(enmtext);
						if(enmpos[1] >= startpos[1]+280){
							enmpos[0] += maxwidth+64;
							enmpos[1] = startpos[1];
						}
					}
				}
			}
		}
	}
}