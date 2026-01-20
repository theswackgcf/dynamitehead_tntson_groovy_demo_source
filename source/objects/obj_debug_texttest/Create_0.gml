{
	_timer = 0;
	_page = 0;
	
	_text = "Holding keycode>LEFTkeycode makes you go Right. Holding keycode>RIGHTkeycode makes you go up. Holding keycode>DOWNkeycode and pressing keycode>SPACEkeycode makes you go diagonally. Holding keycode>UPkeycode, keycode>CAPS LOCKkeycode and keycode>SHIFTkeycode summons an /rancient god/w. Now that's what I call GREAT game design!";
	//_text = "Holding LEFT makes you go Right. Holding RIGHT makes you go up. Holding DOWN and pressing SPACE makes you go diagonally. Holding UP, CAPS LOCK and SHIFT summons an /rancient god/w. Now that's what I call GREAT game design!";
	_typetext = "";
	_curtext = scr_wordwrap(_text, WIDTH-128, "\n", false);
	
	_curchar = 1;
	
	_keysArray = [];
	
	_textval = 0;
	_shakeval = [0,0];
	_waveval = [0,0];
}