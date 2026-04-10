event_inherited();
if(!global._pause){
	if(_parentobj == noone){
		_parentobj = instance_nearest(x,y,obj_boss2_mask);
	}
	_timer ++;
	_dispoffset[1] = _startoffset + (sin(_timer/6)*32);
	if(_height < _groundlevel){
		_height = _groundlevel;
	}
	_xspd += 0.4;
	if(_xspd >= 26){
		_xspd = 26;
	}
}