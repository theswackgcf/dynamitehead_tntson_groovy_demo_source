function scr_lode_game_init(newlevel = false){
	//things that happen every time you enter a new level
	global._lode_deletedStuff = ds_map_create();
	global._lode_spawnstuff = false;
	global._cur_variation = -1;
	if(!newlevel){
		//things that only happen once at the very first level
		global._lode_tutorial = true;
		global._lode_stage = 1;
		global._lode_lives = 3;
		global._lode_tnt = 0;
		global._lode_score = 0;
		global._lode_curboss = 1;
		global._lode_loopback = false;
		global._lode_curloop = 0;
		global._lode_score_store = 0;
		global._lode_spd = 1;
		
		if(global._minigame_diff > 0){
			var steps = global._minigame_diff*10;
			repeat(steps){
				global._lode_stage ++;
				if(global._lode_stage > 10){
					global._lode_stage = 0;
					global._lode_curloop ++;
				}
			}
		}
	} else {
		global._lode_tutorial = false;
		global._lode_score_store = global._lode_score;
		global._lode_tnt_store = global._lode_tnt;
	}
}