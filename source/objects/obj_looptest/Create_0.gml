{
	_musiclist = [];
	_mushover = -1;
	
	_muslistoffset = [floor(WIDTH/2)+300,180];
	_muslistsize = [320, 32];
	
	_groups = [
		audiogroup_music
	];
	
	_init = false;
	
	_soundpos = 0;
	_soundpercent = 0;
	
	_looppoint = 0;
	_looppercent = 0;
	
	_playing = true;
	_stopped = false;
	
	_surpassedloop = false;
	
	_trackoffset = [256,256];
	_tracksize = [512,24];
}