///scr_textrender_halign(halign)
function scr_textrender_halign(halign){
	if(global._fontInit){
		switch(halign){
			case "left":
				global._halign = 0;
			break;
			case "center":
				global._halign = 1;
			break;
			case "right":
				global._halign = 2;
			break;
		}
	}
}