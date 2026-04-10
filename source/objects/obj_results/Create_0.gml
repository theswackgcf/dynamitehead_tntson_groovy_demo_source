{
	depth = -12000;
	
	_allsounds = ds_map_create();
	
	_dhx = -WIDTH;
	_winy = -HEIGHT;
	
	_dhslide = _dhx;
	_winslide = _winy;
	
	_winact = 0;
	_wintime = 0;
	_textsize = [0,0,0];
	_textactive = [false,false,false];
	_kotimer = 0;
	_tempKO = 0;
	_koHeight = 0;
	_koSpd = 0;
	_badnumb = ds_map_create();
	
	_winpitchtimer = 0;
	_pitchmod = 0;
	_pitchmodlerp = 0;
	
	_dhwinobj = noone;
	_bgwinobj = noone;
	_alphato = 0;
	_textspacing = [0, 0];
	
	_hellyeah = false;
	_spawnletter = [0,0,0,0,0,0,0,0];
	_letrpos = [
		[779,132],
		[890,140],
		[967,144],
		[1078,151],
		[732,318],
		[861,337],
		[972,325],
		[1100,329]
	];
	_curletter = 0;
	_lettertime = 0;
	
	_addcash_randcur = 0;
	
	_addcash_total = 0;
	
	_addcash_rand = [
		{
			xpos: WIDTH+250,
			xspd: -7,
			yspd: -24,
			scalespd: 0.026,
		},
		{
			xpos: WIDTH+300,
			xspd: -8,
			yspd: -23,
			scalespd: 0.025,
		},
		{
			xpos: WIDTH-500,
			xspd: 1,
			yspd: -24,
			scalespd: 0.027,
		}
	];
	
	_addcash_draw = false;
	_addcash_pos = [0,0];
	_addcash_spd = [0,0];
	_addcash_scale = 1;
	
	_addcash_amnt = 0;
	
	_addcash_spdmult = 1;
	
	_addcash_amp = 0;
	
	_confirmexit = false;
	_exit_enddemo = false;
}