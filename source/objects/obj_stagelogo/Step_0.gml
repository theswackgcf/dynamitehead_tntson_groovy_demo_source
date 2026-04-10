{
	depth = -2000;
	
	_timer ++;
	if(_timer >= 16){
		if(!_out){
			_lerpspacing = lerp(_lerpspacing, 0, 0.17);
		} else {
			_lerpspacing += _outspd;
			_outspd += 1.26;
		}
	}
	
	if(_timer >= 210){
		_out = true;
	}
}