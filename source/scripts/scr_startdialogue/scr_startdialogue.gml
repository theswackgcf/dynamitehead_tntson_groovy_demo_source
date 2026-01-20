function scr_startdialogue(scriptname, dir, starttimer, stopmove = false, act = 0){
	with(obj_dialogue){
		if(!_show){
			_show = true;
			_scrindex = scriptname;
			_scrdir = dir;
			_curpg = 0;
			_diag_init = false;
			_starttimer = starttimer;
			_diag_act = act;
			_stopmove = stopmove;
		}
	}
}