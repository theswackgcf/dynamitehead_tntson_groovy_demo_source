{
	if(global._buildver == HTML){
		instance_destroy();
	}
	
	depth = -11003;
	if(_optionsobj != noone){
		if(!_optionsobj._show || _ypos <= -96){
			instance_destroy();
		}
	}
	
	_timer ++;
	
	_ampX -= 0.03;
	_ampY -= 0.03;
	if(_ampX <= 1){
		_ampX = 1;
	}
	if(_ampY <= 1){
		_ampY = 1;
	}
	_ypos -= 5;
	_xpos = _startx + ((sin(_timer/18)*_ampX)*10);
	
	_alpha -= 0.02;
	if(_alpha <= 0){
		instance_destroy();
	}
}