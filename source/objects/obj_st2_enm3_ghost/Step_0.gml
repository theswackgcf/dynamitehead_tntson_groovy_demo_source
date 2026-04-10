event_inherited();
if(!global._pause){
	_timer ++;
	_dispoffset[1] = _startoffset + (sin(_timer/7)*28);
	if(_height < _groundlevel){
		_height = _groundlevel;
	}
	_xspd += 0.4;
	if(_xspd >= 26){
		_xspd = 26;
	}
}