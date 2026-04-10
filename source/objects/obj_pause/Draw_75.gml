{
	if(global._pause){
		if(!global._debughidepause){
			scr_draw_pause();
		}
	} else {
		_pauseTimer = 0;
		for(var i = 0; i < ds_map_size(_pauseLetters); i++){
			_pauseLetters[? i][1] = 0;
			_pauseLetters[? i][2] = 0;
			_pauseLetters[? i][3] = random(512);
		}
	}
}