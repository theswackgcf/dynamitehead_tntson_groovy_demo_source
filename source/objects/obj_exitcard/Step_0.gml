{
	if(!_exitinit){
		mus_stop();
		with(obj_camera){
			_ampX = 20;
			_ampY = 20;
		}
		_exitinit = true;
	}
	_exitimer ++;
	
	if(_amp > 0){
		_amp --;
		_offsetx = sin(random(480))*_amp;
		_offsety = cos(random(480))*_amp;
	}
	
	if(_exitimer >= 90){
		game_end();
	}
}