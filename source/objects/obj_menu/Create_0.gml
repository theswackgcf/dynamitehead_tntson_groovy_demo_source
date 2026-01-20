{
	_allsounds = ds_map_create();
	
	_menustate = "main";
	_curopt = [0, 0];
	
	_confirm = false;
	
	_mainopts = [
		"PLAY NOW!",
		"HOW TO PLAY ??",
		"SOUND SETTING",
		"BYE!!!!!!!!!",
	];
	
	_settopts = [
		"master volume:",
		"music volume:",
		"sound effect volume:",
		"voice act volume:",
	];
	
	_howtoframe = 0;
}