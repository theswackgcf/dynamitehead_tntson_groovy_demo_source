{
	_allsounds = ds_map_create();
	
	_start = false;
	_act = 0;
	_bossnum = 1; //base 0
	_timer = 0;
	
	_bossnames = ["FRANKENBARF","LANKY\n   LARRY"];
	_bossposarray = [
		[0,0],
		[240,390],
	];
	_bossname = _bossnames[_bossnum];
	_bosspos = [_bossposarray[_bossnum][0],_bossposarray[_bossnum][1]];
	_bossoffset = [0,0];
	
	_bosslines = [
		[],
		[snd_lanky_intro1,snd_lanky_intro2,snd_lanky_intro3,snd_lanky_intro4,snd_lanky_intro5,snd_lanky_intro6]
	];
	_voice = false;
	
	_addamp = 0;
}