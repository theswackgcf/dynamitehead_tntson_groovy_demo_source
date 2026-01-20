if(global._buildver != HTML){
	switch(async_load[? "event_type"]){
		case "gamepad discovered":
			scr_gamepadasync("discovered",true);
	    break;
		case "gamepad lost":
			scr_gamepadasync("lost",true);
	    break;
	}
}
