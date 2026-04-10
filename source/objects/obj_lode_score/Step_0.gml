{
	if(!global._pause && !global._gameover_stopall){
		if(_project){
			y -= 0.3;
			_alp -= 0.01;
			if(_alp <= 0){
				_project = false;
			}
			
			var str = string(_score);
			if(_text != ""){
				str = _text;
			}
			
			scr_lode_project(-1,0,[x,y],[1,1],_depth,0,c_white,clamp(_alp,0,1),str);
		} else {
			_deadtimer ++;
			if(_deadtimer >= 2){
				scr_lode_remove_project();
				instance_destroy();
			}
		}
	}
}