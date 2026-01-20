event_inherited();
if(!global._pause){
	_timer ++;
	_height = _startheight + (sin(_timer/6)*32);
	if(_height < _groundlevel){
		_height = _groundlevel;
	}
	_xspd += 0.6;
	if(_xspd >= 32){
		_xspd = 32;
	}
}