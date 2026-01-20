{
	depth = 5000;
	
	if(!global._pause){
		if(_parentobj != noone && instance_exists(_parentobj)){
			_start = _parentobj._start;
			_stoptimer = _parentobj._stoptimer;
			_curframe = _parentobj._curframe;
		}
		
		visible = _start;
	}
}