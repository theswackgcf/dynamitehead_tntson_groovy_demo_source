{
	if(!_init){
		global._lights_switchroom = true;
		
		audio_play_sound(snd_light_off, 0, false);
		_init = true;
	}
	
	_timer ++;
	if(_timer >= 10){
		audio_stop_all();
		global._loadState = "boss2";
		room_goto(r_loading);
	}
}