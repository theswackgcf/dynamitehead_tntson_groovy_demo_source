{
	if(!_init){
		sfx_play(snd_dh_ko);
		_init = true;
	}
	if(check_keypress(global._input[global._inptype][? "confirm"], global._inptype)){
		room_goto(r_loading);
	}
}