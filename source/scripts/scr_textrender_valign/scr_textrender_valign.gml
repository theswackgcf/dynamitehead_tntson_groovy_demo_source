///scr_textrender_valign(valign)
function scr_textrender_valign(valign){
	if(global._fontInit){
		switch(valign){
			case "top":
				global._valign = 0;
			break;
			case "middle":
				global._valign = 1;
			break;
			case "bottom":
				global._valign = 2;
			break;
		}
	}
}